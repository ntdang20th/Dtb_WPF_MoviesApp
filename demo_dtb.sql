/*
use master
drop database DEMO_APP_XEMPHIM
go
*/
CREATE DATABASE DEMO_APP_XEMPHIM
GO

USE DEMO_APP_XEMPHIM
GO

CREATE TABLE ChuDe
(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	TenChuDe NVARCHAR(100)
)
go

--	Thể loại:
CREATE TABLE TheLoai
(
	Id INT IDENTITY PRIMARY KEY, 
	TenTheLoai NVARCHAR(100)
)



---	Tác giả
CREATE TABLE TacGia
(
	Id INT IDENTITY PRIMARY KEY, 
	TenTacGia NVARCHAR(200),
	GioiTinh NVARCHAR(4) CHECK (GioiTinh LIKE N'Nam' OR GioiTinh LIKE N'Nữ') DEFAULT N'Nam',
	NgaySinh DATE,
	QuocTich NVARCHAR(200)
)

---	Studio
CREATE TABLE Studio
(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	TenStudio NVARCHAR(100),
	GhiChu NVARCHAR(MAX)

)

---	Mùa
CREATE TABLE Mua
(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	TenMua NVARCHAR(100),
)


---	Trang thai
CREATE TABLE TrangThai
(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	TenTrangThai NVARCHAR(100)
)


--danh sach laut phim
CREATE TABLE Luat
(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	TenLuat NVARCHAR(100), 
)




---	Phim
CREATE TABLE Phim
(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	TenPhim NVARCHAR(400),
	IdChuDe INT, 
	SoTap INT,
	ThoiLuong INT,
	NoiDung NVARCHAR(MAX),
	NamPhatHanh INT,
	IdMua INT,
	IdTrangThai INT,
	ChatLuong NVARCHAR(10),	

	FOREIGN KEY (IdChuDe) REFERENCES ChuDe(Id),
	 FOREIGN KEY (IdMua) REFERENCES Mua(Id),
	 FOREIGN KEY (IdTrangThai) REFERENCES TrangThai(Id),
)

--luat phim
CREATE TABLE Cua_Phim_Luat
(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	IdPhim INT,
	IdLuat INT,

	FOREIGN KEY (IdPhim) REFERENCES Phim(Id),
	FOREIGN KEY (IdLuat) REFERENCES Luat(Id)
)



---	Cua_Phim_Studio
CREATE TABLE Cua_Phim_Studio
(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	IdPhim INT,
	IdStudio INT,

	FOREIGN KEY (IdPhim) REFERENCES Phim(Id),
	FOREIGN KEY (IdStudio) REFERENCES Studio(Id)
)

---	Cua_Phim_TheLoai
CREATE TABLE Cua_Phim_TheLoai
(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	IdPhim INT,
	IdTheLoai INT,

	FOREIGN KEY (IdPhim) REFERENCES Phim(Id),
	FOREIGN KEY (IdTheLoai) REFERENCES TheLoai(Id)
)


---	Cua_Phim_TacGia
CREATE TABLE Cua_Phim_TacGia
(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	IdPhim INT,
	IdTacGia INT,

	FOREIGN KEY (IdPhim) REFERENCES Phim(Id),
	FOREIGN KEY (IdTacGia) REFERENCES TacGia(Id)
)


--role nguoi dung
CREATE TABLE Quyen
(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	TenQuyen NVARCHAR(100), 
)
--thong tin nguoi dung
CREATE TABLE ThongTin_NguoiDung
(
	Id INT IDENTITY(1,1) PRIMARY KEY, 
	Ho_HoLot NVARCHAR(200),
	Ten NVARCHAR(50),
	NgaySinh DATE,
	Email VARCHAR(200),
)
--nggười dùng
CREATE TABLE NguoiDung
(
	Id INT IDENTITY(1,1) PRIMARY KEY, 
	TenDangNhap NVARCHAR(200),
	MatKhau NVARCHAR(200),
	IdThongTin INT UNIQUE FOREIGN KEY REFERENCES ThongTin_NguoiDung(Id)
)
--quyen nguoi dung
CREATE TABLE Cua_NguoiDung_Quyen
(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	IdNguoiDung INT,
	IdQuyen INT,

	FOREIGN KEY (IdNguoiDung) REFERENCES NguoiDung(Id),
	FOREIGN KEY (IdQuyen) REFERENCES Quyen(Id)
)



