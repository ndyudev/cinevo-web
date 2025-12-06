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
 * Servlet xử lý chức năng chia sẻ video
 */
@WebServlet({"/user/share", "/user/share/*"})
public class ShareServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ShareServlet() {
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
		
		// Load danh sách chia sẻ
		// TODO: Implement
		
		request.setAttribute("view", "/views/pages/user/share.jsp");
		request.setAttribute("pageTitle", "Video đã chia sẻ");
		request.getRequestDispatcher("/views/layouts/user/layoutUser.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		// Chia sẻ video qua email
		// TODO: Implement
		
		doGet(request, response);
	}
}
