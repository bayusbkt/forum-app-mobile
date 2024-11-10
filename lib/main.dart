import 'package:flutter/material.dart';
import 'package:forum_app/views/home_page.dart';
import 'package:forum_app/views/login_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final token = box.read('token');
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Forum.in',
      home: token == null ? const LoginPage() : HomePage(),
    );
  }
}
