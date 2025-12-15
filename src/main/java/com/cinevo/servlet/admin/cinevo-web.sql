DROP DATABASE Cinevo_web; 
CREATE DATABASE Cinevo_web;
GO
USE Cinevo_web;
GO

-- 1. Bảng Users
CREATE TABLE Users (
    Id BIGINT IDENTITY(1,1) PRIMARY KEY,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    [Password] NVARCHAR(255) NOT NULL,
    Fullname NVARCHAR(100) NULL,
    IsAdmin BIT NOT NULL DEFAULT 0
);
GO


-- 2. Bảng Categories
CREATE TABLE Categories (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL UNIQUE
);
GO

-- 3. Bảng Videos
CREATE TABLE Videos (
    Id BIGINT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(255) NOT NULL,
    [Description] NVARCHAR(MAX) NULL,
    PosterUrl NVARCHAR(500) NULL,
    VideoUrl NVARCHAR(500) NULL,
    Director NVARCHAR(100) NULL,
    ReleaseYear INT NULL,
    UploadedDate DATETIME2 NOT NULL DEFAULT GETDATE(),
    [Views] INT NOT NULL DEFAULT 0,
    CategoryId INT NOT NULL,
    CONSTRAINT FK_Videos_Categories FOREIGN KEY (CategoryId) REFERENCES Categories(Id)
);
GO

-- 4. Bảng Favorites
CREATE TABLE Favorites (
    Id BIGINT IDENTITY(1,1) PRIMARY KEY,
    UserId BIGINT NOT NULL,
    VideoId BIGINT NOT NULL,
    LikeDate DATETIME2 NOT NULL DEFAULT GETDATE(),
    -- Khóa ngoại
    CONSTRAINT FK_Favorites_Users FOREIGN KEY (UserId) REFERENCES Users(Id) ON DELETE CASCADE,
    CONSTRAINT FK_Favorites_Videos FOREIGN KEY (VideoId) REFERENCES Videos(Id) ON DELETE CASCADE,
    -- Ràng buộc UNIQUE
    CONSTRAINT UQ_Favorites_User_Video UNIQUE (UserId, VideoId)
);
GO

-- 5. Bảng Shares
CREATE TABLE Shares (
    Id BIGINT IDENTITY(1,1) PRIMARY KEY,
    UserId BIGINT NOT NULL,
    VideoId BIGINT NOT NULL,
    SharedToEmail NVARCHAR(100) NOT NULL,
    ShareDate DATETIME2 NOT NULL DEFAULT GETDATE(),
    -- Khóa ngoại
    CONSTRAINT FK_Shares_Users FOREIGN KEY (UserId) REFERENCES Users(Id) ON DELETE CASCADE,
    CONSTRAINT FK_Shares_Videos FOREIGN KEY (VideoId) REFERENCES Videos(Id) ON DELETE CASCADE
);
GO

-- Thêm dữ liệu mẫu cho Users (20 records)
INSERT INTO Users (Password, Fullname, Email, IsAdmin) 
VALUES
('123456', N'Châu Nhật Duy', 'duy@example.com', 1),
('pass002', N'Nguyễn Minh Anh', 'minhanh@gmail.com', 0),
('pass003', N'Lê Hoàng Nam', 'nam.le@gmail.com', 0),
('pass004', N'Trần Thu Hằng', 'hangtran@gmail.com', 0),
('pass005', N'Phạm Đức Toàn', 'toanpham@gmail.com', 1),
('pass006', N'Đỗ Ngọc Linh', 'linhdn@gmail.com', 0),
('pass007', N'Vũ Thanh Tùng', 'tungvu@gmail.com', 0),
('pass008', N'Ngô Quỳnh Trang', 'trangngo@gmail.com', 0),
('pass009', N'Lâm Hải Nam', 'hailam@gmail.com', 1),
('pass010', N'Đinh Bảo Ngọc', 'ngocbao@gmail.com', 0),
('fpt011', N'Nguyễn Hoài Phương', 'phuongnh@fpt.edu.vn', 0),
('fpt012', N'Lê Thanh Bình', 'binhlt@fpt.edu.vn', 1),
('fpt013', N'Trần Anh Tuấn', 'tuanta@fpt.edu.vn', 0),
('fpt014', N'Đỗ Thảo My', 'mydt@fpt.edu.vn', 0),
('fpt015', N'Phạm Hữu Tài', 'taiph@fpt.edu.vn', 1),
('pass016', N'Hoàng Thị Lan', 'lanhoang@gmail.com', 0),
('pass017', N'Nguyễn Văn Hải', 'hainguyen@gmail.com', 1),
('pass018', N'Trần Minh Khôi', 'khoitran@gmail.com', 0),
('pass019', N'Lê Thị Mai', 'maile@gmail.com', 0),
('pass020', N'Phạm Quốc Anh', 'anhpham@gmail.com', 0);
GO

