

import 'package:flutter/material.dart';

import '../views/splash_screen.dart';
import '../views/home_page.dart';
import '../views/detalle_page.dart';

class AppRoutes {
  // Asegurarse de usar las mismas clases de vista
  static Map<String, WidgetBuilder> routes = {
    "/splash": (_) => const SplashScreen(),
    "/": (_) => const HomePage(),
    "/detalle": (_) => const DetallePage(),
  };
}