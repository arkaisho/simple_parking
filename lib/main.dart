import 'package:flutter/material.dart';
import 'package:simple_parking/presentation/views/home/home_screen.dart';
import 'package:simple_parking/utils/custom_colors.dart';
import 'package:simple_parking/utils/routes.dart';
import 'package:simple_parking/utils/setup_get_it.dart';

void main() {
  setupGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Parking',
      navigatorKey: appKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: CustomColors.primary,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      routes: routes,
    );
  }
}