---	NguoiDung_Xem_Phim
CREATE TABLE NguoiDung_Xem_Phim
(
	Id	INT IDENTITY(1,1) PRIMARY KEY,
	NgayXem DATETIME,
	IdNguoiDung INT,
	IdPhim INT,

	FOREIGN KEY (IdPhim) REFERENCES Phim(Id),
	FOREIGN KEY (IdNguoiDung) REFERENCES NguoiDung(Id)
)
---	NguoiDung_BinhLuan_Phim
CREATE TABLE NguoiDung_BinhLuan_Phim
(
	Id	INT IDENTITY(1,1) PRIMARY KEY,
	NgayBinhLuan DATETIME,
	IdNguoiDung INT,
	IdPhim INT,
	NoiDung NVARCHAR(MAX),

	FOREIGN KEY (IdPhim) REFERENCES Phim(Id),
	FOREIGN KEY (IdNguoiDung) REFERENCES NguoiDung(Id)
)

---	NguoiDung_DanhGia_Phim
CREATE TABLE NguoiDung_DanhGia_Phim
(
	Id	INT IDENTITY(1,1) PRIMARY KEY,
	IdNguoiDung INT,
	IdPhim INT,
	DiemSo FLOAT,

	FOREIGN KEY (IdPhim) REFERENCES Phim(Id),
	FOREIGN KEY (IdNguoiDung) REFERENCES NguoiDung(Id)
)

CREATE TABLE TaiKhoan
(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	TenHienThi nvarchar(200),
	TenDangNhap varchar(200),
	MatKhau varchar(200),
	Quyen tinyint
)
insert into TaiKhoan values(N'Nguyễn Thành Đặng', 'admin', 'db69fc039dcbd2962cb4d28f5891aae1', 1) -- passs: admin
insert into TaiKhoan values(N'Nguyễn Thành Dảk', 'staff', '978aae9bb6bee8fb75de3e4830a1be46', 0) -- pass: staff





--ảnh đại diện phim
CREATE TABLE AnhDaiDien
(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	IdPhim INT unique FOREIGN KEY (IdPhim) REFERENCES Phim(Id),
	tenFileAnh nvarchar(max)

	
)

--video
CREATE TABLE VIDEO
(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	IdPhim INT,
	SoTap nvarchar(20),
	tenFileVideo nvarchar(max)

	FOREIGN KEY (IdPhim) REFERENCES Phim(Id),
) 












--data
--the loai
insert into TheLoai values(N'Đời Thường')
insert into TheLoai values(N'Harem')
insert into TheLoai values(N'Shounen')
insert into TheLoai values(N'Học đường')
insert into TheLoai values(N'Thể thao')
insert into TheLoai values(N'Drama')
insert into TheLoai values(N'Trinh thám')
insert into TheLoai values(N'Kinh dị')
insert into TheLoai values(N'Mecha')
insert into TheLoai values(N'Phép thuật')
insert into TheLoai values(N'Phiêu lưu')
insert into TheLoai values(N'Ecchi')
insert into TheLoai values(N'Hài hước')

--chu de
insert into ChuDe values(N'TV/Series')
insert into ChuDe values(N'Movie')
insert into ChuDe values(N'OVA')
insert into ChuDe values(N'Special')

--trang thai
insert into TrangThai values(N'Tất cả')
insert into TrangThai values(N'Hoàn thành')
insert into TrangThai values(N'Chưa xong')

