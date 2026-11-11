import 'package:flutter/material.dart';

import '../data/kho_san_pham.dart';
import '../models/san_pham.dart';
import '../widgets/anh_san_pham.dart';
import 'chi_tiet_san_pham.dart';

/// Tab 1 — ListView.builder + Card + ListTile + Dismissible.
///
/// Có thêm: lọc theo tên (NC1), SnackBar "Hoàn tác" (NC3) và chế độ
/// ListView.separated để thấy đường kẻ giữa các dòng.
class DanhSachTab extends StatefulWidget {
  const DanhSachTab({super.key});

  @override
  State<DanhSachTab> createState() => _DanhSachTabState();
}

class _DanhSachTabState extends State<DanhSachTab> {
  /// Bản sao của dữ liệu mẫu: thêm/xóa trên bản này, không đụng dữ liệu gốc.
  final List<SanPham> _tatCa = List.of(duLieuMau);

  final TextEditingController _timKiem = TextEditingController();
  String _tuKhoa = '';
  bool _coDuongKe = false;

  int _demThem = 0;
  int _idKeTiep = 1000;
  int _lanSnackBar = 0;

  @override
  void dispose() {
    _timKiem.dispose();
    super.dispose();
  }

  /// Danh sách sau khi lọc — nguồn dữ liệu thật sự của ListView.
  List<SanPham> get _hienThi {
    final k = _tuKhoa.trim().toLowerCase();
    if (k.isEmpty) return List.of(_tatCa);
    return _tatCa.where((sp) => sp.ten.toLowerCase().contains(k)).toList();
  }

  void _them() {
    final gio = TimeOfDay.now().format(context);
    setState(() {
      _demThem++;
      _tatCa.insert(
        0,
        SanPham(
          id: _idKeTiep++,
          ten: 'Sản phẩm mới $_demThem',
          moTa: 'Vừa được thêm lúc $gio',
          gia: 50000 * _demThem,
          anh: 'assets/images/p1.jpg',
        ),
      );
      // Bỏ từ khóa để món vừa thêm luôn nhìn thấy ở đầu danh sách.
      _tuKhoa = '';
      _timKiem.clear();
    });
  }

