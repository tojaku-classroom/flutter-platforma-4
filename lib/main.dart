import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutterapp/pages/home_page.dart';
import 'package:flutterapp/pages/login_page.dart';
import 'package:flutterapp/pages/page1.dart';
import 'package:flutterapp/pages/page2.dart';
import 'package:flutterapp/pages/register_page.dart';
import 'package:go_router/go_router.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(path: '/page1', builder: (context, state) => const Page1()),
        GoRoute(path: '/page2', builder: (context, state) => const Page2()),
        GoRoute(path: '/login', builder: (context, state) => LoginPage()),
        GoRoute(path: '/register', builder: (context, state) => RegisterPage()),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Moja aplikacija s Go routerom',
      theme: ThemeData(primarySwatch: Colors.indigo, useMaterial3: true),
      routerConfig: _router,
    );
  }
}
