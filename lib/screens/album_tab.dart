import 'package:flutter/material.dart';

import '../data/kho_san_pham.dart';
import '../models/san_pham.dart';
import '../widgets/anh_san_pham.dart';
import 'chi_tiet_san_pham.dart';

/// Tab 2 — GridView.builder.
///
/// Dùng SliverGridDelegateWithMaxCrossAxisExtent để lưới tự đổi số cột theo
/// bề rộng màn hình (bài nâng cao NC4): điện thoại dọc 2 cột, xoay ngang 4 cột.
class AlbumTab extends StatelessWidget {
  const AlbumTab({super.key});

  /// Bề rộng tối đa của một ô.
  static const double maxCrossAxisExtent = 230;

  static const double _spacing = 8;
  static const double _paddingNgang = 16; // 8 bên trái + 8 bên phải

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        // Công thức y hệt cách SliverGridDelegateWithMaxCrossAxisExtent tính,
        // để nhãn "n cột" luôn khớp với lưới thật:
        //   số cột = ceil(bề rộng còn lại / (bề rộng tối đa + khoảng cách)).
        final soCot = ((constraints.maxWidth - _paddingNgang) /
                (maxCrossAxisExtent + _spacing))
            .ceil();

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
              child: Row(
                children: [
                  Icon(Icons.grid_view,
                      size: 18, color: theme.colorScheme.primary),
                  const SizedBox(width: 6),
                  Text(
                    '$soCot cột',
                    style: theme.textTheme.labelLarge
                        ?.copyWith(color: theme.colorScheme.primary),
                  ),
                  const Spacer(),
                  Text(
                    'maxCrossAxisExtent = ${maxCrossAxisExtent.toInt()}',
                    style: theme.textTheme.labelSmall
                        ?.copyWith(color: theme.colorScheme.outline),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 12),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: maxCrossAxisExtent,
                  crossAxisSpacing: _spacing,
                  mainAxisSpacing: _spacing,
                  // rộng / cao — số càng nhỏ thì ô càng cao.
                  childAspectRatio: 0.78,
                ),
                itemCount: duLieuMau.length,
                itemBuilder: (context, index) {
                  final sp = duLieuMau[index];
                  return _oLuoi(context, sp);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _oLuoi(BuildContext context, SanPham sp) {
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => ChiTietSanPhamScreen(sanPham: sp),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: AnhSanPham(duongDan: sp.anh)),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    sp.ten,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    dinhDangGia(sp.gia),
                    style: TextStyle(
                        fontSize: 12, color: theme.colorScheme.primary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
