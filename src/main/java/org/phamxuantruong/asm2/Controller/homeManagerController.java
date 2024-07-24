package org.phamxuantruong.asm2.Controller;


import com.google.gson.Gson;
import jakarta.validation.Valid;
import org.apache.catalina.User;
import org.phamxuantruong.asm2.Entity.Bill;
import org.phamxuantruong.asm2.Entity.Categories;
import org.phamxuantruong.asm2.Entity.Product;
import org.phamxuantruong.asm2.Entity.Users;
import org.phamxuantruong.asm2.Interface.BillDAO;
import org.phamxuantruong.asm2.Interface.CategoriesDAO;
import org.phamxuantruong.asm2.Interface.ProductDAO;
import org.phamxuantruong.asm2.Interface.UsersDAO;
import org.phamxuantruong.asm2.Service.BillService;
import org.phamxuantruong.asm2.Service.ParamService;
import org.phamxuantruong.asm2.Service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
@RequestMapping("manager")
public class homeManagerController {
    @Autowired
    ProductService productService;
    @Autowired
    ParamService paramService;
    @Autowired
    ProductDAO productDAO;
    @Autowired
    CategoriesDAO categoriesDAO;
    @Autowired
    private BillDAO billDAO;
    @Autowired
    PasswordEncoder passwordEncoder;

    @ModelAttribute("product")
    public Product getProduct() {
        return new Product();
    }
    @ModelAttribute("cate")
    public Categories getCategories() {
        return new Categories();
    }
    @RequestMapping("home")
    public String homeManager(Model model,
                              @RequestParam(value = "field", required = false) Optional<String> field,
                              @RequestParam(value = "page", required = false) Optional<String> page,
                              @RequestParam(value = "size", required = false) Optional<Integer> size,
                              @RequestParam(value = "name", required = false) Optional<String> name) {
        String sortField = field.orElse("price");
        int currentPage = page.map(Integer::parseInt).orElse(0);
        int pageSize = size.orElse(10);
        String productName = name.orElse("");

        Sort sort = Sort.by(Sort.Direction.ASC, sortField);
        Pageable pageable = PageRequest.of(currentPage, pageSize, sort);

        Page<Product> productPage = productDAO.findByNameContaining(productName, pageable);

        model.addAttribute("items", productPage.getContent());
        model.addAttribute("productPage", productPage);
        model.addAttribute("field", sortField);
        model.addAttribute("name", productName);

        return "manager/index";
    }

    @RequestMapping("/product/update")
    public String updateProduct(@ModelAttribute("product") Product product, Model model){
        model.addAttribute("product", product);
        return "manager/updateProduct";
    }
    //mở form cập nhật product ở đây
    @GetMapping("/product/update/{id}")
    public String updateProduct(@PathVariable("id") Long id, Model model) {
        Optional<Product> product = productService.findById(id);
        if (product.isPresent()) {
            model.addAttribute("product", product.get());
            return "manager/updateProduct";
        }
        return "redirect:/manager/home";
    }
    @PostMapping("/product/save")
    public String saveProduct(@Validated @ModelAttribute("product") Product productDetails, BindingResult bindingResult, @RequestParam("imageFile") MultipartFile imageFile, Model model) throws IOException {
        if (bindingResult.hasErrors()) {
            model.addAttribute("message", "Vui lòng sửa các lỗi sau:");
            return "manager/updateProduct";
        }

        if (imageFile.isEmpty() && (productDetails.getImage() == null || productDetails.getImage().trim().isEmpty())) {
            model.addAttribute("message", "Vui lòng chọn hình ảnh");
            return "manager/updateProduct";
        }

        Product product;
        if (productDetails.getProductID() != null) {
            Optional<Product> existingProduct = productService.findById(productDetails.getProductID());
            if (existingProduct.isPresent()) {
                product = existingProduct.get();
            } else {
                model.addAttribute("message", "Không tìm thấy sản phẩm");
                return "manager/updateProduct";
            }
        } else {
            product = new Product();
        }

        // Cập nhật các trường của product với các giá trị mới từ productDetails
        product.setCategoryID(productDetails.getCategoryID());
        product.setName(productDetails.getName());
        product.setAuthor(productDetails.getAuthor());
        product.setYear(productDetails.getYear());
        product.setPrice(productDetails.getPrice());
        product.setQuantity(productDetails.getQuantity());
        product.setInfor(productDetails.getInfor());

        if (!imageFile.isEmpty()) {
            String imagePath = saveImage(imageFile);
            product.setImage(imagePath);
        } else {
            product.setImage(productDetails.getImage());
        }

        productService.save(product);
//        model.addAttribute("message", "Chúc mừng bạn đã nhập đúng");
        return "redirect:/manager/home?successMessage=DONE!";
    }



