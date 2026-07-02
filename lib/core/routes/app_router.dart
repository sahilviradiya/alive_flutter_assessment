import 'package:flutter/material.dart';

import '../../presentation/auth/view/login_screen.dart';
import '../../presentation/home/view/home_screen.dart';
import '../../presentation/splash/view/splash_screen.dart';
import 'app_routes.dart';

/// Single source of truth for translating route names into pages.
class AppRouter {
  AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return _fadeRoute(const SplashScreen(), settings);
      case AppRoutes.login:
        return _fadeRoute(const LoginScreen(), settings);
      case AppRoutes.home:
        return _fadeRoute(const HomeScreen(), settings);
      default:
        return _fadeRoute(
          Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
          settings,
        );
    }
  }

  static Route<dynamic> _fadeRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      transitionDuration: const Duration(milliseconds: 350),
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}
