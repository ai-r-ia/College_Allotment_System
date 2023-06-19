import 'dart:developer';

import 'package:dbms_app/database/mysql.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../authentication/provider/provider.dart';
import 'package:flutter/material.dart';
import '../../database/data.dart';
import '../../database/dataFetcher.dart';
import '../../theme.dart';
import '../navigation/routes.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  int selectedIconIndex = 2;
  TextEditingController nameController = TextEditingController();
  TextEditingController scoreController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    loadPreferences().then((value) {
      setState(() {});
    });
  }

  Future<void> loadPreferences() async {
    Data.student!.studentPreferences = await getPreferences(Data.student!.uid);
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
              hintText: Data.student!.name,
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
              hintText: Data.student!.score.toString(),
            ),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        Container(
          height: 30,
          // width: 150,
          width: MediaQuery.of(context).size.width / 0.6,
          margin: const EdgeInsets.symmetric(horizontal: 50),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: myTheme.buttonTheme.colorScheme?.primary),
          child: Center(
            child: GestureDetector(
              onTap: () async {
                if (true) {
                  await sqlStudent.updateStudentProfile(Data.student!.uid,
                      nameController.text, int.parse(scoreController.text));
                  setState(() {});
                  Future.delayed(const Duration(seconds: 1), () {});

                  print('Form is valid');
                }
                // else {
                //   print('Form is invalid');
                // }
              },
              child: const Text(
                "Update",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(authentication);
    // if (state is Authenticated) {
    //   profileUser = state.user;
    // } else {
    log('in profile -state not authenticated');
    // }
    return Scaffold(
      extendBody: true,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width / 2,
                    color: Colors.transparent,
                    child: GestureDetector(
                      child: const Text("Apply", textAlign: TextAlign.center),
                      onTap: () {
                        Navigator.pushNamed(context, homePageStudent);
                      },
                    ),
                  ),
                  Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width / 2,
                    color: myTheme.buttonTheme.colorScheme?.primary,
                    child: GestureDetector(
                      onTap: (() {
                        Navigator.pushNamed(context, profilePage);
                      }),
                      child: const Text("Profile", textAlign: TextAlign.center),
                    ),
                  )
                ],
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      myTheme.buttonTheme.colorScheme!.primary,
                      // myTheme.primaryColorDark,
                      myTheme.primaryColorLight
                    ],
                  ),
                ),
                child: Column(children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 10.0,
                      ),
                      // CircleAvatar(
                      //   radius: 23.0,
                      //   backgroundColor: Colors.white,
                      // ),
                      Column(
                        children: [
                          Text(Data.student!.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17.0,
                              )),
                          Text("Score: ${Data.student!.score}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17.0,
                              )),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                ]),
              ),
              Expanded(
                flex: 7,
                child: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Column(
                          children: [
                            const SizedBox(
                              height: 25,
                            ),
                            const Text("Colleges you have applied to: "),
                            Container(
                              padding: const EdgeInsets.all(20.0),
                              child: Table(
                                border: TableBorder.all(color: Colors.black),
                                children: [
                                  TableRow(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              style: BorderStyle.solid)),
                                      children: const [
                                        Text("College",
                                            textAlign: TextAlign.center),
                                        Text("Course",
                                            textAlign: TextAlign.center),
                                        Text("Status",
                                            textAlign: TextAlign.center),
                                        Text("Pref. No.",
                                            textAlign: TextAlign.center),
                                      ]),
                                  ...Data.studentPreferences
                                      .map(
                                        (x) => TableRow(children: [
                                          Text(x.college.name),
                                          Text(x.course.name),
                                          Text(x.status),
                                          Text(x.prefNo.toString()),
                                        ]),
                                      )
                                      .toList()
                                ],
                              ),
                            ),
                            const Text("Your details: "),
                            studentReg(),
                            //sql query to get all college names
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 30,
                          // width: 150,
                          width: MediaQuery.of(context).size.width / 0.6,
                          margin: const EdgeInsets.symmetric(horizontal: 50),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: myTheme.buttonTheme.colorScheme?.primary),
                          child: Center(
                            child: GestureDetector(
                              onTap: () async {
                                await sqlStudent
                                    .deleteStudent(Data.student!.uid);
                              },
                              child: const Text(
                                "Delete Account",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 30,
                          width: MediaQuery.of(context).size.width / 0.6,
                          margin: const EdgeInsets.symmetric(horizontal: 50),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: myTheme.buttonTheme.colorScheme?.primary),
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                state = Loggingin();
                                Data.student = null;
                              },
                              child: const Text(
                                "Logout",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