  void _xoa(SanPham sp) {
    final viTriGoc = _tatCa.indexWhere((e) => e.id == sp.id);
    if (viTriGoc < 0) return;

    setState(() => _tatCa.removeAt(viTriGoc));

    final messenger = ScaffoldMessenger.of(context);
    // Chỉ giữ một SnackBar tại một thời điểm để nút Hoàn tác không bị xếp hàng.
    messenger.clearSnackBars();
    messenger.showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 4),
        content: Text('Đã xóa ${sp.ten}'),
        action: SnackBarAction(
          label: 'Hoàn tác',
          onPressed: () {
            if (!mounted) return;
            setState(() {
              final viTri = viTriGoc > _tatCa.length ? _tatCa.length : viTriGoc;
              _tatCa.insert(viTri, sp);
            });
          },
        ),
      ),
    );

    // Tự ẩn sau 4 giây. Đặt tường minh để hành vi giống nhau trên mọi thiết bị
    // và để SnackBar cũ không "đè" lên trạng thái rỗng khi xóa hết.
    final lan = ++_lanSnackBar;
    Future<void>.delayed(const Duration(seconds: 4), () {
      if (!mounted || lan != _lanSnackBar) return;
      messenger.hideCurrentSnackBar();
    });
  }

  void _xoaTuKhoa() {
    setState(() {
      _tuKhoa = '';
      _timKiem.clear();
    });
  }

  void _moChiTiet(SanPham sp) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ChiTietSanPhamScreen(sanPham: sp),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ds = _hienThi;

    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _timKiem,
                      textInputAction: TextInputAction.search,
                      onChanged: (v) => setState(() => _tuKhoa = v),
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Tìm sản phẩm theo tên…',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: _tuKhoa.isEmpty
                            ? null
                            : IconButton(
                                tooltip: 'Xóa từ khóa',
                                icon: const Icon(Icons.clear),
                                onPressed: _xoaTuKhoa,
                              ),
                        filled: true,
                        fillColor: theme.colorScheme.surfaceContainerHighest
                            .withValues(alpha: 0.45),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filledTonal(
                    tooltip: _coDuongKe
                        ? 'Tắt đường kẻ (ListView.builder)'
                        : 'Bật đường kẻ (ListView.separated)',
                    onPressed: () =>
                        setState(() => _coDuongKe = !_coDuongKe),
                    icon: Icon(
                      _coDuongKe
                          ? Icons.border_clear
                          : Icons.border_horizontal,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 2),
              child: Row(
                children: [
                  Text(
                    '${ds.length}/${_tatCa.length} sản phẩm',
                    style: theme.textTheme.labelLarge
                        ?.copyWith(color: theme.colorScheme.primary),
                  ),
                  const Spacer(),
                  Text(
                    'Tổng: ${tongTien(ds)}',
                    style: theme.textTheme.labelLarge
                        ?.copyWith(color: theme.colorScheme.outline),
                  ),
                ],
              ),
            ),
            Expanded(child: _buildDanhSach(ds)),
          ],
        ),
        Positioned(
          right: 16,
          bottom: 16,
          child: FloatingActionButton.extended(
            onPressed: _them,
            icon: const Icon(Icons.add),
            label: const Text('Thêm'),
          ),
        ),
      ],
    );
  }

  Widget _buildDanhSach(List<SanPham> ds) {
    if (_tatCa.isEmpty) {
      return _trangThaiRong();
    }
    if (ds.isEmpty) {
      return _khongTimThay();
    }

    // In ra mỗi lần một dòng thật sự được dựng — dùng để chứng minh
    // ListView.builder chỉ dựng các mục đang nhìn thấy.
    Widget dong(BuildContext context, int index) {
      final sp = ds[index];
      debugPrint('F5_231A290134 itemBuilder dựng dòng $index — ${sp.ten}');
      return _dongSanPham(sp);
    }

    if (_coDuongKe) {
      return ListView.separated(
        padding: const EdgeInsets.fromLTRB(8, 4, 8, 92),
        itemCount: ds.length,
        itemBuilder: dong,
        separatorBuilder: (_, _) => const Divider(
          height: 1,
          thickness: 1,
          indent: 16,
          endIndent: 16,
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 92),
      itemCount: ds.length,
      itemBuilder: dong,
    );
  }

  Widget _dongSanPham(SanPham sp) {
    final theme = Theme.of(context);

    return Dismissible(
      // key PHẢI duy nhất và ổn định. Dùng id của dữ liệu, KHÔNG dùng index.
      key: ValueKey<int>(sp.id),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.only(right: 24),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          color: Colors.red.shade600,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) => _xoa(sp),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 4),
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          onTap: () => _moChiTiet(sp),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: AnhSanPham(duongDan: sp.anh, kichThuoc: 56),
          ),
          title: Text(
            sp.ten,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            sp.moTa,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Text(
            dinhDangGia(sp.gia),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _trangThaiRong() {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.inventory_2_outlined,
              size: 64, color: theme.colorScheme.outlineVariant),
          const SizedBox(height: 12),
          const Text('Danh sách trống'),
          const SizedBox(height: 4),
          Text(
            'Nhấn nút Thêm để tạo sản phẩm đầu tiên',
            style: theme.textTheme.bodySmall
                ?.copyWith(color: theme.colorScheme.outline),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: _them,
            icon: const Icon(Icons.add),
            label: const Text('Thêm sản phẩm'),
          ),
        ],
      ),
    );
  }

  Widget _khongTimThay() {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search_off,
              size: 56, color: theme.colorScheme.outlineVariant),
          const SizedBox(height: 10),
          Text('Không tìm thấy sản phẩm phù hợp với “$_tuKhoa”'),
          const SizedBox(height: 8),
          TextButton(onPressed: _xoaTuKhoa, child: const Text('Xóa từ khóa')),
        ],
      ),
    );
  }
}
