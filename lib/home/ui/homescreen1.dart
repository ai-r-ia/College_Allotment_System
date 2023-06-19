import 'dart:developer';

import 'package:dbms_app/authentication/provider/provider.dart';
import 'package:dbms_app/database/mysql.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../database/data.dart';
import '../../database/dataFetcher.dart';
import '../../theme.dart';
import '../../database/user.dart';
import '../navigation/routes.dart';

class HomeScreen1 extends ConsumerStatefulWidget {
  const HomeScreen1({Key? key}) : super(key: key);
  @override
  ConsumerState<HomeScreen1> createState() => _HomeScreen1State();
}

class _HomeScreen1State extends ConsumerState<HomeScreen1> {
  late College selectedCollege;
  late Course selectedCourse;
  bool isButtonEnabled = true;
  TextEditingController prefController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedCollege =
        Data.colleges.isNotEmpty ? Data.colleges.first : College();
    // Data.courses = [
    //   "course1",
    //   "course2"
    // ]; // sql query get only those courses that a college offers
    selectedCourse =
        Data.allCourses.isNotEmpty ? Data.allCourses.first : Course();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final state = ref.watch(authentication);
    // if (state is Authenticated) {
    //   studentUser = state.user;
    // } else {
    log('in student dashboard ');
    // }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
          alignment: Alignment.center,
          child: Column(children: [
            Row(
              children: [
                Container(
                  height: 30,
                  width: MediaQuery.of(context).size.width / 2,
                  color: myTheme.buttonTheme.colorScheme?.primary,
                  child: GestureDetector(
                    child: const Text(
                      "Apply",
                      textAlign: TextAlign.center,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, homePageStudent);
                    },
                  ),
                ),
                Container(
                  height: 30,
                  width: MediaQuery.of(context).size.width / 2,
                  color: Colors.transparent,
                  child: GestureDetector(
                    onTap: (() {
                      Navigator.pushNamed(context, profilePage);
                    }),
                    child: const Text("Profile", textAlign: TextAlign.center),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            const Text('Select Prefernce'),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              child: DropdownButton<College>(
                value: selectedCollege,
                elevation: 5,
                items: Data.colleges
                    .map<DropdownMenuItem<College>>((College value) {
                  return DropdownMenuItem<College>(
                    value: value,
                    child: Text(value.name),
                  );
                }).toList(),
                hint: const Text(
                  "Please select a college",
                ),
                onChanged: (College? value) {
                  setState(() {
                    selectedCollege = value!;
                  });
                },
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              child: DropdownButton<Course>(
                value: selectedCourse,
                elevation: 5,
                items: Data.allCourses
                    .map<DropdownMenuItem<Course>>((Course value) {
                  return DropdownMenuItem<Course>(
                    value: value,
                    child: Text(value.name),
                  );
                }).toList(),
                hint: const Text(
                  "Please select a course",
                ),
                onChanged: (Course? value) {
                  setState(() {
                    selectedCourse = value!;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              width: 175,
              height: 40,
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                },
                controller: prefController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.tertiary),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  hintText: 'Preference No.',
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              height: 30,
              width: 150,
              margin: const EdgeInsets.symmetric(horizontal: 50),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: myTheme.buttonTheme.colorScheme?.primary),
              child: Center(
                child: GestureDetector(
                  onTap: () async {
                    if (isButtonEnabled) {
                      // studentCutOff
                      //sql query to compare cutoff
                      isButtonEnabled = false;
                      await sqlPrefernces.addPreference(
                          Data.student!.uid,
                          selectedCollege.uid,
                          selectedCourse.courseID,
                          int.parse(prefController.text));
                      Data.student!.studentPreferences =
                          await getPreferences(Data.student!.uid);
                      Future.delayed(const Duration(seconds: 2), () {
                        isButtonEnabled = true;
                      });

                      print('preference set');
                    } else {
                      print('error in preference setting');
                    }
                  },
                  child: const Text(
                    "Apply to College",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
