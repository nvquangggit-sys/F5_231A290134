import 'package:flutter_test/flutter_test.dart';

import 'package:f5_231a290134/data/kho_san_pham.dart';
import 'package:f5_231a290134/models/san_pham.dart';

void main() {
  group('dinhDangGia', () {
    test('chèn dấu chấm phân cách nghìn', () {
      expect(dinhDangGia(180000), '180.000 đ');
      expect(dinhDangGia(75000), '75.000 đ');
      expect(dinhDangGia(1000), '1.000 đ');
      expect(dinhDangGia(950), '950 đ');
      expect(dinhDangGia(1000000), '1.000.000 đ');
    });
  });

  test('dữ liệu mẫu có 6 sản phẩm với id duy nhất', () {
    expect(duLieuMau.length, 6);
    final ids = duLieuMau.map((SanPham sp) => sp.id).toSet();
    expect(ids.length, 6);
  });

  test('tổng tiền của dữ liệu mẫu', () {
    expect(tongTien(duLieuMau), '1.055.000 đ');
  });
}
