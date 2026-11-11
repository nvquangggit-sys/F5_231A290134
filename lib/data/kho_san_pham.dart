import '../models/san_pham.dart';

/// "Cơ sở dữ liệu" tạm thời. Ở các lab sau sẽ thay bằng API hoặc SQLite
/// mà không phải sửa phần giao diện.
const List<SanPham> duLieuMau = [
  SanPham(
    id: 1,
    ten: 'Áo thun VHU',
    moTa: 'Cotton 100%, in logo trường',
    gia: 180000,
    anh: 'assets/images/p1.jpg',
  ),
  SanPham(
    id: 2,
    ten: 'Bình giữ nhiệt',
    moTa: 'Inox 500ml, giữ nóng 6 giờ',
    gia: 250000,
    anh: 'assets/images/p2.jpg',
  ),
  SanPham(
    id: 3,
    ten: 'Sổ tay sinh viên',
    moTa: '200 trang, bìa cứng',
    gia: 75000,
    anh: 'assets/images/p3.jpg',
  ),
  SanPham(
    id: 4,
    ten: 'Balo laptop',
    moTa: 'Chống nước, ngăn 15.6 inch',
    gia: 420000,
    anh: 'assets/images/p4.jpg',
  ),
  SanPham(
    id: 5,
    ten: 'Móc khóa gỗ',
    moTa: 'Khắc laser tên trường',
    gia: 35000,
    anh: 'assets/images/p5.jpg',
  ),
  SanPham(
    id: 6,
    ten: 'Cốc sứ in hình',
    moTa: 'Dung tích 350ml',
    gia: 95000,
    anh: 'assets/images/p6.jpg',
  ),
];

/// Định dạng 180000 → "180.000 đ" (không cần thư viện ngoài).
String dinhDangGia(int gia) {
  final s = gia.toString();
  final buf = StringBuffer();
  for (int i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
    buf.write(s[i]);
  }
  return '${buf.toString()} đ';
}

/// Tổng giá trị của một danh sách sản phẩm — dùng cho dòng thống kê.
String tongTien(Iterable<SanPham> ds) {
  var tong = 0;
  for (final sp in ds) {
    tong += sp.gia;
  }
  return dinhDangGia(tong);
}
