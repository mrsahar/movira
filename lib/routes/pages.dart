import 'package:movira/routes/route_observer.dart';
import 'package:movira/routes/routes.dart';
import 'package:movira/screens/static/intro_screen.dart';
import 'package:get/get.dart';

class AppPages {
  AppPages._();

  // Initial route
  static const initial = Routes.intro;

  // Route observer for tracking navigation
  static final MyRouteObserver routeObserver = MyRouteObserver();

  // All app pages/routes
  static final List<GetPage> pages = [
    // ============ Static Pages ============
    GetPage(
      name: Routes.intro,
      page: () => const IntroScreen(),
      transition: Transition.fadeIn,
    ),

    // ============ Authentication Pages ============

  ];
}