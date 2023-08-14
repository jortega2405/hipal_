import 'package:flutter/material.dart';
import 'package:hipal/providers/auth_provider.dart';
import 'package:hipal/providers/login_provider.dart';
import 'package:hipal/utils/constants.dart';
import 'package:hipal/viewmodels/login/login_view_model_impl.dart';
import 'package:hipal/views/home_screen.dart';
import 'package:hipal/views/login_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(
          create: (context) => LoginProvider(
            Provider.of<AuthProvider>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginViewModelImpl(
            Provider.of<LoginProvider>(context, listen: false),
            Provider.of<AuthProvider>(context, listen: false),
          ),
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hipal App',
      theme: ThemeData(
        primarySwatch: Constants.appColor,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
