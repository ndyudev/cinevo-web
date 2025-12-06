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

/**
 * Servlet xử lý đăng ký
 */
@WebServlet("/auth/register")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserDAO userDAO;
       
    public RegisterServlet() {
        super();
        userDAO = new UserDAOImpl();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		// Redirect về trang register trong Cinevo servlet
		response.sendRedirect(request.getContextPath() + "/cinevo/user?tab=register");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String confirmPassword = request.getParameter("confirmPassword");
		String fullname = request.getParameter("fullname");
		
		// Validate input
		if (email == null || email.trim().isEmpty()) {
			request.setAttribute("error", "Email không được để trống!");
			request.setAttribute("fullname", fullname);
			request.getRequestDispatcher("/views/pages/auth/register.jsp").forward(request, response);
			return;
		}
		
		if (password == null || password.trim().isEmpty()) {
			request.setAttribute("error", "Mật khẩu không được để trống!");
			request.setAttribute("email", email);
			request.setAttribute("fullname", fullname);
			request.getRequestDispatcher("/views/pages/auth/register.jsp").forward(request, response);
			return;
		}
		
		if (password.length() < 6) {
			request.setAttribute("error", "Mật khẩu phải có ít nhất 6 ký tự!");
			request.setAttribute("email", email);
			request.setAttribute("fullname", fullname);
			request.getRequestDispatcher("/views/pages/auth/register.jsp").forward(request, response);
			return;
		}
		
		if (!password.equals(confirmPassword)) {
			request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
			request.setAttribute("email", email);
			request.setAttribute("fullname", fullname);
			request.getRequestDispatcher("/views/pages/auth/register.jsp").forward(request, response);
			return;
		}
		
		// Kiểm tra email đã tồn tại chưa
		User existingUser = userDAO.findByEmail(email);
		if (existingUser != null) {
			request.setAttribute("error", "Email đã được sử dụng!");
			request.setAttribute("email", email);
			request.setAttribute("fullname", fullname);
			request.getRequestDispatcher("/views/pages/auth/register.jsp").forward(request, response);
			return;
		}
		
		// Tạo user mới
		User newUser = new User();
		newUser.setEmail(email);
		newUser.setPassword(password);
		newUser.setFullname(fullname);
		newUser.setIsAdmin(false);
		
		try {
			userDAO.create(newUser);
			
			// Đăng ký thành công, tự động đăng nhập
			HttpSession session = request.getSession();
			session.setAttribute("user", newUser);
			session.setAttribute("message", "Đăng ký thành công!");
			
			// Redirect về trang chủ: Admin -> admin, User thường -> user
			if (newUser.getIsAdmin()) {
				response.sendRedirect(request.getContextPath() + "/cinevo/admin");
			} else {
				response.sendRedirect(request.getContextPath() + "/cinevo/user");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "Đã có lỗi xảy ra khi đăng ký. Vui lòng thử lại!");
			request.setAttribute("email", email);
			request.setAttribute("fullname", fullname);
			request.getRequestDispatcher("/views/pages/auth/register.jsp").forward(request, response);
		}
	}
}
