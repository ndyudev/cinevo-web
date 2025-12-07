package com.cinevo.servlet.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import com.cinevo.dao.ShareDAO;
import com.cinevo.dao.impl.ShareDAOImpl;
import com.cinevo.entity.Share;
import com.cinevo.entity.User;
import com.cinevo.entity.Video;

/**
 * Servlet xử lý chức năng chia sẻ video
 */
@WebServlet({"/user/share", "/user/share/*"})
public class ShareServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ShareDAO shareDAO;
    public ShareServlet() {
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
		
		 // Lấy danh sách video đã chia sẻ của user
		List<Share> sharedList = shareDAO.findByUserId(user.getId());
        request.setAttribute("sharedList", sharedList);

		
		request.setAttribute("view", "/views/pages/user/share.jsp");
		request.setAttribute("pageTitle", "Video đã chia sẻ");
		request.getRequestDispatcher("/views/layouts/user/layoutUser.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || user.getIsAdmin()) {
            session.setAttribute("securityMessage", "Chức năng này chỉ dành cho người dùng thường!");
            response.sendRedirect(request.getContextPath() + "/cinevo/user?tab=login");
            return;
        }

        String videoIdStr = request.getParameter("videoId");
        String emailTo = request.getParameter("email");

        if (videoIdStr != null && emailTo != null && !emailTo.isEmpty()) {
            try {
                Long videoId = Long.parseLong(videoIdStr);

                // Kiểm tra đã chia sẻ video này chưa
                List<Share> existingShares = shareDAO.findByVideoId(videoId);
                boolean alreadyShared = existingShares.stream()
                        .anyMatch(s -> s.getUser().getId().equals(user.getId()));

                if (alreadyShared) {
                    // Nếu đã chia sẻ -> xóa
                    shareDAO.findByVideoId(videoId).stream()
                            .filter(s -> s.getUser().getId().equals(user.getId()))
                            .forEach(s -> shareDAO.delete(s.getId()));
                } else {
                    // Tạo chia sẻ mới
                    Video video = new Video();
                    video.setId(videoId);

                    Share share = new Share();
                    share.setUser(user);
                    share.setVideo(video);
                    share.setSharedToEmail(emailTo);
                    share.setShareDate(new Date());

                    shareDAO.create(share);
                }

            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        doGet(request, response);
	}
}
