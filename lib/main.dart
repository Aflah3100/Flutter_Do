import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_do/screens/home_screen/home_screen.dart';
import 'package:flutter_do/screens/login_screen/signup_login_screen.dart';
import 'package:flutter_do/utils/enums.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter-Do',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'OpenSans',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const AuthCheck());
  }
}

//User-Authentication-Check-Widget
class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  Future<User?> _getCurrentUser() async {
    return FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: _getCurrentUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasData) {
          final name = snapshot.data!.displayName ?? "USER";
          return ScreenHome(userName: name);
        } else {
          return ScreenSignUpLogin(initialMode: UserMode.signup);
        }
      },
    );
  }
}
