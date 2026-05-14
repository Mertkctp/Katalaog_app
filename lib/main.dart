import 'package:flutter/material.dart';
import 'package:mini_katalog_app/views/home_screen.dart'; // Dosya yolunun doğruluğundan emin ol

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Katalog',
      debugShowCheckedModeBanner:
          false, // Sağ üstteki kırmızı debug şeridini kaldırır
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home:
          const HomeScreen(), // Uygulama artık doğrudan senin yazdığın HomeScreen ile başlayacak
    );
  }
}
