import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:ui';

import 'FadeAnimation.dart';
import '../../theme.dart';
import '../provider/provider.dart';

class ForgotPassPage extends ConsumerStatefulWidget {
  const ForgotPassPage({Key? key}) : super(key: key);

  @override
  _ForgotPassPageState createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends ConsumerState<ForgotPassPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          // colorScheme: lightColorScheme,
          textTheme: myTheme.textTheme),
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(top: 200.0),
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            // color: Color.fromARGB(255, 75, 122, 54),
            image: DecorationImage(
                image: AssetImage("assets/bg3.jpg"), fit: BoxFit.cover),
          ),
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
                                  color: Color.fromARGB(0, 253, 252, 252)
                                      .withOpacity(0.5),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              8,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: IconButton(
                                              padding: EdgeInsets.all(15),
                                              alignment: Alignment.centerLeft,
                                              icon:
                                                  const Icon(Icons.arrow_back),
                                              onPressed: () {
                                                ref
                                                    .read(
                                                        authentication.notifier)
                                                    .updateState(Loggingin());
                                              },
                                            ),
                                          ),
                                          Text(
                                            'Please enter email',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                                color: myTheme.textTheme
                                                    .headline2?.color),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 300,
                                      child: TextFormField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
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
                                                    Radius.circular(30)),
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiary),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 20, horizontal: 20),
                                          labelText: 'Email Address',
                                        ),
                                      ),
                                    ),
                                    // const SizedBox(
                                    //   height: 25,
                                    // ),
                                    // SizedBox(
                                    //   width: 300,
                                    //   child: TextFormField(
                                    //     validator: (value) {
                                    //       value == null
                                    //           ? 'Enter password'
                                    //           : value.isEmpty
                                    //               ? 'Please enter your password'
                                    //               : null;
                                    //     },
                                    //     obscureText: true,
                                    //     controller: passwordController,
                                    //     decoration: InputDecoration(
                                    //       border: OutlineInputBorder(
                                    //         borderRadius:
                                    //             const BorderRadius.all(
                                    //                 Radius.circular(30)),
                                    //         borderSide: BorderSide(
                                    //             color: Theme.of(context)
                                    //                 .colorScheme
                                    //                 .tertiary),
                                    //       ),
                                    //       contentPadding:
                                    //           const EdgeInsets.symmetric(
                                    //               vertical: 20, horizontal: 20),
                                    //       labelText: 'Create Password',
                                    //     ),
                                    //   ),
                                    // ),
                                    // const SizedBox(
                                    //   height: 25,
                                    // ),
                                    // SizedBox(
                                    //   width: 300,
                                    //   child: TextFormField(
                                    //     validator: (value) {
                                    //       value == null
                                    //           ? 'Enter password'
                                    //           : value != passwordController.text
                                    //               ? 'Incorrect password'
                                    //               : null;
                                    //     },
                                    //     obscureText: true,
                                    //     controller: passwordController,
                                    //     decoration: InputDecoration(
                                    //       border: OutlineInputBorder(
                                    //         borderRadius:
                                    //             const BorderRadius.all(
                                    //                 Radius.circular(30)),
                                    //         borderSide: BorderSide(
                                    //             color: Theme.of(context)
                                    //                 .colorScheme
                                    //                 .tertiary),
                                    //       ),
                                    //       contentPadding:
                                    //           const EdgeInsets.symmetric(
                                    //               vertical: 20, horizontal: 20),
                                    //       labelText: 'Confirm Password',
                                    //     ),
                                    //   ),
                                    // ),
                                    // //
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    FadeAnimation(
                                      1.6,
                                      Container(
                                        height: 40,
                                        width: 200,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 50),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: myTheme.buttonTheme
                                                .colorScheme?.primary),
                                        child: Center(
                                          child: GestureDetector(
                                            onTap: (() {
                                              const snackBar = SnackBar(
                                                content: Text(
                                                    'New Password has been sent'),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            }),
                                            child: Text(
                                              "Send password",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    SizedBox(
                                      height: 50,
                                    ),

                                    const SizedBox(
                                      height: 50,
                                    )
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
    );
  }
}
