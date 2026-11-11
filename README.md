# Lab F5 — Danh sách & lưới trong Flutter

**Sinh viên:** Nguyễn Việt Quang — **MSSV:** 231A290134
**Môn:** Lập trình thiết bị di động (INT4211)
**Thiết bị kiểm thử:** Pixel 6 API 34 (Android 14, x86_64) — 1080 × 2400, 420 dpi
**Flutter 3.47.3 (stable) · Dart 3.13.3**

Ứng dụng “Sản phẩm VHU” minh hoạ toàn bộ nội dung Lab F5: danh sách dài với `ListView.builder`,
đường kẻ với `ListView.separated`, model class riêng, dòng `Card + ListTile`, thêm/xoá bằng
`setState`, `Dismissible` có key ổn định, lưới `GridView.builder` co giãn theo bề rộng màn hình
và ảnh asset có `errorBuilder`.

| | |
|---|---|
| Báo cáo (PDF) | [`docs/BaoCao_LabF5_231A290134.pdf`](docs/BaoCao_LabF5_231A290134.pdf) |
| Báo cáo (Word) | [`docs/BaoCao_LabF5_231A290134.docx`](docs/BaoCao_LabF5_231A290134.docx) |
| Video demo (48 giây) | [`docs/F5_231A290134_demo.mp4`](docs/F5_231A290134_demo.mp4) |

## Chức năng

- **Tab Danh sách** — `ListView.builder` với `itemCount` / `itemBuilder`; mỗi dòng là `Card` bọc
  `ListTile` (ảnh 56 × 56 bo góc, tên `maxLines: 1`, mô tả `maxLines: 1`, giá đã định dạng).
  Dòng đếm “x/y sản phẩm” và tổng tiền cập nhật theo dữ liệu đang hiển thị.
- **Thêm** — nút `+` chèn sản phẩm mới lên đầu danh sách bằng `setState`.
- **Xoá** — vuốt sang trái; nền đỏ kèm biểu tượng thùng rác; `Dismissible` dùng
  `ValueKey<int>(sp.id)` (id dữ liệu, **không** dùng index).
- **Trạng thái rỗng** — xoá hết hiện “Danh sách trống” kèm nút thêm, không để màn hình trắng.
- **Tab Lưới** — `GridView.builder` + `SliverGridDelegateWithMaxCrossAxisExtent(230)`,
  `childAspectRatio: 0.78`, ảnh bọc `Expanded` nên không tràn ô.

### Bài nâng cao (đề yêu cầu ≥ 1, đã làm cả 4)

| Mã | Nội dung |
|---|---|
| NC1 | Thanh tìm kiếm lọc danh sách theo tên khi đang gõ (`where(...).toList()`), có trạng thái “không tìm thấy” |
| NC2 | Bấm một dòng / một ô lưới mở màn hình chi tiết bằng `Navigator.push` |
| NC3 | SnackBar “Đã xoá …” kèm nút **Hoàn tác**, khôi phục đúng vị trí cũ |
| NC4 | Lưới tự đổi số cột theo bề rộng: dọc 2 cột, xoay ngang 4 cột |

## Cấu trúc mã nguồn

```
lib/
├── main.dart                     # MaterialApp + HomePage (AppBar, IndexedStack 2 tab, NavigationBar)
├── models/san_pham.dart          # lớp dữ liệu SanPham (id, ten, moTa, gia, anh)
├── data/kho_san_pham.dart        # duLieuMau 6 sản phẩm + dinhDangGia() + tongTien()
├── widgets/anh_san_pham.dart     # Image.asset dùng chung, có errorBuilder
└── screens/
    ├── danh_sach_tab.dart        # ListView.builder / separated, lọc, thêm, xoá, hoàn tác
    ├── album_tab.dart            # GridView.builder + gridDelegate
    └── chi_tiet_san_pham.dart    # màn hình chi tiết (NC2)
assets/images/p1.jpg … p6.jpg     # 6 ảnh 600 × 600, < 200 KB mỗi ảnh
test/                             # 5 bài kiểm thử: định dạng giá, dữ liệu mẫu, tổng tiền, smoke, thêm món
```

Tổng cộng **748 dòng Dart** trong `lib/`.

## Cách chạy

```bash
flutter pub get
flutter run                 # hoặc: flutter build apk --debug
```

Khai báo asset trong `pubspec.yaml` (khai báo theo thư mục, **không** đệ quy):

```yaml
flutter:
  uses-material-design: true
  assets:
    - assets/images/
```

## Kết quả kiểm tra

```
$ flutter analyze
Analyzing F5_231A290134...
No issues found! (ran in 2.7s)

$ flutter test
00:02 +5: All tests passed!
```

## Minh chứng

Ảnh chụp màn hình thật (adb, không dàn dựng) nằm trong [`docs/screenshots/`](docs/screenshots):

| Tệp | Nội dung |
|---|---|
| `f5_home.png` | Tab Danh sách — 6/6 sản phẩm, tổng 1.055.000 đ |
| `f5_add.png` | Bấm `+` — “Sản phẩm mới 1” nằm đầu danh sách, 7/7 |
| `f5_scroll.png` | 12/12 sản phẩm sau khi cuộn |
| `f5_swipe.png` | Đang vuốt: nền đỏ + biểu tượng thùng rác |
| `f5_delete.png` | Xoá “Sổ tay sinh viên” ở giữa danh sách, SnackBar có Hoàn tác |
| `f5_undo.png` | Bấm Hoàn tác — danh sách trở lại 6/6 |
| `f5_empty.png` | Xoá hết — “Danh sách trống” |
| `f5_search.png` | NC1 — lọc “balo” còn 1/12 |
| `f5_detail.png` | NC2 — màn hình chi tiết |
| `f5_separated.png` | `ListView.separated` — có đường kẻ |
| `f5_grid.png` | Lưới dọc — 2 cột |
| `f5_landscape.png` | Xoay ngang — 4 cột |
| `f5_key_index_error.png` | Thí nghiệm `ValueKey(index)` — lỗi thật của `Dismissible` |
| `f5_lazy_100k.png` | Thí nghiệm 100.000 mục — chỉ 11 dòng được dựng |
| `f5_grid_180_doc.png` · `f5_grid_180_ngang.png` | Thí nghiệm `maxCrossAxisExtent: 180` — 3 cột / 5 cột |

Ba thí nghiệm trong báo cáo đều chạy thật trên máy ảo; log lưu tại
[`docs/logs/`](docs/logs):

- `valuekey_index_rebuild.txt` — log `itemBuilder` sau khi xoá mục giữa bằng `ValueKey(index)`.
- `lazy_100000.txt` — toàn bộ 11 dòng log của danh sách 100.000 mục.

## Ghi công

Ảnh sản phẩm lấy từ Wikipedia / Wikimedia Commons — xem [`CREDITS.md`](CREDITS.md).
