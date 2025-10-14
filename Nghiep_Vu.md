1.3. Mô tả yêu cầu hệ thống 
1.3.1. Tổng quan hệ thống 
-	Nền tảng LMS Tích hợp Chức năng Giảng dạy và Học tập Tương Tác Trực Tuyến là một hệ thống web/app cho phép giảng viên và sinh viên tham gia các hoạt động giảng dạy, học tập và tương tác theo thời gian thực.
-	Hệ thống cung cấp các chức năng chính:
	Quản lý người dùng (đăng ký, đăng nhập, phân quyền).
	Quản lý khóa học, bài giảng và tài liệu.
	Livestream và học trực tuyến.
	Làm bài tập, quiz và quản lý điểm số.
	Chat tương tác và thông báo.
	Báo cáo và thống kê phục vụ quản trị.
1.3.2. Danh sách các tác nhân (Actors). 
-	Quản trị viên (Admin) : Quản lý toàn bộ người dùng (giảng viên, sinh viên), khóa học, phân quyền, giám sát hoạt động hệ thống.
-	Giảng viên : Tạo khóa học, đăng bài giảng, livestream, tạo quiz/bài tập, chấm điểm và trao đổi với sinh viên
-	Sinh viên : Tham gia khóa học, xem bài giảng, tham gia livestream, làm bài tập/quiz, xem kết quả và tương tác với giảng viên.
1.3.3. Yêu cầu chức năng
1.3.3.1. Quản lý người dùng: 
-	Cho phép người dùng đăng ký tài khoản với vai trò: Sinh viên, Giảng viên, Quản trị viên.
-	Cung cấp tính năng đăng nhập, chỉnh sửa hồ sơ, đổi mật khẩu và quản lý quyền truy cập.
-	Yêu cầu chi tiết:
	Đăng ký tài khoản: Người dùng cung cấp họ tên, email, số điện thoại, mật khẩu.
	Đăng nhập: Xác thực email/số điện thoại và mật khẩu.
	Quên mật khẩu: Gửi email xác nhận và cấp lại mật khẩu mới.
	Quản lý hồ sơ: Cho phép người dùng chỉnh sửa ảnh đại diện, số điện thoại, mô tả ngắn.
-	Phân quyền:
	Sinh viên: chỉ tham gia khóa học và làm bài
	Giảng viên: tạo/ quản lý khóa học, bài tập, livestream.
	Quản trị viên: quản lý toàn bộ hệ thống, tài khoản, dữ liệu.
1.3.3.2. Quản lý khoá học 
-	Giảng viên có thể tạo, chỉnh sửa, xóa khóa học; sinh viên đăng ký hoặc được thêm vào khóa học.
-	Yêu cầu chi tiết:
	Tạo khóa học mới với các thông tin: tên khóa học, mô tả, thời gian bắt đầu/kết thúc, danh mục.
	Cho phép tải lên giáo trình, tài liệu liên quan.
	Quản lý danh sách sinh viên tham gia (thêm/xóa, phê duyệt đăng ký).
	Hiển thị danh sách khóa học cho từng người dùng (sinh viên, giảng viên).
	Tìm kiếm, lọc khóa học theo tên, giảng viên hoặc danh mục.
1.3.3.3. Quản lý bài giảng, tài liệu 
-	Giảng viên quản lý nội dung bài giảng của từng khóa học, sinh viên có thể xem và tải về.
-	Yêu cầu chi tiết:
	Thêm/sửa/xóa bài giảng.
	Tải lên tài liệu (file PDF, PPT, video).
	Quản lý thứ tự bài giảng theo chương/mục.
	Sinh viên có thể xem trước hoặc tải tài liệu.
	Đảm bảo chỉ sinh viên trong khóa học mới có quyền truy cập