    private String saveImage(MultipartFile imageFile) throws IOException {
        String fileName = imageFile.getOriginalFilename();
        String uploadDir = new File("src/main/resources/static/imgProduct").getAbsolutePath();
        File uploadFile = new File(uploadDir, fileName);
        imageFile.transferTo(uploadFile);
        return "/imgProduct/" + fileName;
    }
    @PostMapping
            ("/product/delete/{id}")
    public String deleteProduct(@PathVariable("id") Long id, Model model) {
        Optional<Product> product = productService.findById(id);
        if (product.isPresent()) {
            productService.delete(product.get());
//            model.addAttribute("message", "Sản phẩm đã được xóa thành công");
        } else {
            model.addAttribute("message", "Không tìm thấy sản phẩm");
        }
        return "redirect:/manager/home?successMessage=DeleteDONE!";
    }


    @RequestMapping("category")
    public String categoryManager(Model model,
                                  @RequestParam(value = "field", required = false) Optional<String> field,
                                  @RequestParam(value = "page", required = false) Optional<String> page,
                                  @RequestParam(value = "size", required = false) Optional<Integer> size,
                                  @RequestParam(value = "name", required = false) Optional<String> name
                                  ){

        String sortField = field.orElse("categoryID");
        int currentPage = page.map(Integer::parseInt).orElse(0);
        int pageSize = size.orElse(5);
        String categoryName = name.orElse("");

        Sort sort = Sort.by(Sort.Direction.ASC, sortField);
        Pageable pageable = PageRequest.of(currentPage, pageSize, sort);

        Page<Categories> categoriesPage = categoriesDAO.findByNameCategoryContaining(categoryName, pageable);
        model.addAttribute("items", categoriesPage.getContent());
        model.addAttribute("categoryPage", categoriesPage);
        model.addAttribute("field", sortField);
        model.addAttribute("name", categoryName);

        return "manager/categoryBookManager";
    }

    //mở form cập nhật categories ở đây!
    @RequestMapping("category/update")
    public String updateCategory(@ModelAttribute("category") Categories category, Model model){
//        categoriesDAO.save(category);
        model.addAttribute("category", category);
        return "manager/updateCategory";
    }

    @RequestMapping("category/update/{id}")
    public String updateCategory(@PathVariable("id") Long id, Model model){
        Optional<Categories> category = categoriesDAO.findById(id);
        if (category.isPresent()) {
            model.addAttribute("category", category.get());
            return "manager/updateCategory";
        }
        return "redirect:/manager/category";
    }
    @PostMapping("category/save")
    public String saveCategories(@Validated @ModelAttribute("category")Categories category, BindingResult bindingResult, Model model){
        if (bindingResult.hasErrors()){
            model.addAttribute("message", "Vui lòng sửa các lỗi sau:");
        }else {
            categoriesDAO.save(category);
            model.addAttribute("message", "Chúc mừng bạn đã nhap đúng");
        }
      return "redirect:/manager/category?successMessage=DONE!";
    }
    @PostMapping("category/delete/{id}")
    public String deleteCategory(@PathVariable("id") Long id, Model model){
        categoriesDAO.deleteById(id);
        return "redirect:/manager/category?successMessage=DONE!";
    }







//user
@Autowired
UsersDAO usersDAO;

    @RequestMapping("users")
    public String searchUsers(Model model,
                              @RequestParam(value = "username", required = false) String username,
                              @RequestParam(value = "fullname", required = false) String fullname,
                              @RequestParam(value = "page", defaultValue = "0") int page,
                              @RequestParam(value = "size", defaultValue = "5") int size) {

        Pageable pageable = PageRequest.of(page, size);
        Page<Users> usersPage = usersDAO.findByUsernameContainingAndFullnameContainingAndAdminIsNull(
                username == null ? "" : username, fullname == null ? "" : fullname, pageable);

        model.addAttribute("usersPage", usersPage);
        model.addAttribute("username", username);
        model.addAttribute("fullname", fullname);
        return "manager/userManager";
    }


//admin
@RequestMapping("admin")
public String adminManager(Model model,
                           @RequestParam(value = "username", required = false) String username,
                           @RequestParam(value = "fullname", required = false) String fullname,
                           @RequestParam(value = "page", defaultValue = "0") int page,
                           @RequestParam(value = "size", defaultValue = "5") int size) {

    Pageable pageable = PageRequest.of(page, size);
    Page<Users> adminPage = usersDAO.findByUsernameContainingAndFullnameContainingAndAdminIsNotNull(
            username == null ? "" : username, fullname == null ? "" : fullname, pageable);

    model.addAttribute("adminPage", adminPage);
    model.addAttribute("username", username);
    model.addAttribute("fullname", fullname);
    return "manager/adminManager";
}



    @RequestMapping("admin/update")
    public String updateAdmin(@ModelAttribute("admin") Users admin, Model model){

                model.addAttribute("admin", admin);
                return "manager/updateUserManager";
    }

    @GetMapping("/admin/update/{username}")
    public String updateAdmin(@PathVariable("username") String username, Model model){
        Optional<Users> existingAdmin = usersDAO.findByUsername(username);
        if (existingAdmin.isPresent()) {
            model.addAttribute("admin", existingAdmin.get());
            return "manager/updateUserManager";
        }
        return "redirect:/manager/admin";
    }

