import 'package:flutteer_todo_app/dashboard_screen.dart';
import 'package:flutteer_todo_app/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MainApp(
    token: prefs.getString('token'),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.token});

  final token;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Todo App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      home: (token != null && JwtDecoder.isExpired(token) == false)
          ? DashboardScreen(token: token)
          : const RegisterScreen(),
    );
  }
}
