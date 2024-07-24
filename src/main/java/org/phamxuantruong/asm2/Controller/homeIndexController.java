package org.phamxuantruong.asm2.Controller;

import java.util.List;

import org.phamxuantruong.asm2.Entity.Categories;
import org.phamxuantruong.asm2.Entity.Product;
import org.phamxuantruong.asm2.Entity.Users;
import org.phamxuantruong.asm2.Interface.CartDAO;
import org.phamxuantruong.asm2.Interface.CategoriesDAO;
import org.phamxuantruong.asm2.Interface.ProductDAO;
import org.phamxuantruong.asm2.Interface.UsersDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpSession;

@Controller
public class homeIndexController {
    @Autowired
    ProductDAO productDAO;
    @Autowired
    CategoriesDAO categoriesDAO;
    @Autowired
    CartDAO cartDAO;
    @Autowired
    UsersDAO usersDAO;
    @Autowired
    PasswordEncoder passwordEncoder;
    
    @RequestMapping("/")
    public String home(Model model, HttpSession session) {
        Pageable pageable = PageRequest.of(0, 12);

        String username = (String) session.getAttribute("loggedInUser");
        
        List<Product> products = productDAO.findAll(pageable).getContent();
        List<Categories> categories = categoriesDAO.findAll();
        model.addAttribute("products", products);
        model.addAttribute("categories", categories);
        model.addAttribute("sizeCart", username != null ? cartDAO.countByUsername(username) : 0);
        return "home/index";
    }
    @RequestMapping("user_info")
    public String userInfo(Model model, HttpSession session) {
        String username = (String) session.getAttribute("loggedInUser");
        if (username == null) {
            model.addAttribute("error", "Vui lòng đăng nhập tài khoản");
            return "redirect:/user/login";
        }
        Users user = usersDAO.findById(username).orElse(null);
        model.addAttribute("user", user);

        return "home/user_info";

    }
    @GetMapping("user_update")
    public String userUpdate(Model model, HttpSession session) {
        String username = (String) session.getAttribute("loggedInUser");
        if (username == null) {
            model.addAttribute("error", "Vui lòng đăng nhập tài khoản");
            return "redirect:/user/login";
        }
        Users user = usersDAO.findById(username).orElse(null);
        model.addAttribute("user", user);

        return "home/user_update";
    }
    @PostMapping("user_update/save")
    public String userSave(@ModelAttribute Users updatedUser, BindingResult result, HttpSession session) {
        if (result.hasErrors()) {
            return "home/user_update";
        }

        String username = (String) session.getAttribute("loggedInUser");
        if (username == null) {
            return "redirect:/user/login";
        }

        // Lấy thông tin người dùng gốc từ cơ sở dữ liệu
        Users existingUser = usersDAO.findById(username).orElse(null);
        if (existingUser == null) {
            return "redirect:/user/login";
        }

        // Cập nhật các thông tin từ updatedUser, ngoại trừ username
        existingUser.setFullname(updatedUser.getFullname());
        existingUser.setEmail(updatedUser.getEmail());
        existingUser.setPhoneNumber(updatedUser.getPhoneNumber());
        existingUser.setGender(updatedUser.getGender());
        existingUser.setNgaysinh(updatedUser.getNgaysinh());
        existingUser.setImage(updatedUser.getImage());
        // Nếu cần cập nhật mật khẩu, hãy mã hóa lại mật khẩu
        if (updatedUser.getPassword() != null && !updatedUser.getPassword().isEmpty()) {
            existingUser.setPassword(passwordEncoder.encode(updatedUser.getPassword()));
        }

        // Lưu thông tin người dùng đã cập nhật vào cơ sở dữ liệu
        usersDAO.save(existingUser);

        // Cập nhật thông tin người dùng trong session
        session.setAttribute("loggedInUser", existingUser.getUsername());

        return "redirect:/user_info";
    }
}