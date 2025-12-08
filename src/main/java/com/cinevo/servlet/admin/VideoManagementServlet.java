package com.cinevo.servlet.admin;

import java.io.IOException;
import java.util.Date;

import org.apache.commons.beanutils.BeanUtils;

import com.cinevo.dao.CategoryDAO;
import com.cinevo.dao.VideoDAO;
import com.cinevo.dao.impl.CategoryDAOImpl;
import com.cinevo.dao.impl.VideoDAOImpl;
import com.cinevo.entity.Category;
import com.cinevo.entity.Video;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet({ "/admin/videos", "/admin/videos/create", "/admin/videos/update", "/admin/videos/delete",
		"/admin/videos/edit", "/admin/videos/reset" })
public class VideoManagementServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");

		VideoDAO videoDAO = new VideoDAOImpl();
		CategoryDAO categoryDAO = new CategoryDAOImpl();
		Video form = new Video();
		String path = request.getServletPath();
		String message = "";

		try {
			// CREATE
			if (path.equals("/admin/videos/create")) {
				// Manual mapping for create to avoid detached entity
				form.setTitle(request.getParameter("title"));
				form.setDescription(request.getParameter("description"));
				form.setPosterUrl(request.getParameter("posterUrl"));
				form.setVideoUrl(request.getParameter("videoUrl"));
				form.setDirector(request.getParameter("director"));
				
				String releaseYearStr = request.getParameter("releaseYear");
				if (releaseYearStr != null && !releaseYearStr.isEmpty()) {
					form.setReleaseYear(Integer.parseInt(releaseYearStr));
				}
				
				form.setUploadedDate(new Date());
				form.setViews(0);

				// Get category - load fresh from DB
				String categoryIdStr = request.getParameter("categoryId");
				if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
					Category category = categoryDAO.findById(Integer.parseInt(categoryIdStr));
					form.setCategory(category);
				}

				videoDAO.create(form);
				message = "Thêm video thành công!";
				form = new Video(); // Reset form
			}

			// UPDATE
			else if (path.equals("/admin/videos/update")) {
				String idStr = request.getParameter("id");
				Long id = Long.parseLong(idStr);
				Video existingVideo = videoDAO.findById(id);

				if (existingVideo != null) {
					existingVideo.setTitle(request.getParameter("title"));
					existingVideo.setDescription(request.getParameter("description"));
					existingVideo.setPosterUrl(request.getParameter("posterUrl"));
					existingVideo.setVideoUrl(request.getParameter("videoUrl"));
					existingVideo.setDirector(request.getParameter("director"));
					
					String releaseYearStr = request.getParameter("releaseYear");
					if (releaseYearStr != null && !releaseYearStr.isEmpty()) {
						existingVideo.setReleaseYear(Integer.parseInt(releaseYearStr));
					}

					// Update category
					String categoryIdStr = request.getParameter("categoryId");
					if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
						Category category = categoryDAO.findById(Integer.parseInt(categoryIdStr));
						existingVideo.setCategory(category);
					}

					videoDAO.update(existingVideo);
					message = "Cập nhật video thành công!";
				}
				form = new Video(); // Reset form
			}

			// DELETE
			else if (path.equals("/admin/videos/delete")) {
				Long id = Long.parseLong(request.getParameter("id"));
				videoDAO.delete(id);
				message = "Xóa video thành công!";
			}

			// EDIT
			else if (path.equals("/admin/videos/edit")) {
				Long id = Long.parseLong(request.getParameter("id"));
				Video video = videoDAO.findById(id);
				form = video; // Populate form for editing
			}

			// RESET
			else if (path.equals("/admin/videos/reset")) {
				form = new Video(); // Clear form
			}

		} catch (Exception e) {
			e.printStackTrace();
			message = "Lỗi: " + e.getMessage();
		}

		// Load data for display
		request.setAttribute("videos", videoDAO.findAll());
		request.setAttribute("categories", categoryDAO.findAll());
		request.setAttribute("form", form);
		request.setAttribute("message", message);
		request.setAttribute("view", "/views/pages/admin/video-management.jsp");
		request.setAttribute("pageTitle", "Quản lý Video");
		request.getRequestDispatcher("/views/layouts/admin/layoutAdmin.jsp").forward(request, response);
	}
}
