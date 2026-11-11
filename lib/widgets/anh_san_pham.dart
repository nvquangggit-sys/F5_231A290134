import 'package:flutter/material.dart';

/// Widget ảnh dùng chung cho cả danh sách và lưới.
///
/// Nếu chưa chép ảnh vào assets (hoặc gõ sai đường dẫn), `errorBuilder` hiển thị
/// một ô xám thay vì màn hình đỏ lỗi — app vẫn chạy bình thường.
class AnhSanPham extends StatelessWidget {
  final String duongDan;
  final double? kichThuoc;

  const AnhSanPham({super.key, required this.duongDan, this.kichThuoc});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      duongDan,
      width: kichThuoc,
      height: kichThuoc,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        width: kichThuoc,
        height: kichThuoc,
        color: Colors.grey.shade300,
        child: const Icon(Icons.image_not_supported, color: Colors.grey),
      ),
    );
  }
}
