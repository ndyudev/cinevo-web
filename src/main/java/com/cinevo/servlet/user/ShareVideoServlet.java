package com.cinevo.servlet.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Date;

import com.cinevo.dao.ShareDAO;
import com.cinevo.dao.VideoDAO;
import com.cinevo.dao.impl.ShareDAOImpl;
import com.cinevo.dao.impl.VideoDAOImpl;
import com.cinevo.entity.Share;
import com.cinevo.entity.User;
import com.cinevo.entity.Video;
import com.cinevo.utils.Mailer;

/**
 * Servlet xử lý share video qua email
 */
@WebServlet("/api/share-video")
public class ShareVideoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ShareDAO shareDAO;
	private VideoDAO videoDAO;
       
    public ShareVideoServlet() {
        super();
        shareDAO = new ShareDAOImpl();
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
		String toEmail = request.getParameter("toEmail");
		
		if (videoIdStr == null || videoIdStr.isEmpty() || toEmail == null || toEmail.isEmpty()) {
			response.sendRedirect(request.getContextPath() + "/cinevo/user");
			return;
		}
		
		try {
			Long videoId = Long.parseLong(videoIdStr);
			Video video = videoDAO.findById(videoId);
			
			if (video != null) {
				// Tạo link video
				String videoLink = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
					+ request.getContextPath() + "/cinevo/user?tab=video-detail&id=" + videoId;
				
				// Tạo nội dung email
				String subject = user.getFullname() + " đã chia sẻ video với bạn: " + video.getTitle();
				String body = "<div style='font-family: Arial, sans-serif; padding: 20px; background: #f5f5f5;'>"
					+ "<div style='max-width: 600px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px;'>"
					+ "<h2 style='color: #dc3545;'>🎬 Cinevo - Chia sẻ video</h2>"
					+ "<p><strong>" + user.getFullname() + "</strong> (" + user.getEmail() + ") đã chia sẻ video với bạn:</p>"
					+ "<div style='background: #f8f9fa; padding: 20px; border-radius: 8px; margin: 20px 0;'>"
					+ "<h3 style='color: #333; margin-top: 0;'>" + video.getTitle() + "</h3>"
					+ "<p style='color: #666;'>" + (video.getDescription() != null ? video.getDescription() : "") + "</p>"
					+ "</div>"
					+ "<a href='" + videoLink + "' style='display: inline-block; background: #dc3545; color: white; padding: 12px 30px; text-decoration: none; border-radius: 5px; margin: 10px 0;'>Xem ngay</a>"
					+ "<p style='color: #999; font-size: 12px; margin-top: 30px;'>Đây là email tự động từ Cinevo. Vui lòng không trả lời email này.</p>"
					+ "</div></div>";
				
				// Gửi email
				int result = Mailer.send(user.getEmail(), toEmail, subject, body);
				
				if (result == 1) {
					// Lưu vào database
					Share share = new Share();
					share.setUser(user);
					share.setVideo(video);
					share.setSharedToEmail(toEmail);
					share.setShareDate(new Date());
					shareDAO.create(share);
					
					session.setAttribute("successMessage", "Đã chia sẻ video đến " + toEmail);
				} else {
					session.setAttribute("errorMessage", "Không thể gửi email. Vui lòng thử lại!");
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