-- Xem dữ liệu Users
SELECT * FROM Users;
GO

-- Thêm 20 record cho Categories
INSERT INTO Categories (Name)
VALUES
(N'Hành động'),
(N'Phiêu lưu'),
(N'Kinh dị'),
(N'Hài hước'),
(N'Lãng mạn'),
(N'Khoa học viễn tưởng'),
(N'Hoạt hình'),
(N'Tâm lý'),
(N'Lịch sử'),
(N'Chiến tranh'),
(N'Tội phạm'),
(N'Âm nhạc'),
(N'Gia đình'),
(N'Thể thao'),
(N'Giả tưởng'),
(N'Bí ẩn'),
(N'Chính kịch'),
(N'Tây du ký'),
(N'Võ thuật'),
(N'Người lớn');
GO

-- Xem dữ liệu Categories
SELECT * FROM Categories;
GO

-- Thêm 20 record cho Videos
INSERT INTO Videos (Title, [Description], PosterUrl, VideoUrl, Director, ReleaseYear, CategoryId, [Views])
VALUES
(N'Avengers: Endgame', N'Cuộc chiến cuối cùng chống Thanos.', 'https://img.youtube.com/vi/pmN3kieZKak/maxresdefault.jpg', 'https://www.youtube.com/embed/pmN3kieZKak', N'Anthony Russo', 2019, 1, 15000000),
(N'Indiana Jones', N'Nhà thám hiểm săn kho báu.', 'https://img.youtube.com/vi/pmN3kieZKak/maxresdefault.jpg', 'https://www.youtube.com/embed/pmN3kieZKak', N'Steven Spielberg', 1981, 2, 8500000),
(N'The Conjuring', N'Gia đình bị ma ám.', 'https://img.youtube.com/vi/4H2Ui3ZKy7s/maxresdefault.jpg', 'https://www.youtube.com/embed/4H2Ui3ZKy7s', N'James Wan', 2013, 3, 6200000),
(N'Deadpool', N'Siêu anh hùng hài hước.', 'https://img.youtube.com/vi/ZIM1HydF9UA/maxresdefault.jpg', 'https://www.youtube.com/embed/ZIM1HydF9UA', N'Tim Miller', 2016, 4, 9800000),
(N'Titanic', N'Câu chuyện tình yêu trên tàu.', 'https://img.youtube.com/vi/uujdjah8wAA/maxresdefault.jpg', 'https://www.youtube.com/embed/uujdjah8wAA', N'James Cameron', 1997, 5, 12000000),
(N'Interstellar', N'Khám phá vũ trụ.', 'https://img.youtube.com/vi/Otp3fV5yd8c/maxresdefault.jpg', 'https://www.youtube.com/embed/Otp3fV5yd8c', N'Christopher Nolan', 2014, 6, 11000000),
(N'Toy Story', N'Đồ chơi sống dậy.', 'https://img.youtube.com/vi/vPfdnelsa90/maxresdefault.jpg', 'https://www.youtube.com/embed/vPfdnelsa90', N'John Lasseter', 1995, 7, 7500000),
(N'Shutter Island', N'Điều tra trên đảo.', 'https://img.youtube.com/vi/xvaRHXSU3WE/maxresdefault.jpg', 'https://www.youtube.com/embed/xvaRHXSU3WE', N'Martin Scorsese', 2010, 8, 5800000),
(N'Schindler''s List', N'Cứu người Do Thái.', 'https://img.youtube.com/vi/mScpHTIi-kM/maxresdefault.jpg', 'https://www.youtube.com/embed/mScpHTIi-kM', N'Steven Spielberg', 1993, 9, 4500000),
(N'Saving Private Ryan', N'Chiến tranh Thế chiến II.', 'https://img.youtube.com/vi/HxCXaULRbwg/maxresdefault.jpg', 'https://www.youtube.com/embed/HxCXaULRbwg', N'Steven Spielberg', 1998, 10, 8000000),
(N'The Godfather', N'Gia đình mafia.', 'https://img.youtube.com/vi/pLtHyLlLt4Y/maxresdefault.jpg', 'https://www.youtube.com/embed/pLtHyLlLt4Y', N'Francis Ford Coppola', 1972, 11, 10500000),
(N'La La Land', N'Tình yêu và âm nhạc.', 'https://img.youtube.com/vi/eTc_rL-RgJA/maxresdefault.jpg', 'https://www.youtube.com/embed/eTc_rL-RgJA', N'Damien Chazelle', 2016, 12, 6800000),
(N'Finding Nemo', N'Cá nhỏ lạc mẹ.', 'https://img.youtube.com/vi/z0b6cb0Gqbw/maxresdefault.jpg', 'https://www.youtube.com/embed/z0b6cb0Gqbw', N'Andrew Stanton', 2003, 13, 9200000),
(N'Rocky', N'Võ sĩ quyền anh.', 'https://img.youtube.com/vi/SAFDSeAVIoY/maxresdefault.jpg', 'https://www.youtube.com/embed/SAFDSeAVIoY', N'John G. Avildsen', 1976, 14, 7100000),
(N'The Lord of the Rings', N'Chúa nhẫn.', 'https://img.youtube.com/vi/cu44uuI0G9Y/maxresdefault.jpg', 'https://www.youtube.com/embed/cu44uuI0G9Y', N'Peter Jackson', 2001, 15, 13500000),
(N'Gone Girl', N'Vợ mất tích.', 'https://img.youtube.com/vi/ZBJXthec16o/maxresdefault.jpg', 'https://www.youtube.com/embed/ZBJXthec16o', N'David Fincher', 2014, 16, 5500000),
(N'The Shawshank Redemption', N'Tù nhân trốn thoát.', 'https://img.youtube.com/vi/pkXKWJX3NnE/maxresdefault.jpg', 'https://www.youtube.com/embed/pkXKWJX3NnE', N'Frank Darabont', 1994, 17, 14000000),
(N'Journey to the West', N'Tây du ký.', 'https://img.youtube.com/vi/TtP-GPxHpZw/maxresdefault.jpg', 'https://www.youtube.com/embed/TtP-GPxHpZw', N'Unknown', 1986, 18, 3200000),
(N'Crouching Tiger Hidden Dragon', N'Võ thuật cổ điển.', 'https://img.youtube.com/vi/Vr-K-B7uHOM/maxresdefault.jpg', 'https://www.youtube.com/embed/Vr-K-B7uHOM', N'Ang Lee', 2000, 19, 6500000),
(N'Spider-Man: No Way Home', N'Người nhện đa vũ trụ.', 'https://img.youtube.com/vi/JfVOs4VSpmA/maxresdefault.jpg', 'https://www.youtube.com/embed/JfVOs4VSpmA', N'Jon Watts', 2021, 1, 16000000);
GO