1.3.3.4. Học trực tuyến
-	Cho phép giảng viên phát trực tiếp (livestream) hoặc mở phòng học online, sinh viên tham gia và tương tác thời gian thực.
-	Yêu cầu chi tiết:
	Giảng viên khởi tạo buổi học trực tuyến, đặt tiêu đề, ngày/giờ, mô tả.
	Sinh viên tham gia buổi học qua link trong hệ thống.
	Tính năng chat trực tiếp trong phòng học.
	Tích hợp màn hình chia sẻ tài liệu/bài giảng trong buổi học.
	Tự động lưu lại buổi học (ghi hình) để sinh viên xem lại.
1.3.3.5. Quiz và Bài tập trực tuyến
-	Giảng viên tạo quiz (trắc nghiệm) và bài tập, sinh viên làm trực tuyến, hệ thống tự chấm điểm quiz.
-	Yêu cầu chi tiết:
	Tạo quiz với nhiều loại câu hỏi: trắc nghiệm 1 đáp án, nhiều đáp án, đúng/sai.
	Cài đặt thời gian làm bài, số lần làm bài.
	Hệ thống tự động chấm điểm và lưu kết quả quiz.
	Tạo bài tập tự luận, cho phép sinh viên nộp file hoặc nhập trực tiếp.
	Cho phép giảng viên chấm điểm bài tự luận và xuất nhận xét.
	Hiển thị lịch sử làm bài và kết quả cho từng sinh viên.
1.3.3.6. Quản lý điểm số 
-	Hệ thống lưu trữ điểm của sinh viên theo từng bài tập, quiz và khóa học.
-	Yêu cầu chi tiết:
	Tự động tổng hợp điểm quiz và bài tập.
	Giảng viên có thể nhập hoặc điều chỉnh điểm thủ công.
	Xuất bảng điểm theo định dạng Excel/PDF.
	Sinh viên có thể xem điểm của mình, không được chỉnh sửa.
	Quản trị viên có quyền xem và xuất toàn bộ dữ liệu điểm.
1.3.3.7. Chat & tương tác
-	Hỗ trợ giao tiếp giữa giảng viên và sinh viên qua tin nhắn trong khóa học.
-	Yêu cầu chi tiết:
	Chat nhóm theo từng lớp học.
	Chat riêng giữa sinh viên – giảng viên.
	Gửi thông báo quan trọng của khóa học.
	Hiển thị lịch sử chat theo thời gian thực.
1.3.3.8. Báo cáo và thống kê
-	Cung cấp báo cáo cho quản trị viên và giảng viên theo dữ liệu hệ thống.
-	Yêu cầu chi tiết:
	Thống kê số lượng người dùng theo vai trò.
	Thống kê số khóa học đang hoạt động.
	Thống kê tỷ lệ hoàn thành khóa học của sinh viên.
	Biểu đồ kết quả điểm số, lịch sử đăng nhập.
	Xuất báo cáo theo file PDF/Excel.
1.3.4. Yêu cầu phi chức năng 
-	Yêu cầu giao diện: Thân thiện, dễ sử dụng, bố cục rõ ràng, hỗ trợ Responsive Design cho máy tính và di động.
-	Tính khả dụng : Website cần phải hoạt động ổn định, có khả năng phục vụ nhiều người dùng cùng lúc.
-	Yêu cầu bảo mật : Bảo vệ thông tin cá nhân và dữ liệu nhạy cảm; mật khẩu được mã hóa, phân quyền rõ ràng cho từng vai trò, hỗ trợ xác thực và khôi phục mật khẩu qua email.
-	Tính phản hồi: Giao diện phản hồi nhanh với thao tác người dùng, hiển thị thông báo lỗi hoặc xác nhận kịp thời.
-	Khả năng mở rộng: Dễ dàng nâng cấp để phục vụ nhiều người dùng và tích hợp thêm tính năng mới trong tương lai.
-	Tính tương thích: Hoạt động tốt trên các trình duyệt phổ biến (Chrome, Firefox, Edge, Safari) và các thiết bị (PC, máy tính bảng, điện thoại).
