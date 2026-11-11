import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:f5_231a290134/main.dart';

void main() {
  testWidgets('mở app hiện 2 tab và danh sách 6 sản phẩm', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    expect(find.text('Danh sách sản phẩm'), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('6/6 sản phẩm'), findsOneWidget);
  });

  testWidgets('bấm Thêm thì sản phẩm mới nằm ở đầu danh sách', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();

    expect(find.text('Sản phẩm mới 1'), findsOneWidget);
    expect(find.text('7/7 sản phẩm'), findsOneWidget);
  });
}
