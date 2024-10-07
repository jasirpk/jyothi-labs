import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jyothi_labs/view/screens/login_screen.dart';
import 'package:jyothi_labs/view_model/provider/quantity.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => QuantityCount()),
      ],
      child: JyothiLabs(),
    ),
  );
}

class JyothiLabs extends StatelessWidget {
  const JyothiLabs({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
