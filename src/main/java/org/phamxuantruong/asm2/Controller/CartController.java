package org.phamxuantruong.asm2.Controller;

import java.util.Date;
import java.util.List;

import org.phamxuantruong.asm2.Entity.Bill;
import org.phamxuantruong.asm2.Entity.Cart;
import org.phamxuantruong.asm2.Entity.Product;
import org.phamxuantruong.asm2.Entity.Users;
import org.phamxuantruong.asm2.Interface.BillDAO;
import org.phamxuantruong.asm2.Interface.CartDAO;
import org.phamxuantruong.asm2.Interface.ProductDAO;
import org.phamxuantruong.asm2.Interface.UsersDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;

@Controller
public class CartController {
	@Autowired
	UsersDAO userDAO;
	@Autowired
	ProductDAO productDAO;
	@Autowired
	CartDAO cartDAO;
	@Autowired
	BillDAO billDAO;

	@GetMapping("/cart")
	public String getCart(Model model, HttpSession session) {
		String username = (String) session.getAttribute("loggedInUser");
		if(username == null) { // nếu ko có tài khoản thì chuyển về trang đăng nhập
			model.addAttribute("error", "Vui lòng đăng nhập tài khoản");
			return "redirect:/user/login";
		}
		List<Cart> data = cartDAO.findByUsername(username);	// lấy tất cả dữ liệu giỏ hàng từ username người dùng
		Double amount = 0.0, shiping = 0.0, total = 0.0;	// khai báo tiền sản phẩm, phí ship và tổng tiền
		for (Cart cart : data) {		// duyệt tất cả giỏ hàng trong danh sách
			amount += cart.getTotal();	// cộng dồn tiền của từng mặt hàng vào tổng
		}
		shiping = amount * 0.05;		// phí ship = 5% của tổng sản phẩm
		total = amount + shiping;		// tổng tiền tất cả = tổng sản phẩm + phí ship
		model.addAttribute("listCart", data);
		model.addAttribute("amount", amount);
		model.addAttribute("shiping", shiping);
		model.addAttribute("total", total);
		model.addAttribute("sizeCart", cartDAO.countByUsername(username));
		return "home/cart";
	}

	@GetMapping("/addcart")
	public String addCart(Model model, HttpSession session, @RequestParam("id") Long proID) {
		String username = (String) session.getAttribute("loggedInUser");
		if(username == null) { // nếu ko có tài khoản thì chuyển về trang đăng nhập
			model.addAttribute("error", "Vui lòng đăng nhập tài khoản");
			return "redirect:/user/login";
		}

		System.out.println("Adding product to cart with ID: " + proID);
		Long idCart = cartDAO.findByUsernameAndProductID(username, proID); // lấy idcart từ id người dùng và id sản phẩm
		Product pro = productDAO.findById(proID).get();						// lấy sản phẩm từ id sản phầm
		Cart cart = null;

		// nếu idcart = null => người dùng chưa có sản phẩm này trong giỏ hàng thì thêm 1 sản phẩm vào giỏ hàng
		if(idCart == null) cart = new Cart(null, userDAO.findById(username).get(), pro, 1, 0.0, pro.getPrice());
		else {	// ngược lại nếu người dùng đã có sản phẩm trong giỏ thì cập nhật số lượng tăng 1, cập nhật giá tiền
			cart = cartDAO.findById(idCart).get();				// lấy giỏ hàng hiện tại theo idcart
			cart.setQuantity(cart.getQuantity() + 1);			// cập nhật số lượng mới = số lượng cũ + 1
			cart.setTotal(pro.getPrice() * cart.getQuantity());	// cập nhật giá tiền mới = giá sản phẩm * số lượng mới
		}

		cartDAO.saveAndFlush(cart);		// lưu giỏ hàng vào csdl

		return "redirect:/shop";
	}

	@GetMapping("/setcart")
	public String setCart(Model model, HttpSession session, @RequestParam("id") Long proID, @RequestParam("quantity") int quantity) {
		String username = (String) session.getAttribute("loggedInUser");
		if(username == null) {	// nếu ko có tài khoản thì chuyển về trang đăng nhập
			model.addAttribute("error", "Vui lòng đăng nhập tài khoản");
			return "redirect:/user/login";
		}

		Long idCart = cartDAO.findByUsernameAndProductID(username, proID);	// lấy idcart từ id người dùng và id sản phẩm

		if(quantity < 1) cartDAO.deleteById(idCart);	// nếu số lượng nhỏ hơn 1 thì xoá idcart ra khỏi giỏ hàng
		else {	// ngược lại thì cập nhật số lượng, tổng tiền cho giỏ hàng
			System.out.println("Update product in cart with ID: " + idCart);
			Cart oldCart = cartDAO.findById(idCart).get();				// lấy giỏ hàng theo id cart
			oldCart.setQuantity(quantity);								// cập nhật số lượng mới
			oldCart.setTotal(oldCart.getProduct().getPrice()*quantity);	// cập nhật giá tiền = giá sản phẩm * số lượng mới
			cartDAO.saveAndFlush(oldCart);								// lưu giỏ hàng vào csdl
		}

		return "redirect:/cart";
	}