--studio
insert into Studio values(N'A-1 Pictures', N'Là công ty con thuộc sở hữu mảng giải trí của tập đoàn Sony, tính về tuổi đời vẫn còn khá non trẻ trong ngành công nghiệp anime, A-1 Pictures gây dấu ấn với nhiều tác phẩm anime có hiệu ứng đẹp mắt và lấy đề tài khoa học viễn tưởng, tác phẩm tiêu biểu nhất của studio có thể kể đến loạt phim Blue Exorcist và thương hiệu phim chuyển thể từ light novel Sword Art Online.')
	
	insert into Studio values(N'TROYCA', N'TROYCA trong tiếng Nga có nghĩa là "nhóm ba người", ý chỉ ba trụ cột thành lập studio bao gồm nhà sản xuất Toshiyuki Nagano, đạo diễn hình ảnh Tomonobu Kato và đạo diễn đồ họa Ei Aoki. Chỉ mới trải qua bốn năm hoạt động với vỏn vẹn ba dự án, trong đó bộ phim đầu tay Aldnoah.Zero là sản phẩm hợp tác với A-1 Pictures. Tuy nhiên việc một studio non trẻ đạt giải thiết kế ngay từ dự án đầu tiên chứng minh được tiềm năng của TROYCA.')
	insert into Studio values(N'Sunrise', N'Hầu như mọt phim anime nào cũng biết đến tiếng tăm và vị thế của "ông lớn" Sunrise. Các series nhượng quyền về Gundam đem về các khoản lợi nhuận khổng lồ cho Sunrise trong thời hoàng kim của thể loại phim anime về robot. Tuy nhiên Sunrise không hề bị ảnh hưởng bởi cái bóng quá lớn của chính mình. Khi nhắc đến Sunrise khán giả còn nhớ đến bộ sưu tập đa dạng các series tươi sáng như Love Live! và các dự án thời vụ của studio này với các tác phẩm quen mặt như Gintama hay Aikatsu.')
	insert into Studio values(N'BONES', N'Nhà sản xuất lừng danh Masahiko Minami cùng các nhân viên của tập đoàn Sunrise đã đứng ra thành lập studio BONES và bắt đầu sản xuất những tác phẩm để đời của ông tại đây, bao gồm cả siêu phẩm kinh điển Cowboy Bebop.')
	insert into Studio values(N'Studio DEEN', N'Được đặt tên theo nhân vật robot giải cứu thế giới trong bộ phim anime kinh điển Brave Raideen, Studio DEEN từng là "sân nhà" chịu trách nhiệm cung cấp các sản phẩm gần như hoàn thiện cho tập đoàn Sunrise. Mất đến 8 năm kể từ khi ra mắt, Studio DEEN mới có thể tự lập và rời bỏ các ràng buộc với Sunrise để vươn lên trở thành một studio độc lập sở hữu số lượng lớn các tựa phim ăn khách như Ranma ½ hay Fate/Stay Night.')
	insert into Studio values(N'Ufotable', N'Phần hình ảnh và chuyển động của nhân vật trong các tác phẩm của Ufotable thường rất sắc nét và mượt mà. Thậm chí cộng đồng fan anime còn đặt cho studio biệt danh Unlimited Budgetworks (Ngân Sách Vô Tận) nhại theo tựa phim Fate/Stay Night: Unlimited Blade Works, một series có phần nhìn mãn nhãn bậc nhất trong các phiên bản của Fate/Stay Night.')
	insert into Studio values(N'David Production', N'Sau khi rời khỏi vị trí chủ tịch của studio Gonzo, Koji Kajita đã bắt tay cùng đạo diễn Taito Okiura lập nên studio của riêng mình. Đây cũng là nơi chịu trách nhiệm chuyển thể bộ truyện tranh shounen nổi tiếng Jojo’s Bizarre Adventure thành phiên bản anime năm 2012.')
	insert into Studio values(N'Gainax', N'Ra đời vào năm 1984, đa số các tác phẩm của Gainax đều là sản phẩm nguyên bản do nhân viên tại đây sáng tạo nên. Nhiều người cho rằng các tác phẩm của Gainax thường khó hiểu. Dự án nổi tiếng nhất của studio này chính là Neon Genesis Evangelion trước khi xuất hiện các phiên bản điện ảnh của Evangelion đến từ studio Khara.')
	insert into Studio values(N'Trigger', N'Đây là studio khá mới được thành lập bởi cựu nhân viên của Gainax. Trigger nổi tiếng với những ý tưởng đột phá có phần kỳ lạ xuất hiện trong sản phẩm của mình, chẳng hạn như bối cảnh các học sinh trong trường dạy ma thuật xem việc uống máu là một nghi thức bắt buộc trong Kill La Kill hay cuộc thí nghiệm giúp con người kết bạn bằng cách san sẻ nỗi đau của nhau trong Kiznaiver.')
	insert into Studio values(N'J.C. Staff', N'J.C. Staff là tên viết tắt của Janpan Creative Staff (Đội Ngũ Sáng Tạo Nhật Bản), đơn vị sở hữu hit anime năm 1997 có tên Revolutionary Girl Utena. Đây là một trong những studio năng suất cao trong ngành công nghiệp anime nước Nhật. Chỉ tính riêng năm nay studio đã kịp công bố 10 series anime để phủ sóng màn ảnh Nhật Bản.')
	insert into Studio values(N'Kyoto Animation', N'Kyoto Animation cực kỳ nổi tiếng với nét vẽ mềm mại và các hiệu ứng chuyển động linh hoạt. Studio cũng là nơi sản xuất hàng loạt light novel nổi tiếng và các bộ phim chuyển thể từ nguồn sách này. Ngay cả cuộc thi quy tụ các tác giả nộp tiểu thuyết của họ để tranh giải mỗi năm cũng là một nét độc đáo riêng của hãng. Tuy nhiên suốt ba năm qua studio vẫn để ngỏ giải thưởng lớn nhất của mình vì chưa tìm được tác phẩm xứng đáng.')
	insert into Studio values(N'Liden Films', N'Là một studio vẫn còn non trẻ, thời gian đầu khi ra mắt vào năm 2012, Liden Films thường hợp tác với một studio khác tên Ordet, nhưng hiện tại xưởng phim Liden đã có thể hoàn toàn độc lập phát hành các sản phẩm của riêng mình.')
	insert into Studio values(N'Madhouse', N'Với hơn 45 năm kinh nghiệm, Madhouse là studio được nhiều tác giả nổi tiếng chọn mặt gửi vàng phiên bản anime cho sản phẩm manga của họ. Đây cũng là nơi sản xuất khối lượng lớn các bộ anime bất hủ như Cardcaptor Sakura, Hunter x Hunter, Galaxy Angel hay The Girl Who Leapt Through Time...')
	insert into Studio values(N'MAPPA', N'MAPPA chính thức ghi tên mình vào danh sách những studio sinh sau đẻ muộn nhưng lại sớm gặt hái được thành công khi tháng trước phim điện ảnh In This Corner of the World do studio sản xuất đã đem về hơn 30 giải thưởng lớn nhỏ tại các liên hoan phim.')
	insert into Studio values(N'Mushi Production', N'Đầu những năm 1960, Mushi Production từng trải qua thời huy hoàng với nguồn ngân sách lớn và hàng loạt tác phẩm ăn khách như Astro Boy hay Kimba The White Lion. Tuy nhiên khoảng 10 năm sau đó studio chìm trong khủng hoảng cho đến khi mở lại vào năm 1977. Hiện nay Mushi chỉ đóng vai trò hỗ trợ các studio khác chứ không còn cho ra mắt tác phẩm của riêng mình.')
	insert into Studio values(N'Tezuka Production', N'Nhà sản xuất anime lừng lẫy Osamu Tezuka đã có quyết định đúng đắn khi lập nên Tezuka Production dưới dạng một chi nhánh tách ra từ Mushi Production và hoạt động như một công ty quản lý bản quyền phim. Khi Mushi Production phá sản vào năm 1973, Tezuka Production đã kế thừa kỹ thuật sản xuất phim anime của nó và tiếp tục duy trì hoạt động đến hiện tại.')
	insert into Studio values(N'Toei Animation', N'Ra mắt cùng năm với TMS Entertainment, hãng phim Toei Animation cũng lớn mạnh không kém với các tác phẩm đa dạng về thể loại từ hành động như Dragon Ball cho đến các dòng phim lãng mạn như Sailor Moon. Đây cũng từng là nơi làm việc của Osamu Tezuka trước khi ông mở hai studio Mushi và Tezuka của riêng mình.')
	insert into Studio values(N'Oriental Light and Magic', N'Đây là studio sở hữu nhiều tựa phim nổi tiếng với khán giả thiếu nhi như Pokémon hay Yokai Watch. Tuy nhiên gần đây studio cũng bắt đầu sản xuất một số sản phẩm nhắm tới nhóm công chúng trưởng thành như Utawarerumono, một series anime dựa trên tựa game được gắn mác 18+.')
	insert into Studio values(N'WHITE FOX', N'Sau khi Utawarerumono ra mắt, một số nhân viên của Oriental Light And Magic đã đứng ra thành lập studio mới mang tên WHITE FOX và nhận sản xuất một phiên bản truyền hình khác của Utawarerumono cùng một số phiên bản chuyển thể từ trò chơi điện tử hoặc tiểu thuyết, sách ảnh. Đến tận tháng 7 năm ngoái, WHITE FOX đã chính thức trình làng dự án 100% tự sản xuất của mình có tên Matoi The Sacred Slayer.')
	insert into Studio values(N'P.A. Works', N'P.A Works được biết đến bởi phần đồ họa có nét mảnh và mềm mại, đồng thời studio có thể sản xuất đa dạng thể loại anime từ các series hành động như CANAAN cho đến các câu chuyện tuổi trẻ nhẹ nhàng như The Eccentric Family.')
	insert into Studio values(N'Pierrot	Pierrot', N'là studio chủ lực chuyển thể các sản phẩm manga của tạp chí Shounen Jump, tiêu biểu là hai bộ manga shounen được yêu thích trên toàn cầu Naruto và Bleach.')
	insert into Studio values(N'Polygon Pictures', N'Trước khi chính thức ra mắt các sản phẩm mang dấu ấn riêng, Polygon Pictures chịu trách nhiệm đảm nhận các hiệu ứng CG cho nhiều phim anime, các quảng cáo thương mại và thậm chí là các phim truyền hình Mỹ như Transformers: Prime và Tron: Uprising. Hiện nay studio vẫn tận dụng kỹ thuật CG trong các tác phẩm của mình và tiếp tục phụ trách phần đồ họa của chuỗi phim điện ảnh thuộc vũ trụ quái vật Godzilla.')
	insert into Studio values(N'Production I.G.', N'Sở hữu bom tấn ra mắt vào năm 1995 Ghost In The Shell, Production I.G. tạo được vị thế vững chắc trong giới điện ảnh quốc tế. Đây cũng là studio có danh tiếng trong kỹ thuật đồ họa ứng dụng trong phim ảnh và video game.')
	insert into Studio values(N'SANZIGEN', N'Sanzigen cũng là studio nổi tiếng về kỹ thuật đồ họa phát triển từ các dự án hỗ trợ công cụ CG cho các xưởng phim khác.')
	insert into Studio values(N'SHAFT', N'Kể từ sản phẩm đầu tiên What’s Michael ra mắt vào năm 1988, Shaft vẫn giữ được dấu ấn đặc trưng về phong cách làm phim tận dụng được những góc quay sáng tạo, đồ họa trau chuốt, màu sắc rực rỡ và đặc biệt là hiệu ứng "góc nghiêng Shaft" – các cảnh quay khi nhân vật ngoái cổ về phía sau tạo ấn tượng về cả phần nhìn lẫn cảm xúc.')
	insert into Studio values(N'SILVER LINK.', N'Silver Link bước đầu gia nhập ngành với vai trò hỗ trợ sản xuất cho các bộ anime dài tập của các studio khác. Tuy nhiên đến hiện tại, đây là xưởng phim có số lượng sản phẩm ra mắt đều đặn và đa dạng bậc nhất trong thị trường Nhật Bản. Tính riêng năm 2016 hãng sở hữu đến sáu bộ phim anime truyền hình. Trong năm nay studio sẽ ra mắt phim điện ảnh anime đầu tiên với tên gọi Fate/Kaleid Liner Prisma Illya: Sekka No Chikai.')
	insert into Studio values(N'Tatsunoko Production', N'Nếu Tatsuo Yoshida được xem là nhà tiên phong khai phá tiềm năng của thế giới anime thì Tatsunoko Production chính là một trong những ông tổ của các xưởng phim ngày nay. Ở thời kỳ anime còn sơ khai, những tuyệt tác về siêu anh hùng của Tatsuo đã phát triển rực rỡ từ khi còn nằm trên những trang truyện màu. Ở giai đoạn này, nếu Superman là người hùng truyện tranh của trẻ em phương Tây thì những đứa trẻ Nhật Bản cũng đang say sưa trong chuyến giải cứu thế giới của siêu nhân Gatchaman.')
	insert into Studio values(N'TMS Entertainment', N'Sau hai lần đổi tên, TMS Entertainmet hiện tại đã trải qua hơn 70 năm hoạt động trong ngành công nghiệp anime. Bạn có thể dễ dàng nhận ra những đường nét quen thuộc và khá cổ điển trong các sản phẩm anime xuất xưởng. Đây cũng là nơi "cha đẻ Ghibli" Hayao Miyazaki công tác trước khi mở ra studio lừng lẫy của mình.')
	insert into Studio values(N'WIT STUDIO', N'Được xếp vào hàng ngũ những "tân binh" của ngành nhưng chất lượng của các dự án cộp mác WIT STUDIO luôn được đánh giá cao. Tiền thân là một chi nhánh được thành lập bởi cựu nhân viên của Production I.G và được chính "ông lớn" này đầu tư, tác phẩm ra mắt của WIT có tên Attack On Titans đã giúp studio đánh tiếng ngay khi vừa chập chững gia nhập thị trường anime Nhật.')
	insert into Studio values(N'Studio Ghibli', N'Danh sách các studio sản xuất anime của người Nhật không thể hoàn thiện nếu bỏ quên Studio Ghibli. Không những nổi tiếng toàn cầu và được lòng giới mộ điệu, Ghibli còn nổi tiếng cả với những khán giả "ngoại đạo". Sản phẩm của Ghibli thường được ca tụng là kiệt tác với cốt truyện ly kỳ cùng phong cách nghệ thuật không thể nhầm lẫn.')

