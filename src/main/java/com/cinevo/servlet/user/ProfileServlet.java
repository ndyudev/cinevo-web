package com.cinevo.servlet.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.cinevo.entity.User;

/**
 * Servlet xử lý hồ sơ người dùng
 */
@WebServlet("/user/profile")
public class ProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ProfileServlet() {
        super();
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
		
		request.setAttribute("view", "/views/pages/user/profile.jsp");
		request.setAttribute("pageTitle", "Hồ sơ cá nhân");
		request.getRequestDispatcher("/views/layouts/user/layoutUser.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		// Cập nhật thông tin profile
		// TODO: Implement
		
		doGet(request, response);
	}
}
