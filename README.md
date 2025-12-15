# 🎬 Cinevo Web - Hệ Thống Quản Lý Video & Phim

[![Java](https://img.shields.io/badge/Java-17-orange.svg)](https://openjdk.java.net/)
[![Maven](https://img.shields.io/badge/Maven-3.8+-blue.svg)](https://maven.apache.org/)
[![SQL Server](https://img.shields.io/badge/SQL%20Server-2019+-red.svg)](https://www.microsoft.com/en-us/sql-server)
[![Hibernate](https://img.shields.io/badge/Hibernate-6.6-green.svg)](https://hibernate.org/)
[![Jakarta EE](https://img.shields.io/badge/Jakarta%20EE-10-purple.svg)](https://jakarta.ee/)

## 🎯 Giới Thiệu

**Cinevo Web** là một hệ thống quản lý video và phim hiện đại được xây dựng bằng Java Servlet/JSP và Hibernate ORM, cung cấp đầy đủ chức năng cho việc quản lý video, danh mục phim và tương tác người dùng. Hệ thống hỗ trợ 2 vai trò: **Admin** và **User** với các quyền hạn khác nhau.

## ✨ Tính Năng Chính

### 🔐 Hệ Thống Phân Quyền
- **Admin**: Quản lý toàn bộ hệ thống, duyệt video, quản lý người dùng
- **User**: Xem video, yêu thích, chia sẻ, quản lý profile

### 🎥 Quản Lý Video
- ✅ **Tạo/Sửa/Xóa** video
- ✅ **Phân loại** theo danh mục
- ✅ **Upload** poster và video
- ✅ **Tìm kiếm** và lọc
- ✅ **Thống kê** lượt xem

### ❤️ Tương Tác Người Dùng
- ✅ **Favorite** - Lưu video yêu thích
- ✅ **Share** - Chia sẻ qua email
- ✅ **Profile** - Quản lý thông tin cá nhân
- ✅ **Reports** - Báo cáo thống kê (Admin)

### 🎨 Giao Diện
- ✅ **Responsive** design
- ✅ **Modern UI** với JSP components
- ✅ **Separate layouts** cho Admin và User
- ✅ **Reusable components**

## 🏗️ Kiến Trúc Hệ Thống

### 📁 Cấu Trúc Project
```
cinevo-web/
├── src/main/java/com/cinevo/
│   ├── servlet/             # Servlets (MVC)
│   │   ├── admin/          # Admin controllers
│   │   ├── auth/           # Authentication
│   │   └── user/           # User controllers
│   ├── dao/                # Data Access Objects
│   │   ├── impl/           # DAO implementations
│   │   └── *.java          # DAO interfaces
│   ├── entity/              # JPA Entities
│   ├── filter/              # Servlet filters
│   └── utils/               # Utility classes
├── src/main/webapp/
│   ├── views/               # JSP pages
│   │   ├── layouts/         # Layout templates
│   │   ├── components/      # Reusable components
│   │   └── pages/           # Page templates
│   ├── images/              # Static images
│   └── WEB-INF/             # Web configuration
└── src/main/resources/      # Resources & configs
```

### 🗄️ Cơ Sở Dữ Liệu
- **SQL Server** với 5 bảng chính:
  - `Users` - Thông tin người dùng
  - `Categories` - Danh mục phim
  - `Videos` - Thông tin video
  - `Favorites` - Danh sách yêu thích
  - `Shares` - Lịch sử chia sẻ

## 🚀 Cài Đặt & Chạy

### 📋 Yêu Cầu Hệ Thống
- **Java 17+**
- **Maven 3.8+**
- **SQL Server 2019+**
- **Tomcat 10+** (hoặc servlet container tương đương)

### ⚙️ Cấu Hình

#### 1. **Database Setup**
```sql
-- Chạy file SQL script có sẵn
-- File: src/main/resources/db-sql/cinevo-web.sql

-- Cách 1: Sử dụng SQL Server Management Studio (SSMS)
-- 1. Mở SSMS và kết nối đến SQL Server
-- 2. File → Open → File → Chọn cinevo-web.sql
-- 3. Execute (F5) để chạy script

-- Cách 2: Sử dụng sqlcmd
sqlcmd -S localhost -U sa -P your_password -i src/main/resources/db-sql/cinevo-web.sql
```

**Script sẽ tự động:**
- ✅ Tạo database `Cinevo_web`
- ✅ Tạo 5 bảng: Users, Categories, Videos, Favorites, Shares
- ✅ Insert 20 users mẫu (bao gồm admin)
- ✅ Insert 20 categories phim
- ✅ Insert 20 videos mẫu với YouTube links
- ✅ Insert dữ liệu favorites và shares

#### 2. **Cấu Hình Database**
Sửa file `src/main/resources/META-INF/persistence.xml`:
```xml
<property name="jakarta.persistence.jdbc.user" value="your_username" />
<property name="jakarta.persistence.jdbc.password" value="your_password" />
<property name="jakarta.persistence.jdbc.url" 
          value="jdbc:sqlserver://localhost:1433;databaseName=Cinevo_web;..." />
```

#### 3. **Cấu Hình Email (Optional)**
Nếu sử dụng tính năng gửi email:
```java
// src/main/java/com/cinevo/utils/EmailUtil.java
String username = "your_email@gmail.com";
String password = "your_app_password";
```

### 🏃‍♂️ Chạy Ứng Dụng

#### **Cách 1: Maven**
```bash
# Build project
mvn clean package

# Deploy WAR file vào Tomcat
# Copy target/cinevo-web-0.0.1-SNAPSHOT.war vào webapps/
```

#### **Cách 2: IDE (Eclipse/IntelliJ)**
1. Import project vào IDE
2. Cấu hình Tomcat server
3. Run on Server

### 🌐 Truy Cập
- **Trang chủ**: `http://localhost:8080/cinevo-web/`
- **Admin**: `http://localhost:8080/cinevo-web/admin/dashboard`
- **Đăng nhập**: `http://localhost:8080/cinevo-web/auth/login`

## 👥 Tài Khoản Mặc Định

### 🔑 Admin
- **Email**: `duy@example.com`
- **Password**: `123456`
- **Fullname**: Châu Nhật Duy

### 👤 User (Ví dụ)
- **Email**: `minhanh@gmail.com`
- **Password**: `pass002`
- **Fullname**: Nguyễn Minh Anh

> **Lưu ý**: Database có sẵn 20 users mẫu sau khi chạy script SQL

## 🔧 Công Nghệ Sử Dụng

### **Backend**
- **Java 17** - Ngôn ngữ lập trình
- **Jakarta Servlet 6.1.0** - Web framework
- **Jakarta JSP & JSTL 3.0** - View technology
- **Hibernate ORM 6.6** - JPA implementation
- **SQL Server JDBC** - Database driver
- **Jakarta Mail 2.1.1** - Email functionality
- **Lombok** - Reduce boilerplate code

### **Frontend**
- **JSP** - Server-side rendering
- **JSTL** - Tag libraries
- **HTML5/CSS3** - Markup & Styling
- **JavaScript** - Client-side logic

### **Build Tools**
- **Maven** - Dependency management
- **Maven Compiler Plugin** - Java compilation
- **Maven War Plugin** - Web application packaging

## 📊 Chức Năng Chi Tiết

### 🔐 **Authentication & Authorization**
- **Login/Logout** với session management
- **Register** - Đăng ký tài khoản mới
- **Role-based access control** (Admin/User)
- **Password change** - Đổi mật khẩu
- **Filter-based security** cho protected pages

### 🎥 **Video Management**
- **CRUD operations** đầy đủ
- **Category assignment** - Gán danh mục
- **View count tracking** - Theo dõi lượt xem
- **Search & filter** functionality
- **Active/Inactive** status management

### ❤️ **Favorite & Share System**
- **Add/Remove favorites** - Quản lý yêu thích
- **Share via email** - Chia sẻ qua email
- **Share history** - Lịch sử chia sẻ
- **Statistics** - Thống kê (Admin)

### 📈 **Reports & Analytics**
- **User statistics** - Thống kê người dùng
- **Video statistics** - Thống kê video
- **Favorite reports** - Báo cáo yêu thích
- **Share reports** - Báo cáo chia sẻ

## 🛠️ Development

### 📝 **Code Style**
- **MVC Pattern** - Tách biệt logic
- **DAO Pattern** - Data access abstraction
- **Entity Pattern** - JPA Entities với Lombok
- **Filter Pattern** - Servlet security

### 🧪 **Testing**
- **Unit Testing** - Test individual components
- **Integration Testing** - Test database connections
- **Manual Testing** - User interface testing

### 📦 **Deployment**
- **WAR packaging** - Standard web application
- **Tomcat deployment** - Production ready
- **Database migration** - SQL scripts

## 🤝 Contributing

### 📋 **Guidelines**
1. **Fork** repository
2. **Create** feature branch
3. **Commit** changes với clear messages
4. **Push** to branch
5. **Create** Pull Request

### 🔍 **Code Review**
- **Clean code** principles
- **Documentation** cho complex logic
- **Error handling** comprehensive
- **Security** best practices

## 📄 License

**MIT License** - Xem file `LICENSE` để biết thêm chi tiết.

## 📞 Support

### 🐛 **Bug Reports**
- Tạo issue với description chi tiết
- Include steps to reproduce
- Attach screenshots nếu cần

### 💡 **Feature Requests**
- Mô tả tính năng mong muốn
- Explain use case
- Provide mockups nếu có

### 📧 **Contact**
- **Email**: chauunhatduyyit@gmail.com
- **GitHub**: [@ndyudev](https://github.com/ndyudev)

---

## 🎉 **Kết Luận**

**Cinevo Web** là một hệ thống quản lý video hoàn chỉnh với đầy đủ tính năng hiện đại. Với kiến trúc MVC rõ ràng, Hibernate ORM mạnh mẽ và giao diện JSP responsive, project này phù hợp cho việc học tập và phát triển thực tế.

**Happy Coding! 🚀**
