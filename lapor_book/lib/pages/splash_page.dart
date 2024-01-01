import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SplashFull();
  }
}

class SplashFull extends StatefulWidget {
  const SplashFull({super.key});

  @override
  State<StatefulWidget> createState() => _SplashPage();
}

class _SplashPage extends State<SplashFull> {
  @override
  void initState() {
    super.initState();
    // nanti bagian ini diganti cek koneksi ke firebase dan cek login
    Future.delayed(Duration.zero, (){
      Navigator.pushReplacementNamed(context, '/login');
    });      
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
      body: Center(
        child: Text('Selamat datang di Aplikasi Laporan'),
      ),
    ));
  }
}