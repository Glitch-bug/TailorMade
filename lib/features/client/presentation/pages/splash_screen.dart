import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tailor_made/features/client/presentation/pages/clients_list_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 5),
      () => Navigator.push(context, const ClientsListPage().route()),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Expanded(
        child: Container(color: Colors.white, child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: size.width,),
              Image.asset("assets/images/needle.png"),
              const Text("Tailor Made", style: TextStyle(fontSize: 100, color: Colors.black, fontFamily: "Courier", fontWeight: FontWeight.bold))
            ],
          ),
        ),
        ),
      ),
    );
  }
}
