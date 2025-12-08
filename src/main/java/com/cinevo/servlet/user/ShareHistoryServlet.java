package com.cinevo.servlet.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import com.cinevo.dao.ShareDAO;
import com.cinevo.dao.impl.ShareDAOImpl;
import com.cinevo.entity.Share;
import com.cinevo.entity.User;

/**
 * Servlet hiển thị danh sách video đã share
 */
@WebServlet("/user/share")
public class ShareHistoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ShareDAO shareDAO;
       
    public ShareHistoryServlet() {
        super();
        shareDAO = new ShareDAOImpl();
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
		
		// Load danh sách share của user
		List<Share> shares = shareDAO.findByUserId(user.getId());
		request.setAttribute("shares", shares);
		
		request.setAttribute("view", "/views/pages/user/share.jsp");
		request.setAttribute("pageTitle", "Lịch sử chia sẻ");
		request.getRequestDispatcher("/views/layouts/user/layoutUser.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		doGet(request, response);
	}
}
