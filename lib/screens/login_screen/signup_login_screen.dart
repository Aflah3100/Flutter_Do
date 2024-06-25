import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_do/firebase/firebase_auth/firebase_auth_functions.dart';
import 'package:flutter_do/screens/home_screen/home_screen.dart';

enum UserMode { login, signup }

// ignore: must_be_immutable
class ScreenSignUpLogin extends StatelessWidget {
  //userModeNotifier
  late ValueNotifier userModeNotifier;

  ScreenSignUpLogin({super.key, required UserMode initialMode})
      : userModeNotifier = ValueNotifier(initialMode);

  //keys
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  //controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 1;
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        //Base-Column
        child: Column(
          children: [
            //Image-ClipRect
            ClipRRect(
              child: Image.asset(
                'assets/images/to-do-image.png',
              ),
            ),
            SizedBox(
              height: height * .05,
            ),

            //Text-Form & Buttons
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                  //User-Form
                  child: ValueListenableBuilder(
                      valueListenable: userModeNotifier,
                      builder: (ctx, userMode, _) {
                        return Form(
                            key: formKey,
                            child: Column(
                              children: [
                                //Text form field container-1
                                (userMode == UserMode.signup)
                                    ? Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2.0, horizontal: 30.0),
                                        width: width,
                                        height: height * 0.05,
                                        decoration: const BoxDecoration(
                                            color: Color(0xFFedf0f8),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30.0))),
                                        child: TextFormField(
                                            controller: nameController,
                                            validator: (value) =>
                                                (value == null || value.isEmpty)
                                                    ? 'Enter Name'
                                                    : null,
                                            keyboardType: TextInputType.name,
                                            decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'Name',
                                                hintStyle: TextStyle(
                                                    color: Color(0xFFb2b7bf),
                                                    fontSize: 18.0))),
                                      )
                                    : const SizedBox(),
                                (userMode == UserMode.signup)
                                    ? const SizedBox(
                                        height: 30.0,
                                      )
                                    : const SizedBox(),

                                //Text form field container-2
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 2.0, horizontal: 30.0),
                                  width: width,
                                  height: height * 0.05,
                                  decoration: const BoxDecoration(
                                      color: Color(0xFFedf0f8),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.0))),
                                  child: TextFormField(
                                      controller: emailController,
                                      validator: (value) =>
                                          (value == null || value.isEmpty)
                                              ? 'Enter Email'
                                              : null,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Email',
                                          hintStyle: TextStyle(
                                              color: Color(0xFFb2b7bf),
                                              fontSize: 18.0))),
                                ),
                                const SizedBox(
                                  height: 30.0,
                                ),

                                //Text form field container-3
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 2.0, horizontal: 30.0),
                                  width: width,
                                  height: height * 0.05,
                                  decoration: const BoxDecoration(
                                      color: Color(0xFFedf0f8),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.0))),
                                  child: TextFormField(
                                      validator: (value) =>
                                          (value == null || value.isEmpty)
                                              ? 'Enter Password'
                                              : null,
                                      controller: passwordController,
                                      obscureText: true,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Password',
                                          hintStyle: TextStyle(
                                              color: Color(0xFFb2b7bf),
                                              fontSize: 18.0))),
                                ),
                                const SizedBox(
                                  height: 30.0,
                                ),

                                //Sign-Up Button-Container
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 2.0, horizontal: 30.0),
                                  width: width,
                                  height: height * 0.05,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.0))),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      //Validate Crentials
                                      if (formKey.currentState!.validate()) {
                                        dynamic result;
                                        if (userModeNotifier.value ==
                                            UserMode.signup) {
                                          result = await FirebaseAuthFunctions
                                              .instance
                                              .regsiterNewUser(
                                                  nameController.text,
                                                  emailController.text,
                                                  passwordController.text);
                                        } else {
                                          result = await FirebaseAuthFunctions
                                              .instance
                                              .authenticateUser(
                                                  emailController.text,
                                                  passwordController.text);
                                        }
                                        if (result is User) {
                                          //User-Authentication-Successfull
                                          final userName = result.displayName;
                                          Navigator.of(
                                                  scaffoldKey.currentContext!)
                                              .pushReplacement(
                                                  MaterialPageRoute(
                                                      builder: (ctx) =>
                                                          ScreenHome(
                                                              userName:
                                                                  userName!)));
                                        } else if (result
                                            is FirebaseAuthException) {
                                          //User-Authentication-Failed
                                          ScaffoldMessenger.of(
                                                  scaffoldKey.currentContext!)
                                              .showSnackBar(SnackBar(
                                                  backgroundColor: Colors.red,
                                                  content: Text(
                                                    result.code,
                                                    style: const TextStyle(
                                                        fontSize: 18.0),
                                                  )));
                                        }
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF00C9FF)),
                                    child: Text(
                                      (userMode == UserMode.signup)
                                          ? 'Sign Up'
                                          : 'Log In',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),

                                //Login-Row
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        (userMode == UserMode.signup)
                                            ? "Already have an account?"
                                            : "New to the App?",
                                        style: const TextStyle(
                                            color: Color(0xFF8c8e98),
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w500)),
                                    const SizedBox(
                                      width: 5.0,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        userModeNotifier.value =
                                            (userModeNotifier.value ==
                                                    UserMode.signup)
                                                ? UserMode.login
                                                : UserMode.signup;
                                      },
                                      child: Text(
                                        (userMode == UserMode.signup)
                                            ? "LogIn"
                                            : "SignUp",
                                        style: const TextStyle(
                                            color: Color(0xFF273671),
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ));
                      })),
            ),
          ],
        ),
      ),
    );
  }
}
