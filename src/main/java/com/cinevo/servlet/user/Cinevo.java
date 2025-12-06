package com.cinevo.servlet.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.cinevo.dao.CategoryDAO;
import com.cinevo.dao.VideoDAO;
import com.cinevo.dao.impl.CategoryDAOImpl;
import com.cinevo.dao.impl.VideoDAOImpl;
import com.cinevo.entity.Category;
import com.cinevo.entity.Video;

@WebServlet("/cinevo/user")
public class Cinevo extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private VideoDAO videoDAO;
	private CategoryDAO categoryDAO;
       
    public Cinevo() {
        super();
        videoDAO = new VideoDAOImpl();
        categoryDAO = new CategoryDAOImpl();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String tab = request.getParameter("tab");
		String view = "";
		String pageTitle = "Cinevo | User";

		// Load categories cho tất cả trang
		List<Category> categories = categoryDAO.findAll();
		request.setAttribute("categories", categories);

		if (tab == null || tab.isEmpty()) {
			// Load dữ liệu cho trang home
			List<Video> allVideos = videoDAO.findAll();
			List<Video> top10Videos = videoDAO.findTop10ByViews();
			List<Video> latestVideos = videoDAO.findLatest3Videos();
			
			request.setAttribute("allVideos", allVideos);
			request.setAttribute("top10Videos", top10Videos);
			request.setAttribute("latestVideos", latestVideos);
			
			view = "/views/components/user/content.jsp";
		} else {
			switch (tab) {
			case "login":
				view = "/views/pages/auth/login.jsp";
				pageTitle = "Đăng nhập";
				break;
			case "register":
				view = "/views/pages/auth/register.jsp";
				pageTitle = "Đăng ký";
				break;
			case "video-detail":
				view = "/views/pages/user/video-detail.jsp";
				String videoIdStr = request.getParameter("id");
				pageTitle = "Chi tiết phim | Cinevo";
				
				if (videoIdStr != null && !videoIdStr.isEmpty()) {
					try {
						Long videoId = Long.parseLong(videoIdStr);
						Video video = videoDAO.findById(videoId);
						request.setAttribute("video", video);
						
						if (video != null) {
							pageTitle = video.getTitle() + " | Cinevo";
						}
					} catch (NumberFormatException e) {
						e.printStackTrace();
					}
				}
				break;
			default:
				// Load dữ liệu cho trang home
				List<Video> allVideos = videoDAO.findAll();
				List<Video> top10Videos = videoDAO.findTop10ByViews();
				List<Video> latestVideos = videoDAO.findLatest3Videos();
				
				request.setAttribute("allVideos", allVideos);
				request.setAttribute("top10Videos", top10Videos);
				request.setAttribute("latestVideos", latestVideos);
				
				view = "/views/components/user/content.jsp";
				break;
			}
		}

		request.setAttribute("view", view);
		request.setAttribute("pageTitle", pageTitle);
		
		request.getRequestDispatcher("/views/layouts/user/layoutUser.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}