    @RequestMapping("admin/update/save")
    public String saveAdmin(@Validated @ModelAttribute("admin") Users admin, BindingResult bindingResult,
                            @RequestParam("imageFile") MultipartFile imageFile, Model model) throws IOException {
        // Kiểm tra lỗi hợp lệ của dữ liệu
        if (bindingResult.hasErrors()) {
            model.addAttribute("message", "Vui lòng sửa các lỗi sau:");
            return "manager/updateUserManager"; // Trả về trang chỉnh sửa với thông báo lỗi
        }

        // Kiểm tra xem tệp có được tải lên không và xử lý ảnh
        if (imageFile.isEmpty() && (admin.getImage() == null || admin.getImage().trim().isEmpty())) {
            model.addAttribute("message", "Vui lòng chọn hình ảnh");
            return "manager/updateUserManager"; // Trả về trang chỉnh sửa với thông báo lỗi
        }

        // Kiểm tra xem người dùng đã tồn tại chưa
        Users existingAdmin;
        if (admin.getUsername() != null && !admin.getUsername().trim().isEmpty()) {
            Optional<Users> existingUser = usersDAO.findByUsername(admin.getUsername());
            if (existingUser.isPresent()) {
                existingAdmin = existingUser.get();
            } else {
                existingAdmin = new Users();
                existingAdmin.setUsername(admin.getUsername());
            }
        } else {
            existingAdmin = new Users();
        }

        // Cập nhật thông tin của người dùng
        if (admin.getPassword() != null && !admin.getPassword().isEmpty()) {
            existingAdmin.setPassword(passwordEncoder.encode(admin.getPassword()));
        }
        existingAdmin.setFullname(admin.getFullname());
        existingAdmin.setEmail(admin.getEmail());
        existingAdmin.setNgaysinh(admin.getNgaysinh());
        existingAdmin.setPhoneNumber(admin.getPhoneNumber());
        existingAdmin.setGender(admin.getGender());
        existingAdmin.setAdmin(true); // Đảm bảo giá trị admin là true

        // Xử lý hình ảnh
        if (!imageFile.isEmpty()) {
            String imagePath = saveImage(imageFile);
            existingAdmin.setImage(imagePath);
        } else {
            existingAdmin.setImage(admin.getImage());
        }

        // Lưu người dùng vào cơ sở dữ liệu
        usersDAO.save(existingAdmin);
        // Chuyển hướng về trang quản lý admin
        return "redirect:/manager/admin?successMessage=DONE!";
    }
    @PostMapping("admin/delete/{id}")
    public String deleteadmin(@PathVariable("id") String username, Model model){
        usersDAO.deleteById(username);
        return "redirect:/manager/admin?successMessage=DONE!";
    }





//bill
@RequestMapping("bill")
public String billManager(Model model,
                          @RequestParam(value = "field", required = false) Optional<String> field,
                          @RequestParam(value = "page", required = false) Optional<String> page,
                          @RequestParam(value = "size", required = false) Optional<Integer> size,
                          @RequestParam(value = "name", required = false) Optional<String> name){
    String sortField = field.orElse("Total");
    int currentPage = page.map(Integer::parseInt).orElse(0);
    int pageSize = size.orElse(10);
    String fullname = name.orElse("");
    Sort sort = Sort.by(Sort.Direction.ASC, sortField);
    Pageable pageable = PageRequest.of(currentPage, pageSize, sort);

    Page<Bill> billPage = billDAO.findByFullnameContaining(fullname,pageable);
    model.addAttribute("items", billPage.getContent());
    model.addAttribute("field", sortField);
    model.addAttribute("billPage", billPage);
    model.addAttribute("name", fullname );

    return "manager/billManager";
}

@ModelAttribute("action")
public List<String> getAction(){
        return Arrays.asList("Chờ xác nhận", "Đã xác nhận", "Đang giao hàng", "Thành công");
}

    @PostMapping("bill/delete/{id}")
    public String deleteBill(@PathVariable("id") Long id, Model model){
        billDAO.deleteById(id);
        return "redirect:/manager/bill?successMessage=Delete done!";
    }


    @PostMapping("bill/updateAction")
    public String updateAction(@RequestParam("billID") Long billID, @RequestParam("action") String action) {
        Optional<Bill> optionalBill = billDAO.findById(billID);
        if (optionalBill.isPresent()) {
            Bill bill = optionalBill.get();
            bill.setAction(action);
            billDAO.save(bill);
        }
        return "redirect:/manager/bill";
    }

    @Autowired
    BillService billService;
@RequestMapping("report")
    public String report(Model model){

    Double totalRevenue = billService.calculateTotalRevenue();
    model.addAttribute("totalRevenue", totalRevenue);
    // Tính doanh thu theo từng tháng
    Map<String, Double> revenueByMonth = billService.calculateRevenueByMonth();
    String revenueByMonthJson = new Gson().toJson(revenueByMonth);
    model.addAttribute("revenueByMonth", revenueByMonth);
    model.addAttribute("revenueByMonthJson", revenueByMonthJson);
    model.addAttribute("revenueByMonthJson", new Gson().toJson(revenueByMonth));


    return "manager/report";
}

}
