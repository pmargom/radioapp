import "package:go_router/go_router.dart";
import "package:radioapp/presentation/screens/home_screen.dart";
import 'package:radioapp/presentation/screens/radio_station_player.dart';

final appRouter = GoRouter(
  initialLocation: Routes.initial,
  routes: [
    GoRoute(
      path: Routes.initial,
      builder: (_, __) => const HomeScreen(),
    ),
    GoRoute(
      path: Routes.details,
      builder: (_, state) => RadioStationPlayerScreen(goRouterState: state),
    ),
  ],
);

class Routes {
  static const String initial = "/initial";
  static const String details = "/details";
}