--tac gia
insert into TacGia values(N'Tetsuya Chiba', N'Nam', '11/Jan/1939', N'Nhật Bản')
insert into TacGia values(N'Hayao Miyazaki', N'Nam', '5/Jan/1941', N'Nhật Bản')
insert into TacGia values(N'Adachi Mitsuru', N'Nam', '9/Feb/1951', N'Nhật Bản')
insert into TacGia values(N'Akira Toriyama', N'Nam', '5/Apr/1955', N'Nhật Bản')
insert into TacGia values(N'Rumiko Takahashi', N'Nam', '10/Oct/1957', N'Nhật Bản')
insert into TacGia values(N'Gosho Aoyama', N'Nam', '21/Jun/1963', N'Nhật Bản')

--mua
insert into Mua values(N'Xuân')
insert into Mua values(N'Hè')
insert into Mua values(N'Thu')
insert into Mua values(N'Đông')

--luat
insert into Luat values(N'Ẩn phim')
insert into Luat values(N'VIP')
insert into Luat values(N'Hạn chế tuổi')

--quyen
insert into Quyen values(N'BAN')
insert into Quyen values(N'VIP')
insert into Quyen values(N'Cấm xem')
insert into Quyen values(N'Cấm bình luận')
insert into Quyen values(N'Dưới 18 tuổi')


