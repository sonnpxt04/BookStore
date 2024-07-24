package org.phamxuantruong.asm2.Controller;

import jakarta.servlet.http.HttpSession;
import org.phamxuantruong.asm2.Entity.Bill;
import org.phamxuantruong.asm2.Interface.BillDAO;
import org.phamxuantruong.asm2.Service.ParamService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@Controller
public class historyController {
    @Autowired
    BillDAO billDAO;
    @Autowired
    ParamService paramService;
    @RequestMapping("history")
    public String history(Model model, HttpSession session,
                          @RequestParam(value = "field", required = false) Optional<String> field,
                          @RequestParam(value = "page", required = false) Optional<String> page,
                          @RequestParam(value = "size", required = false) Optional<Integer> size,
                          @RequestParam(value = "name", required = false) Optional<String> name

                          ) {
        String username = (String) session.getAttribute("loggedInUser");
        if(username == null) {
            model.addAttribute("error", "Vui lòng đăng nhập tài khoản");
            return "redirect:/user/login";
        }
        String sortField = field.orElse("Total");
        int currentPage = page.map(Integer::parseInt).orElse(0);
        int pageSize = size.orElse(10);
        String fullname = name.orElse("");
        Sort sort = Sort.by(Sort.Direction.ASC, sortField);
        Pageable pageable = PageRequest.of(currentPage, pageSize, sort);

        Page<Bill> billPage = billDAO.findByUserUsernameAndFullnameContaining(username, fullname, pageable);
        model.addAttribute("items", billPage.getContent());
        model.addAttribute("field", sortField);
        model.addAttribute("billPage", billPage);
        model.addAttribute("name", fullname );
        return "home/history1";
    }
    @PostMapping("bill/delete/{id}")
    public String deleteBill(@PathVariable("id") Long id, Model model){
        billDAO.deleteById(id);
        return "redirect:/history?successMessage=Done!";
    }
    @GetMapping("/order/{id}")
    public String orderDetail(@PathVariable("id") Long id, Model model) {
        Optional<Bill> bill = billDAO.findById(id);
        if (bill.isPresent()) {
            model.addAttribute("bill", bill.get());
            return "home/history2";
        } else {
            return "redirect:/history";
        }
    }
}
