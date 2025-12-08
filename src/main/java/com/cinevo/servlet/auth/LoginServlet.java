package com.cinevo.servlet.auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.cinevo.dao.UserDAO;
import com.cinevo.dao.impl.UserDAOImpl;
import com.cinevo.entity.User;
import com.cinevo.filter.AuthFilter;

/**
 * Servlet xử lý đăng nhập
 */
@WebServlet("/auth/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserDAO userDAO;
       
    public LoginServlet() {
        super();
        userDAO = new UserDAOImpl();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		// Redirect về trang login trong Cinevo servlet
		response.sendRedirect(request.getContextPath() + "/cinevo/user?tab=login");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		
		// Validate input
		if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
			request.getSession().setAttribute("error", "Email và mật khẩu không được để trống!");
			response.sendRedirect(request.getContextPath() + "/cinevo/user?tab=login&email=" + email);
			return;
		}
		
		// Tìm user theo email
		User user = userDAO.findByEmail(email);
		
		if (user == null) {
			request.getSession().setAttribute("error", "Email không tồn tại!");
			response.sendRedirect(request.getContextPath() + "/cinevo/user?tab=login&email=" + email);
			return;
		}
		
		// Kiểm tra mật khẩu
		if (!user.getPassword().equals(password)) {
			request.getSession().setAttribute("error", "Mật khẩu không đúng!");
			response.sendRedirect(request.getContextPath() + "/cinevo/user?tab=login&email=" + email);
			return;
		}
		
		// Đăng nhập thành công
		HttpSession session = request.getSession();
		session.setAttribute("user", user);
		session.setAttribute("message", "Đăng nhập thành công!");
		
		// Kiểm tra có URL bảo mật không (redirect về trang user muốn vào)
		String securityUri = (String) session.getAttribute(AuthFilter.SECURITY_URL);
		if (securityUri != null) {
			session.removeAttribute(AuthFilter.SECURITY_URL);
			response.sendRedirect(securityUri);
			return;
		}
		
		// Redirect về trang chủ: Admin -> admin, User thường -> user
		if (user.getIsAdmin()) {
			response.sendRedirect(request.getContextPath() + "/cinevo/admin");
		} else {
			response.sendRedirect(request.getContextPath() + "/cinevo/user");
		}
	}
}
