package com.cinevo.servlet.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.cinevo.dao.FavoriteDAO;
import com.cinevo.dao.impl.FavoriteDAOImpl;
import com.cinevo.entity.User;

/**
 * Servlet xử lý chức năng yêu thích video
 */
@WebServlet({"/user/favorite", "/user/favorite/*"})
public class FavoriteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private FavoriteDAO favoriteDAO;
       
    public FavoriteServlet() {
        super();
        favoriteDAO = new FavoriteDAOImpl();
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
		
		// Load danh sách video yêu thích
		// TODO: Implement
		request.setAttribute("favoriteList", favoriteDAO.findByUserId(user.getId()));
		request.setAttribute("view", "/views/pages/user/favorite.jsp");
		request.setAttribute("pageTitle", "Video yêu thích");
		request.getRequestDispatcher("/views/layouts/user/layoutUser.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/cinevo/user?tab=login");
            return;
        }

        String action = request.getParameter("action");
        String videoIdStr = request.getParameter("videoId");
        Long videoId = Long.parseLong(videoIdStr);

        if ("add".equals(action)) {
            favoriteDAO.addFavorite(user.getId(), videoId);
        } else if ("remove".equals(action)) {
            favoriteDAO.removeFavorite(user.getId(), videoId);
        }

        response.sendRedirect(request.getContextPath() + "/user/favorite");
	}
}
