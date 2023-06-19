import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../theme.dart';
import 'dart:ui';

import 'FadeAnimation.dart';
import '../provider/provider.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController emailController2 = TextEditingController();
  TextEditingController nameController2 = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();
  TextEditingController confirmpasswordController2 = TextEditingController();
  TextEditingController scoreController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController contactEmailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late bool isPasswordvisible1;
  late bool isPasswordvisible2;
  int userType = 0;
  String _chosenValue = 'Student';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isPasswordvisible1 = false;
    isPasswordvisible2 = false;
    // test();
  }

  void registerType() {
    setState(() {
      if (_chosenValue == 'Student') {
        userType = 0;
      } else if (_chosenValue == 'Admin') {
        userType = 1;
      }
    });
  }

  Widget studentReg() {
    checkVerification(state) {
      log('outside if dialog: $state');
      if (state is Register) {
        log('in dialog: $state');
      }
    }

    return Column(
      children: [
        SizedBox(
          width: 250,
          height: 40,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                return "Please enter a valid email address";
              }
              return null;
            },
            controller: emailController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.tertiary),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
            controller: nameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.tertiary),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              labelText: 'Name',
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
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
            obscureText: !isPasswordvisible1,
            controller: passwordController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.tertiary),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              labelText: 'Create Password',
              suffixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    setState(() {
                      isPasswordvisible1 = !isPasswordvisible1;
                    });
                  },
                  icon: Icon(
                    isPasswordvisible1
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.grey,
                  ),
                ),
              ),
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
              if (value == null) {
                return 'Enter password';
              }
              if (value != passwordController.text) {
                return 'Incorrect password';
              }
              return null;
            },
            obscureText: !isPasswordvisible2,
            controller: confirmpasswordController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.tertiary),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              labelText: 'Confirm Password',
              suffixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    setState(() {
                      isPasswordvisible2 = !isPasswordvisible2;
                    });
                  },
                  icon: Icon(
                    isPasswordvisible2
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.grey,
                  ),
                ),
              ),
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
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
            controller: scoreController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.tertiary),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              labelText: 'Test Score',
            ),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        FadeAnimation(
          1.6,
          Container(
            height: 40,
            width: 200,
            margin: const EdgeInsets.symmetric(horizontal: 50),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: myTheme.buttonTheme.colorScheme?.primary),
            child: Center(
              child: GestureDetector(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    ref.read(authentication.notifier).registerStudent(
                          emailController.text.toString().trim(),
                          nameController.text.toString().trim(),
                          passwordController.text,
                          int.parse(scoreController.text),
                        );
                    log('before dialog box');
                    Future.delayed(const Duration(seconds: 5), () {
                      var state = ref.watch(authentication);
                      log('state upon registering: $state');
                      checkVerification(state);
                      // isButtonEnabled = true;
                      log('state upon verification: $state');
                    });

                    print('Form is valid');
                  } else {
                    print('Form is invalid');
                  }
                },
                child: const Text(
                  "Sign up as student",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget adminReg() {
    checkVerification(state) {
      log('outside if dialog: $state');
      if (state is Register) {
        log('in dialog: $state');
      }
    }

    return Column(
      children: [
        SizedBox(
          width: 250,
          height: 40,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                return "Please enter a valid email address";
              }
              return null;
            },
            controller: emailController2,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.tertiary),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
            controller: nameController2,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.tertiary),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              labelText: 'Institute Name',
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
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
            obscureText: !isPasswordvisible1,
            controller: passwordController2,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.tertiary),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              labelText: 'Create Password',
              suffixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    setState(() {
                      isPasswordvisible1 = !isPasswordvisible1;
                    });
                  },
                  icon: Icon(
                    isPasswordvisible1
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.grey,
                  ),
                ),
              ),
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
              if (value == null) {
                return 'Enter password';
              }
              if (value != passwordController2.text) {
                return 'Incorrect password';
              }
              return null;
            },
            obscureText: !isPasswordvisible2,
            controller: confirmpasswordController2,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.tertiary),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              labelText: 'Confirm Password',
              suffixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    setState(() {
                      isPasswordvisible2 = !isPasswordvisible2;
                    });
                  },
                  icon: Icon(
                    isPasswordvisible2
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.grey,
                  ),
                ),
              ),
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
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
            controller: addressController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.tertiary),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              labelText: 'Address',
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
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
            controller: contactEmailController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.tertiary),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              labelText: 'Contact Email',
            ),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        FadeAnimation(
          1.6,
          Container(
            height: 40,
            width: 200,
            margin: const EdgeInsets.symmetric(horizontal: 50),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: myTheme.buttonTheme.colorScheme?.primary),
            child: Center(
              child: GestureDetector(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    ref.read(authentication.notifier).registerAdmin(
                        emailController2.text.toString().trim(),
                        nameController2.text.toString().trim(),
                        passwordController2.text,
                        addressController.text,
                        contactEmailController.text);
                    log('before dialog box');
                    Future.delayed(const Duration(seconds: 5), () {
                      var state = ref.watch(authentication);
                      log('state upon registering: $state');
                      checkVerification(state);
                      // isButtonEnabled = true;
                      log('state upon verification: $state');
                    });

                    print('Form is valid');
                  } else {
                    print('Form is invalid');
                  }
                },
                child: const Text(
                  "Sign up as admin",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    checkVerification(state) {
      log('outside if dialog: $state');
      if (state is Register) {
        log('in dialog: $state');
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
                                            .withOpacity(0.3)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              6,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Create a new account',
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.w600,
                                                color: myTheme.textTheme
                                                    .headline2?.color),
                                          ),
                                          SizedBox(height: 25),
                                          Text(
                                            'Select account type:',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: myTheme.textTheme
                                                    .headline2?.color),
                                          ),
                                        ],
                                      ),
                                    ),

                                    DropdownButton<String>(
                                      focusColor: Colors.white,
                                      value: _chosenValue,
                                      //elevation: 5,
                                      style: TextStyle(color: Colors.white),
                                      iconEnabledColor: Colors.black,
                                      items: <String>[
                                        'Student',
                                        'Admin',
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        );
                                      }).toList(),
                                      hint: Text(
                                        "Please choose a langauage",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      onChanged: (String? value) {
                                        _chosenValue = value!;
                                        registerType();
                                      },
                                    ),

                                    SizedBox(
                                      height: 50,
                                    ),
                                    if (userType == 0) studentReg(),
                                    if (userType == 1) adminReg(),

                                    const SizedBox(
                                      height: 25,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 32, horizontal: 16),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Already have an account?.",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15),
                                              ),
                                              InkWell(
                                                  child: GestureDetector(
                                                onTap: () {
                                                  ref
                                                      .read(authentication
                                                          .notifier)
                                                      .updateState(Loggingin());
                                                },
                                                child: Text("Sign in",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 15,
                                                        color: myTheme
                                                            .buttonTheme
                                                            .colorScheme
                                                            ?.primary)),
                                              ))
                                            ],
                                          ),
                                        )
                                      ],
                                    )

                                    //     ],
                                    //   ),
                                    // )
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
