package com.cinevo.servlet.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import com.cinevo.dao.CategoryDAO;
import com.cinevo.dao.FavoriteDAO;
import com.cinevo.dao.VideoDAO;
import com.cinevo.dao.impl.CategoryDAOImpl;
import com.cinevo.dao.impl.FavoriteDAOImpl;
import com.cinevo.dao.impl.VideoDAOImpl;
import com.cinevo.entity.Category;
import com.cinevo.entity.Favorite;
import com.cinevo.entity.User;
import com.cinevo.entity.Video;

@WebServlet("/cinevo/user")
public class Cinevo extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private VideoDAO videoDAO;
	private CategoryDAO categoryDAO;
	private FavoriteDAO favoriteDAO;
       
    public Cinevo() {
        super();
        videoDAO = new VideoDAOImpl();
        categoryDAO = new CategoryDAOImpl();
        favoriteDAO = new FavoriteDAOImpl();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String tab = request.getParameter("tab");
		String view = "";
		String pageTitle = "Cinevo | User";

		// Load categories cho tất cả trang
		List<Category> categories = categoryDAO.findAll();
		request.setAttribute("categories", categories);

		if (tab == null || tab.isEmpty()) {
			// Load filter parameters
		String categoryIdStr = request.getParameter("categoryId");
		String yearStr = request.getParameter("year");
		String search = request.getParameter("search");
		String pageStr = request.getParameter("page");
		
		Integer categoryId = null;
		Integer year = null;
		int currentPage = 1;
		int pageSize = 6;			// Parse parameters
			if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
				try {
					categoryId = Integer.parseInt(categoryIdStr);
				} catch (NumberFormatException e) {
					e.printStackTrace();
				}
			}
			
			if (yearStr != null && !yearStr.isEmpty()) {
				try {
					year = Integer.parseInt(yearStr);
				} catch (NumberFormatException e) {
					e.printStackTrace();
				}
			}
			
			if (pageStr != null && !pageStr.isEmpty()) {
				try {
					currentPage = Integer.parseInt(pageStr);
					if (currentPage < 1) currentPage = 1;
				} catch (NumberFormatException e) {
					e.printStackTrace();
				}
			}
			
		// Load filtered videos with pagination
		List<Video> allVideos = videoDAO.findByFilters(categoryId, year, search, currentPage, pageSize);
		long totalVideos = videoDAO.countByFilters(categoryId, year, search);
			int totalPages = (int) Math.ceil((double) totalVideos / pageSize);
			
		// Load other data
		List<Video> latestVideos = videoDAO.findLatest3Videos();
		List<Video> top10Videos = videoDAO.findTop10ByViews();
		List<Video> top4Today = videoDAO.findTop4ByViewsToday();
		List<Video> top4Week = videoDAO.findTop4ByViewsThisWeek();
		List<Video> top4Month = videoDAO.findTop4ByViewsThisMonth();
		List<Video> top4All = videoDAO.findTop4ByViewsAllTime();
		
		request.setAttribute("allVideos", allVideos);
		request.setAttribute("latestVideos", latestVideos);
		request.setAttribute("top10Videos", top10Videos);
		request.setAttribute("top4Today", top4Today);
		request.setAttribute("top4Week", top4Week);
		request.setAttribute("top4Month", top4Month);
		request.setAttribute("top4All", top4All);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("totalPages", totalPages);
			request.setAttribute("selectedCategoryId", categoryId);
			request.setAttribute("selectedYear", year);
			request.setAttribute("searchKeyword", search);
			
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
						
						if (video != null) {
							// Tăng view count
							video.setViews(video.getViews() + 1);
							videoDAO.update(video);
							
							// Reload video để lấy data mới nhất
							video = videoDAO.findById(videoId);
							request.setAttribute("video", video);
							
							pageTitle = video.getTitle() + " | Cinevo";
							
							// Check xem user đã like video chưa
							HttpSession session = request.getSession();
							User user = (User) session.getAttribute("user");
							if (user != null && !user.getIsAdmin()) {
								Favorite favorite = favoriteDAO.findByUserIdAndVideoId(user.getId(), videoId);
								request.setAttribute("isLiked", favorite != null);
							}
							
							// Load video liên quan (cùng category)
							if (video.getCategory() != null) {
								List<Video> relatedVideos = videoDAO.findRelatedVideos(videoId, video.getCategory().getId(), 10);
								request.setAttribute("relatedVideos", relatedVideos);
							}
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