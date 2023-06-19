import 'dart:convert';
import 'dart:developer';

import 'package:dbms_app/database/mysql.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:ui';

import 'FadeAnimation.dart';
import '../../theme.dart';
import '../provider/provider.dart';

class LoginPageThree extends ConsumerStatefulWidget {
  const LoginPageThree({Key? key}) : super(key: key);

  @override
  _LoginPageThreeState createState() => _LoginPageThreeState();
}

class _LoginPageThreeState extends ConsumerState<LoginPageThree> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late bool isPasswordVisible;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isButtonEnabled = true;

  @override
  initState() {
    super.initState();
    isPasswordVisible = false;
    // test();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    checkAuthentication(state) {
      if (state is Authenticated) {
        print('Authenticated user');
      } else if (state is LoginError) {
        const snackBar = SnackBar(
          content:
              Text('User not found. Please enter a registered email address.'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    return Theme(
      data: ThemeData(
          colorScheme: myTheme.colorScheme, textTheme: myTheme.textTheme),
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/bg3.jpg"), fit: BoxFit.cover),
          ),
          child: Center(
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(
                    parent: NeverScrollableScrollPhysics()),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(26.0),
                      child: Form(
                        key: _formKey,
                        child: Center(
                          child: ClipRect(
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color:
                                        const Color.fromARGB(0, 253, 252, 252)
                                            .withOpacity(0.3),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                5,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Sign in to continue',
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w600,
                                                  color: myTheme.textTheme
                                                      .headline2?.color),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 250,
                                        height: 40,
                                        child: TextFormField(
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'This field is required';
                                            }
                                            if (!RegExp(r'\S+@\S+\.\S+')
                                                .hasMatch(value)) {
                                              return "Please enter a valid email address";
                                            }
                                            return null;
                                          },
                                          controller: emailController,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5)),
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 20,
                                                    horizontal: 20),
                                            labelText: 'Email Address',
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      SizedBox(
                                        width: 250,
                                        height: 40,
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'This field is required';
                                            }
                                            return null;
                                          },
                                          obscureText: !isPasswordVisible,
                                          controller: passwordController,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5)),
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .tertiary),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 20,
                                                    horizontal: 20),
                                            labelText: 'Password',
                                            suffixIcon: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: IconButton(
                                                splashColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onPressed: () {
                                                  setState(() {
                                                    isPasswordVisible =
                                                        !isPasswordVisible;
                                                  });
                                                },
                                                icon: Icon(
                                                  isPasswordVisible
                                                      ? Icons.visibility_off
                                                      : Icons.visibility,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: GestureDetector(
                                          onTap: (() {
                                            ref
                                                .read(authentication.notifier)
                                                .updateState(ForgotPassword());
                                          }),
                                          child: Text(
                                            "Forgot Password?",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: myTheme.textTheme
                                                    .headline2?.color),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      FadeAnimation(
                                        1.6,
                                        Container(
                                          height: 30,
                                          width: 150,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 50),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: myTheme.buttonTheme
                                                  .colorScheme?.primary),
                                          child: Center(
                                            child: GestureDetector(
                                              onTap: () async {
                                                if (isButtonEnabled) {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    await ref
                                                        .read(authentication
                                                            .notifier)
                                                        .login(
                                                            emailController.text
                                                                .toString()
                                                                .trim(),
                                                            passwordController
                                                                .text);
                                                    isButtonEnabled = false;

                                                    print('Form is valid');
                                                  } else {
                                                    print('Form is invalid');
                                                  }
                                                }
                                              },
                                              child: const Text(
                                                "Login",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      FadeAnimation(
                                        1.6,
                                        Container(
                                          height: 30,
                                          width: 150,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 50),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: myTheme.buttonTheme
                                                  .colorScheme?.primary),
                                          child: Center(
                                            child: GestureDetector(
                                              onTap: () {
                                                ref
                                                    .read(
                                                        authentication.notifier)
                                                    .updateState(Register());
                                              },
                                              child: const Text(
                                                "Create Account",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 50,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
