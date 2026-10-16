import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_made/core/theme/size_config.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((dur) {
      _timer = Timer(_brandholdDuration, _openHome);
    });
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
    final size = context.watch<SizeConfigCubit>().state;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: size.screenWidth),
          Image.asset(
            "assets/images/needle.png",
            width: 11.69 * size.imageSizeMultiplier,
          ),
          Text(
            "Tailor Made",
            style: TextStyle(
              fontSize: 10 * size.textMultiplier,
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