--nguoidung
insert into ThongTin_NguoiDung values(0,'nguyen thanh', 'dang', getdate(), '01548613')
insert into ThongTin_NguoiDung values(0,'nguyen thanh', 'ky', getdate(), '01548613')
insert into ThongTin_NguoiDung values(0,'nguyen thanh', 'nam', getdate(), '01548613')
insert into ThongTin_NguoiDung values(0,'nguyen thanh', 'tuan', getdate(), '01548613')
insert into ThongTin_NguoiDung values(0,'nguyen thanh', 'duy', getdate(), '01548613')

insert into NguoiDung values('admin1', 'db69fc039dcbd2962cb4d28f5891aae1',1 )
insert into NguoiDung values('admin2', 'db69fc039dcbd2962cb4d28f5891aae1',2 )
insert into NguoiDung values('admin3', 'db69fc039dcbd2962cb4d28f5891aae1',3 )
insert into NguoiDung values('admin4', 'db69fc039dcbd2962cb4d28f5891aae1',4 )
insert into NguoiDung values('admin5', 'db69fc039dcbd2962cb4d28f5891aae1',5 )

insert into Cua_NguoiDung_Quyen values(1,4)
insert into Cua_NguoiDung_Quyen values(1,2)
insert into Cua_NguoiDung_Quyen values(2,2)
insert into Cua_NguoiDung_Quyen values(3,1)
insert into Cua_NguoiDung_Quyen values(4,3)
insert into Cua_NguoiDung_Quyen values(4,5)
insert into Cua_NguoiDung_Quyen values(5,3)
insert into Cua_NguoiDung_Quyen values(5,5)

--PHIM


