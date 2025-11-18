package com.cinevo.servlet.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

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
			case "users":
				view = "/views/pages/admin/user-managerment.jsp"; 
				pageTitle = "Quản lý Người dùng";
				break;
				
			case "category":
				view = "/views/pages/admin/category-managerment.jsp"; 
				pageTitle = "Quản lý Thể loại";
				break;
				
			case "video":
				view = "/views/pages/admin/video-managerment.jsp"; 
				pageTitle = "Quản lý Video";
				break;
				

			case "favorites":
				view = "/views/pages/admin/favorite-managerment.jsp"; 
				pageTitle = "Thống kê Yêu thích";
				break;
				
			case "shares":
				view = "/views/pages/admin/share-category.jsp"; 
				pageTitle = "Thống kê Chia sẻ";
				break;
				
			case "dashboard":
			default:
				view = "/views/pages/admin/dashboard.jsp";
				pageTitle = "Trang chủ Admin";
				break;
		}

		request.setAttribute("view", view);
		request.setAttribute("pageTitle", pageTitle);
		
		request.getRequestDispatcher("/views/layouts/admin/layoutAdmin.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}