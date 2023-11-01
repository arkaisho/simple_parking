import 'package:flutter/material.dart';
import 'package:simple_parking/presentation/views/home/home_screen.dart';
import 'package:simple_parking/presentation/views/space_details/space_detail_screen.dart';

final GlobalKey<NavigatorState> appKey = GlobalKey<NavigatorState>();

final Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (_) => const HomeScreen(),
  SpaceDetailsScreen.routeName: (_) => const SpaceDetailsScreen(),
};
