package org.phamxuantruong.asm2.config;


import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.phamxuantruong.asm2.Service.SessionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class AuthInterceptor implements HandlerInterceptor {
    @Autowired
    SessionService session;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        Object loggedInUser = session.get("loggedInUser");
        Boolean isAdmin = (Boolean) session.get("isAdmin"); // Chuyển đổi kiểu dữ liệu sang Boolean

        if (loggedInUser == null) {
            // Nếu chưa đăng nhập
            response.sendRedirect("/login");
            return false;
        } else if (isAdmin == null || !isAdmin.booleanValue()) {
            // Nếu không phải là admin hoặc isAdmin là null
            response.sendRedirect("/login?error=Please log in with an account with administrator rights to access the management section.");
            return false;
        }

        // Nếu là admin đã đăng nhập, cho phép truy cập các đường dẫn dành cho manager
        return true;
    }

}