	@GetMapping("/delcart")
	public String delCart(Model model, HttpSession session, @RequestParam("id") Long proID) {
		String username = (String) session.getAttribute("loggedInUser");
		if(username == null) {
			model.addAttribute("error", "Vui lòng đăng nhập tài khoản");
			return "redirect:/user/login";
		}

		Long idCart = cartDAO.findByUsernameAndProductID(username, proID);
		System.out.println("Delete product in cart with ID: " + idCart);
		cartDAO.deleteById(idCart);

		return "redirect:/cart";
	}

	@GetMapping("/checkout")
	public String showCheckoutPage(Model model, HttpSession session) {
		String username = (String) session.getAttribute("loggedInUser");
		if (username == null) {
			model.addAttribute("error", "Vui lòng đăng nhập tài khoản");
			return "redirect:/user/login";
		}

		// Lấy thông tin người dùng và giỏ hàng để hiển thị trên trang thanh toán
		Users user = userDAO.findById(username).orElse(null);
		List<Cart> cartItems = cartDAO.findByUsername(username);

		if (cartItems.isEmpty()) {
			model.addAttribute("error", "Giỏ hàng trống");
			return "redirect:/cart";
		}

		model.addAttribute("user", user);
		model.addAttribute("listCart", cartItems);

		// Tính toán tổng tiền và phí giao hàng nếu có
		Double total = cartItems.stream().mapToDouble(Cart::getTotal).sum();
		Double shipping = 50000.0; // Ví dụ phí giao hàng là 50,000 VND
		Double amount = total + shipping;

		model.addAttribute("total", total);
		model.addAttribute("shipping", shipping);
		model.addAttribute("amount", amount);

		return "home/checkout";
	}


	@PostMapping("/checkout")
	public String processCheckout(
			@RequestParam String fullname,
			@RequestParam String email,
			@RequestParam String phoneNumber,
			@RequestParam String address,
			@RequestParam String payment,
			Model model, HttpSession session) {

		String username = (String) session.getAttribute("loggedInUser");
		if (username == null) {
			model.addAttribute("error", "Vui lòng đăng nhập tài khoản");
			return "redirect:/user/login";
		}

		List<Cart> cartItems = cartDAO.findByUsername(username);
		if (cartItems.isEmpty()) {
			model.addAttribute("error", "Giỏ hàng trống");
			return "redirect:/cart";
		}

		// Tạo hóa đơn mới
		Bill bill = new Bill();
		bill.setUser(userDAO.findById(username).get());
		bill.setFullname(fullname);
		bill.setEmail(email);
		bill.setPhoneNumber(phoneNumber);
		bill.setAddress(address);
		bill.setPaymentMethod(payment);
		bill.setOrderDate(new Date()); // Lấy thời gian thực tại thời điểm thanh toán

		// Tính toán tổng tiền và lưu thông tin sản phẩm vào hóa đơn
		Double total = 0.0;
		for (Cart cartItem : cartItems) {
			total += cartItem.getTotal();
			// Thêm chi tiết sản phẩm vào hóa đơn nếu cần
		}
		bill.setTotal(total);

		Double shipping = 50000.0; // Ví dụ phí giao hàng là 50,000 VND
		Double amount = total + shipping;
		// Lưu hóa đơn vào database
		billDAO.save(bill);

		// Xóa giỏ hàng sau khi thanh toán thành công
		cartDAO.deleteAll(cartItems);

		model.addAttribute("message", "Đặt hàng thành công");
		model.addAttribute("bill", bill);
		model.addAttribute("listCart", cartItems);
		model.addAttribute("total", total);
		model.addAttribute("shipping", shipping);
		model.addAttribute("amount", amount);

		return "home/doneCheck"; // Chuyển đến trang thông báo thành công
	}





//
//	@GetMapping("/checkout")
//	public String getCheckOut(Model model, HttpSession session) {
//		String username = (String) session.getAttribute("loggedInUser");
//		if(username == null) {
//			model.addAttribute("error", "Vui lòng đăng nhập tài khoản");
//			return "redirect:/user/login";
//		}
//
//		List<Cart> data = cartDAO.findByUsername(username);
//		Double amount = 0.0, shiping = 0.0, total = 0.0;
//
//		for (Cart cart : data) {
//			amount += cart.getTotal();
//		}
//
//		shiping = amount * 0.05;
//		total = amount + shiping;
//
//		model.addAttribute("listCart", data);
//		model.addAttribute("amount", amount);
//		model.addAttribute("shiping", shiping);
//		model.addAttribute("total", total);
//		model.addAttribute("sizeCart", data.size());
//		model.addAttribute("user", userDAO.findById(username).get());
//
//		return "home/checkout";
//	}
}