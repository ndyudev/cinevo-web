package com.cinevo.servlet.admin;

import java.io.IOException;
import java.util.List;

import com.cinevo.dao.UserDAO;
import com.cinevo.dao.impl.UserDAOImpl;
import com.cinevo.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

// Đường dẫn truy cập: localhost:8080/cinevo-web/cinevo/admin
@WebServlet("/cinevo/admin")
public class AdminCinevo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdminCinevo() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String tab = request.getParameter("tab");
		String view = "";
		String pageTitle = "";

		if (tab == null || tab.isEmpty()) {
			tab = "dashboard";
		}

	switch (tab) {
		case "video":
			view = "/views/pages/admin/video-management.jsp"; 
			pageTitle = "Quản lý Video";
			break;
			
		case "category":
			view = "/views/pages/admin/category-management.jsp"; 
			pageTitle = "Quản lý Danh mục";
			break;
			
		case "users":
			UserDAO userDAO = new UserDAOImpl();
			List<User> users = userDAO.findAll();
			request.setAttribute("users", users);
			request.setAttribute("form", new User());
			view = "/views/pages/admin/user-management.jsp"; 
			pageTitle = "Quản lý Tài khoản";
			break;
			
		case "reports":
			view = "/views/pages/admin/reports.jsp"; 
			pageTitle = "Báo cáo thống kê";
			break;
			
		case "dashboard":
		default:
			view = "/views/pages/admin/dashboard.jsp";
			pageTitle = "Dashboard";
			break;
	}		request.setAttribute("view", view);
		request.setAttribute("pageTitle", pageTitle);
		
		request.getRequestDispatcher("/views/layouts/admin/layoutAdmin.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}