-- Xem dữ liệu Videos
SELECT * FROM Videos;
GO


-- Thêm 20 record cho Favorites
INSERT INTO Favorites (UserId, VideoId)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11), (12, 12), (13, 13), (14, 14), (15, 15),
(16, 16), (17, 17), (18, 18), (19, 19), (20, 20);
GO

-- Xem dữ liệu Favorites
SELECT * FROM Favorites;
GO

-- Thêm 20 record cho Shares
INSERT INTO Shares (UserId, VideoId, SharedToEmail)
VALUES
(1, 2, 'shared1@example.com'),
(2, 3, 'shared2@example.com'),
(3, 4, 'shared3@example.com'),
(4, 5, 'shared4@example.com'),
(5, 6, 'shared5@example.com'),
(6, 7, 'shared6@example.com'),
(7, 8, 'shared7@example.com'),
(8, 9, 'shared8@example.com'),
(9, 10, 'shared9@example.com'),
(10, 11, 'shared10@example.com'),
(11, 12, 'shared11@example.com'),
(12, 13, 'shared12@example.com'),
(13, 14, 'shared13@example.com'),
(14, 15, 'shared14@example.com'),
(15, 16, 'shared15@example.com'),
(16, 17, 'shared16@example.com'),
(17, 18, 'shared17@example.com'),
(18, 19, 'shared18@example.com'),
(19, 20, 'shared19@example.com'),
(20, 1, 'shared20@example.com');
GO

-- Xem dữ liệu Shares
SELECT * FROM Shares;
GO
 

select * from videos


select * from shares