package com.cinevo.servlet.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Date;

import com.cinevo.dao.FavoriteDAO;
import com.cinevo.dao.VideoDAO;
import com.cinevo.dao.impl.FavoriteDAOImpl;
import com.cinevo.dao.impl.VideoDAOImpl;
import com.cinevo.entity.Favorite;
import com.cinevo.entity.User;
import com.cinevo.entity.Video;

/**
 * Servlet xử lý like/unlike video
 */
@WebServlet("/api/like-video")
public class LikeVideoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private FavoriteDAO favoriteDAO;
	private VideoDAO videoDAO;
       
    public LikeVideoServlet() {
        super();
        favoriteDAO = new FavoriteDAOImpl();
        videoDAO = new VideoDAOImpl();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		
		if (user == null || user.getIsAdmin()) {
			session.setAttribute("securityMessage", "Vui lòng đăng nhập!");
			response.sendRedirect(request.getContextPath() + "/cinevo/user?tab=login");
			return;
		}
		
		String videoIdStr = request.getParameter("videoId");
		
		if (videoIdStr == null || videoIdStr.isEmpty()) {
			response.sendRedirect(request.getContextPath() + "/cinevo/user");
			return;
		}
		
		try {
			Long videoId = Long.parseLong(videoIdStr);
			
			// Check xem đã like chưa
			Favorite existing = favoriteDAO.findByUserIdAndVideoId(user.getId(), videoId);
			
			if (existing != null) {
				// Unlike
				favoriteDAO.deleteByUserIdAndVideoId(user.getId(), videoId);
			} else {
				// Like
				Video video = videoDAO.findById(videoId);
				if (video != null) {
					Favorite favorite = new Favorite();
					favorite.setUser(user);
					favorite.setVideo(video);
					favorite.setLikeDate(new Date());
					favoriteDAO.create(favorite);
				}
			}
			
			// Redirect về trang video-detail
			response.sendRedirect(request.getContextPath() + "/cinevo/user?tab=video-detail&id=" + videoId);
			
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect(request.getContextPath() + "/cinevo/user");
		}
	}
}
