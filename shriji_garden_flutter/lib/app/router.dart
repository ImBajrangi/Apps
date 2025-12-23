import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/home/presentation/pages/home_page.dart';
import '../features/packages/presentation/pages/packages_page.dart';
import '../features/customize/presentation/pages/customize_page.dart';
import '../features/gallery/presentation/pages/gallery_page.dart';
import '../features/about/presentation/pages/about_page.dart';
import '../features/contact/presentation/pages/contact_page.dart';
import '../features/admin/presentation/pages/admin_requests_page.dart';
import '../shared/widgets/app_scaffold.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return AppScaffold(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const HomePage(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        ),
        GoRoute(
          path: '/packages',
          name: 'packages',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const PackagesPage(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        ),
        GoRoute(
          path: '/customize',
          name: 'customize',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const CustomizePage(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        ),
        GoRoute(
          path: '/gallery',
          name: 'gallery',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const GalleryPage(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        ),
        GoRoute(
          path: '/about',
          name: 'about',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const AboutPage(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        ),
        GoRoute(
          path: '/contact',
          name: 'contact',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const ContactPage(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        ),
        GoRoute(
          path: '/admin/requests',
          name: 'admin-requests',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const AdminRequestsPage(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        ),
      ],
    ),
  ],
);
