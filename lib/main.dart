import 'package:flutter/material.dart';

import 'screens/album_tab.dart';
import 'screens/danh_sach_tab.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'F5_231A290134',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0468D7)),
      ),
      home: const HomePage(),
    );
  }
}

/// Khung chính: AppBar + 2 tab + NavigationBar.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tab == 0 ? 'Danh sách sản phẩm' : 'Album ảnh'),
      ),
      // IndexedStack giữ trạng thái cả hai tab: thêm/xóa ở tab Danh sách
      // không bị mất khi chuyển sang tab Lưới rồi quay lại.
      body: IndexedStack(
        index: _tab,
        children: const [
          DanhSachTab(),
          AlbumTab(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (i) => setState(() => _tab = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.list),
            selectedIcon: Icon(Icons.list_alt),
            label: 'Danh sách',
          ),
          NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view),
            label: 'Lưới',
          ),
        ],
      ),
    );
  }
}
