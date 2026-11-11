import 'package:flutter/material.dart';

import '../data/kho_san_pham.dart';
import '../models/san_pham.dart';
import '../widgets/anh_san_pham.dart';

/// Màn hình chi tiết — bài nâng cao NC2, mở bằng Navigator.push từ một dòng
/// trong danh sách hoặc một ô trong lưới.
class ChiTietSanPhamScreen extends StatelessWidget {
  final SanPham sanPham;

  const ChiTietSanPhamScreen({super.key, required this.sanPham});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Chi tiết sản phẩm')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: AspectRatio(
              aspectRatio: 1.15,
              child: AnhSanPham(duongDan: sanPham.anh),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            sanPham.ten,
            style: theme.textTheme.headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Chip(
                avatar: const Icon(Icons.sell_outlined, size: 18),
                label: Text(
                  dinhDangGia(sanPham.gia),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 8),
              Chip(
                avatar: const Icon(Icons.qr_code_2, size: 18),
                label: Text('Mã #${sanPham.id}'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text('Mô tả', style: theme.textTheme.titleMedium),
          const SizedBox(height: 6),
          Text(sanPham.moTa, style: theme.textTheme.bodyLarge),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Thông tin', style: theme.textTheme.titleSmall),
                  const SizedBox(height: 8),
                  _dongThongTin('Tên', sanPham.ten),
                  _dongThongTin('Giá', dinhDangGia(sanPham.gia)),
                  _dongThongTin('Ảnh', sanPham.anh),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Màn hình này được mở bằng Navigator.push — bài nâng cao NC2.',
            style: theme.textTheme.bodySmall
                ?.copyWith(color: theme.colorScheme.outline),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _dongThongTin(String nhan, String giaTri) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 56,
            child: Text(nhan, style: const TextStyle(color: Colors.black54)),
          ),
          Expanded(child: Text(giaTri)),
        ],
      ),
    );
  }
}
