package com.cinevo.servlet.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;

import com.cinevo.dao.UserDAO;
import com.cinevo.dao.impl.UserDAOImpl;
import com.cinevo.entity.User;

@WebServlet({"/admin/users", "/admin/users/create", "/admin/users/update", "/admin/users/delete", "/admin/users/edit", "/admin/users/reset"})
public class UserManagementServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		UserDAO userDAO = new UserDAOImpl();
		User form = new User();
		String path = request.getServletPath();
		String message = "";
		
		try {
			BeanUtils.populate(form, request.getParameterMap());
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// CRUD
		if (path.equals("/admin/users/create")) {
			try {
				if (userDAO.findByEmail(form.getEmail()) != null) {
					message = "Email đã tồn tại!";
				} else {
					userDAO.create(form);
					message = "Thêm thành công!";
					form = new User();
				}
			} catch (Exception e) {
				message = "Lỗi thêm user!";
				e.printStackTrace();
			}
		} else if (path.equals("/admin/users/update")) {
			try {
				User user = userDAO.findById(form.getId());
				if (user != null) {
					user.setEmail(form.getEmail());
					if (form.getPassword() != null && !form.getPassword().trim().isEmpty()) {
						user.setPassword(form.getPassword());
					}
					user.setFullname(form.getFullname());
					user.setIsAdmin(form.getIsAdmin());
					userDAO.update(user);
					message = "Cập nhật thành công!";
					form = new User();
				}
			} catch (Exception e) {
				message = "Lỗi cập nhật!";
				e.printStackTrace();
			}
		} else if (path.equals("/admin/users/delete")) {
			try {
				String idParam = request.getParameter("id");
				Long id = Long.parseLong(idParam);
				userDAO.delete(id);
				message = "Xóa thành công!";
			} catch (Exception e) {
				message = "Lỗi xóa user!";
				e.printStackTrace();
			}
		} else if (path.equals("/admin/users/edit")) {
			try {
				String idParam = request.getParameter("id");
				Long id = Long.parseLong(idParam);
				User user = userDAO.findById(id);
				form = user;
				message = "Đang sửa: " + user.getEmail();
			} catch (Exception e) {
				message = "Lỗi load user!";
				e.printStackTrace();
			}
		} else if (path.equals("/admin/users/reset")) {
			form = new User();
			message = "Đã reset form";
		}
		
		List<User> users = userDAO.findAll();
		request.setAttribute("users", users);
		request.setAttribute("form", form);
		request.setAttribute("message", message);
		request.setAttribute("view", "/views/pages/admin/user-management.jsp");
		request.setAttribute("pageTitle", "Quản lý người dùng");
		request.getRequestDispatcher("/views/layouts/admin/layoutAdmin.jsp").forward(request, response);
	}
}
