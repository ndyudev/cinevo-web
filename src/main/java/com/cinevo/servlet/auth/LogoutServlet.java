package com.cinevo.servlet.auth;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet xử lý đăng xuất
 */
@WebServlet("/auth/logout")
public class LogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		// Lấy session và xóa user
		HttpSession session = request.getSession(false);
		if (session != null) {
			session.invalidate();
		}
		
		// Redirect về trang chủ
		response.sendRedirect(request.getContextPath() + "/cinevo/user");
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		doGet(request, response);
	}
}
