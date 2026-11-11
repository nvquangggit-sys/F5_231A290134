/// Model của một sản phẩm — tách dữ liệu ra khỏi giao diện.
///
/// Mọi trường đều `final` để đối tượng bất biến (immutable). Khi cần đổi dữ liệu,
/// ta tạo đối tượng mới hoặc thay phần tử trong danh sách, không sửa lén từng trường.
class SanPham {
  /// Mã định danh duy nhất — dùng làm key cho Dismissible.
  /// KHÔNG dùng chỉ số index làm key vì index đổi ngay khi xóa một mục ở giữa.
  final int id;
  final String ten;
  final String moTa;

  /// Giá tính bằng đồng. Dùng int cho tiền tệ, KHÔNG dùng double.
  final int gia;

  /// Đường dẫn asset, ví dụ 'assets/images/p1.jpg'.
  final String anh;

  const SanPham({
    required this.id,
    required this.ten,
    required this.moTa,
    required this.gia,
    required this.anh,
  });

  @override
  String toString() => 'SanPham($id, $ten, $gia)';
}
