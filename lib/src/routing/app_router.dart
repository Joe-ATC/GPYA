import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/src/features/dashboard/dashboard_screen.dart';
import 'package:myapp/src/features/home/home_screen.dart';
import 'package:myapp/src/features/services/services_screen.dart';
import 'package:myapp/src/features/settings/settings_screen.dart';
import 'package:myapp/src/features/scaffold_with_nav_bar.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        builder: (BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/',
                builder: (BuildContext context, GoRouterState state) {
                  return const HomeScreen();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/dashboard',
                builder: (BuildContext context, GoRouterState state) {
                  return const DashboardScreen();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/services',
                builder: (BuildContext context, GoRouterState state) {
                  return const ServicesScreen();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/settings',
                builder: (BuildContext context, GoRouterState state) {
                  return const SettingsScreen();
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
