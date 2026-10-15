import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tailor_made/features/client/presentation/pages/clients_list_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // declare timer && brandhold duration
  static const _brandholdDuration = Duration(seconds: 2);
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(_brandholdDuration, _openHome);
  }

  // open home
  void _openHome() {
    if (!mounted) return;
    Navigator.pushReplacement(context, const ClientsListPage().route());
  }

  // dispose timer
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: size.width),
          Image.asset("assets/images/needle.png"),
          const Text(
            "Tailor Made",
            style: TextStyle(
              fontSize: 100,
              color: Colors.black,
              fontFamily: "Courier",
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
