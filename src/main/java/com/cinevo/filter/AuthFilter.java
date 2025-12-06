package com.cinevo.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import com.cinevo.entity.User;

/**
 * Filter để bảo vệ các trang cần đăng nhập và phân quyền
 */
@WebFilter({
	"/cinevo/admin",
	"/cinevo/admin/*",
	"/user/favorite",
	"/user/favorite/*",
	"/user/share",
	"/user/share/*",
	"/user/change-password",
	"/user/profile"
})
public class AuthFilter extends HttpFilter implements Filter {
	
	public static final String SECURITY_URL = "securityUrl";
   
    public AuthFilter() {
        super();
    }

	@Override
	public void destroy() {
		// Cleanup nếu cần
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
			throws IOException, ServletException {
		
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		HttpSession session = req.getSession();
		User user = (User) session.getAttribute("user");
		String uri = req.getRequestURI();
		
		String message = "";

	    // Kiểm tra user đã đăng nhập chưa
	    if (user == null) {
	        message = "Vui lòng đăng nhập để sử dụng chức năng này!";
	        
	    } else if (uri.contains("/cinevo/admin")) {
	        // Kiểm tra quyền admin cho trang admin
	        if (!user.getIsAdmin()) {
	            message = "Bạn không có quyền truy cập trang quản trị!";
	        }
	    } else if (uri.contains("/user/")) {
	        // Các chức năng user thường (favorite, share, profile, change-password)
	        // Admin không được sử dụng các chức năng này
	        if (user.getIsAdmin()) {
	            message = "Tài khoản Admin không được sử dụng chức năng này!";
	        }
	    }

	    if (!message.isEmpty()) { 
	        session.setAttribute("securityMessage", message); 
	        session.setAttribute(AuthFilter.SECURITY_URL, uri);
	        
	        // Redirect về trang phù hợp
	        if (user != null && user.getIsAdmin()) {
	            // Admin đang cố vào trang user -> về admin
	            resp.sendRedirect(req.getContextPath() + "/cinevo/admin");
	        } else {
	            // User chưa login hoặc user thường cố vào admin -> về login
	            resp.sendRedirect(req.getContextPath() + "/cinevo/user?tab=login");
	        }
	        return;
	    } else {
	        chain.doFilter(request, response);
	    }
	}

	@Override
	public void init(FilterConfig fConfig) throws ServletException {
		// Khởi tạo filter
	}
}
