AWS CLI & TERRAFORM
1. AWS Command Line Interface (AWS CLI)
Công cụ giúp giao tiếp với AWS từ máy tính cá nhân thông qua Terminal mà không cần đăng nhập vào trang web.

Link tải chính thức: https://aws.amazon.com/cli/
Lệnh thiết lập môi trường (Chỉ chạy 1 lần):bash: aws configure
Khi chạy lệnh này, hệ thống sẽ yêu cầu nhập 4 thông tin:
AWS Access Key ID: (Mã Key của IAM User)
AWS Secret Access Key: (Mã Secret của IAM User)
Default region name: ap-southeast-1 (Khu vực Singapore)
Default output format: json

2. Terraform (Infrastructure as Code)
Công cụ tự động hóa hạ tầng của hãng HashiCorp.

Bạn sẽ chạy Terraform trên máy tính của bạn (Windows/Mac/Linux), không phải trên máy chủ EC2.

Truy cập trang chủ Terraform: https://developer.hashicorp.com/terraform/downloads
Tải phiên bản tương ứng với hệ điều hành của bạn.
Giải nén file tải về, bạn sẽ nhận được một file thực thi duy nhất là terraform.exe (với Windows) hoặc terraform (với Mac/Linux).
Đưa file này vào biến môi trường (Environment Variables / PATH) của hệ điều hành để có thể gõ lệnh terraform từ bất kỳ thư mục nào trong Terminal.
Mở Terminal (Command Prompt / VS Code Terminal) và gõ terraform -version để kiểm tra. Nếu in ra phiên bản là cài đặt thành công.

Quy trình 4 lệnh cốt lõi (Workflow):
Khởi tạo dự án:bash
terraform init (Tải các plugin của provider như AWS về máy).

Xem trước kế hoạch (An toàn):bash
terraform plan (In ra màn hình những gì sẽ được tạo, sửa, hoặc xóa. Bắt buộc nên chạy để rà soát trước).

Thực thi tạo hạ tầng:bash
terraform apply (Gõ yes để xác nhận. Terraform sẽ gọi AWS API để tạo tài nguyên).

Hủy diệt hạ tầng:bash
terraform destroy (Gõ yes để xác nhận. Dọn dẹp sạch sẽ mọi tài nguyên đã tạo từ file code, ngăn chặn việc bị trừ tiền quên tắt máy).

📚 TÀI LIỆU THAM KHẢO NHANH
1. Link Tải Chính Thức:

AWS CLI: https://aws.amazon.com/cli/ (Dành cho việc quản lý tài khoản AWS từ máy tính).
Terraform: https://developer.hashicorp.com/terraform/downloads (Công cụ viết code hạ tầng).
2. Các lệnh AWS CLI cốt lõi:

aws configure: Lệnh quan trọng nhất để cài đặt Access Key, Secret Key và Region vào máy tính.
aws s3 ls: Liệt kê tất cả các S3 Bucket đang có trong tài khoản của bạn.
aws ec2 describe-instances: Liệt kê các máy chủ EC2 đang chạy (kết quả trả về dạng JSON hơi dài).
3. Quy trình 4 lệnh Terraform chuẩn mực:

terraform init: Khởi tạo môi trường (Chỉ cần chạy 1 lần lúc mới tạo dự án hoặc khi thêm thư viện mới).
terraform plan: Xem trước Kế hoạch (Cho biết đoạn code sẽ Tạo thêm +, Sửa đổi ~ hay Xóa bỏ - cái gì). Rất an toàn.
terraform apply: Thực thi Kế hoạch (Bắt buộc phải gõ yes để xác nhận xây dựng hạ tầng).
terraform destroy: Hủy diệt toàn bộ hạ tầng đã tạo bằng đoạn code hiện tại (Chống cháy túi!).