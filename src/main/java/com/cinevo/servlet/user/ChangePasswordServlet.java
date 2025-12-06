package com.cinevo.servlet.user;

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
 * Servlet xử lý đổi mật khẩu
 */
@WebServlet("/user/change-password")
public class ChangePasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserDAO userDAO;
       
    public ChangePasswordServlet() {
        super();
        userDAO = new UserDAOImpl();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		
		if (user == null || user.getIsAdmin()) {
			session.setAttribute("securityMessage", "Chức năng này chỉ dành cho người dùng thường!");
			response.sendRedirect(request.getContextPath() + "/cinevo/user?tab=login");
			return;
		}
		
		request.setAttribute("view", "/views/pages/user/change-password.jsp");
		request.setAttribute("pageTitle", "Đổi mật khẩu");
		request.getRequestDispatcher("/views/layouts/user/layoutUser.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		
		String oldPassword = request.getParameter("oldPassword");
		String newPassword = request.getParameter("newPassword");
		String confirmPassword = request.getParameter("confirmPassword");
		
		// Validate
		if (!user.getPassword().equals(oldPassword)) {
			request.setAttribute("error", "Mật khẩu cũ không đúng!");
			doGet(request, response);
			return;
		}
		
		if (!newPassword.equals(confirmPassword)) {
			request.setAttribute("error", "Mật khẩu mới không khớp!");
			doGet(request, response);
			return;
		}
		
		// Đổi mật khẩu
		user.setPassword(newPassword);
		userDAO.update(user);
		
		session.setAttribute("message", "Đổi mật khẩu thành công!");
		response.sendRedirect(request.getContextPath() + "/cinevo/user");
	}
}
