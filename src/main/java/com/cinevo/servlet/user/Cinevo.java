package com.cinevo.servlet.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/cinevo/user")
public class Cinevo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Cinevo() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String tab = request.getParameter("tab");
		String view = "";
		String pageTitle = "Cinevo | User";

		if (tab == null || tab.isEmpty()) {
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
			default:
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