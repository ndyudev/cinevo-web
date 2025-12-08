package com.cinevo.servlet.admin;

import java.io.IOException;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;

import com.cinevo.dao.CategoryDAO;
import com.cinevo.dao.impl.CategoryDAOImpl;
import com.cinevo.entity.Category;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet({ "/admin/categories", "/admin/categories/create", "/admin/categories/update", 
	"/admin/categories/delete", "/admin/categories/edit", "/admin/categories/reset" })
public class CategoryManagementServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		CategoryDAO categoryDAO = new CategoryDAOImpl();
		Category form = new Category();
		String path = request.getServletPath();
		String message = "";

		try {
			BeanUtils.populate(form, request.getParameterMap());
		} catch (Exception e) {
			e.printStackTrace();
		}

		// CRUD
		if (path.equals("/admin/categories/create")) {
			try {
				form.setId(null); // Đảm bảo id = null khi thêm mới
				categoryDAO.create(form);
				message = "Thêm thành công!";
				form = new Category();
			} catch (Exception e) {
				message = "Lỗi thêm danh mục!";
				e.printStackTrace();
			}
		} else if (path.equals("/admin/categories/update")) {
			try {
				Category category = categoryDAO.findById(form.getId());
				if (category != null) {
					category.setName(form.getName());
					categoryDAO.update(category);
					message = "Cập nhật thành công!";
					form = new Category();
				}
			} catch (Exception e) {
				message = "Lỗi cập nhật!";
				e.printStackTrace();
			}
		} else if (path.equals("/admin/categories/delete")) {
			try {
				String idParam = request.getParameter("id");
				Integer id = Integer.parseInt(idParam);
				categoryDAO.delete(id);
				message = "Xóa thành công!";
			} catch (Exception e) {
				message = "Lỗi xóa danh mục!";
				e.printStackTrace();
			}
		} else if (path.equals("/admin/categories/edit")) {
			try {
				String idParam = request.getParameter("id");
				Integer id = Integer.parseInt(idParam);
				Category category = categoryDAO.findById(id);
				form = category;
				message = "Đang sửa: " + category.getName();
			} catch (Exception e) {
				message = "Lỗi load danh mục!";
				e.printStackTrace();
			}
		} else if (path.equals("/admin/categories/reset")) {
			form = new Category();
			message = "Đã reset form";
		}

		List<Category> categories = categoryDAO.findAll();
		request.setAttribute("categories", categories);
		request.setAttribute("form", form);
		request.setAttribute("message", message);
		request.setAttribute("view", "/views/pages/admin/category-management.jsp");
		request.setAttribute("pageTitle", "Quản lý danh mục");
		request.getRequestDispatcher("/views/layouts/admin/layoutAdmin.jsp").forward(request, response);
	}
}
