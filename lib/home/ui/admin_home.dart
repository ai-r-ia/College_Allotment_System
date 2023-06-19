import 'dart:developer';

import 'package:dbms_app/database/dataFetcher.dart';
import 'package:dbms_app/database/mysql.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../authentication/provider/provider.dart';
import '../../database/data.dart';
import '../../theme.dart';
import '../../database/user.dart';
import '../navigation/routes.dart';

class AdminHome extends ConsumerStatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AdminHomeState();
}

class _AdminHomeState extends ConsumerState<AdminHome> {
  TextEditingController scoreController = TextEditingController();
  TextEditingController capacityController = TextEditingController();
  late College selectedCollege;
  late Course selectedCourse;
  List<Course> offeredCourses = [];
  bool isButtonEnabled = true;

  @override
  void initState() {
    super.initState();

    selectedCollege = Data.college!;
    // Data.colleges.isNotEmpty ? Data.colleges.first : College();
    selectedCourse =
        Data.allCourses.isNotEmpty ? Data.allCourses.first : Course();
    getCoursesOffered();
  }

  void getCoursesOffered() {
    // for (var x in Data.colleges) {
    //   if (x.uid == Data.college!.uid) {
    //     selectedCollege = x;
    //   }
    // }
    print("coursesOffered:");
    print(selectedCollege.coursesOffered);

    selectedCollege.coursesOffered.isEmpty
        ? offeredCourses = []
        : offeredCourses = selectedCollege.coursesOffered.values.toList();
  }
  // Future<void> getCoursesOffered() async {
  //   Data.offeredCourseIDs = [];
  //   await sqlCollege.getCoursesOfferedbyCollege(User.uid);
  //   sqlCollege.
  //   for (int id in Data.offeredCourseIDs) {
  //     offeredCourses.values .add(await sqlCourses.getCourseNamefromID(id));
  //     print(offeredNames[0]);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final state = ref.watch(authentication);
    // if (state is Authenticated) {
    //   // adminUser = state.user;
    // } else {
    log('in college admin dashboard');
    // }
    // if (Data.allCourses.isEmpty || offeredCourses.isEmpty) {
    //   return const CircularProgressIndicator();
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
                    child:
                        const Text("Add courses", textAlign: TextAlign.center),
                    onTap: () {
                      Navigator.pushNamed(context, homePageAdmin);
                    },
                  ),
                ),
                Container(
                  height: 30,
                  width: MediaQuery.of(context).size.width / 2,
                  color: Colors.transparent,
                  child: GestureDetector(
                    onTap: (() {
                      Navigator.pushNamed(context, allotmentsPage);
                    }),
                    child:
                        const Text("Allotments", textAlign: TextAlign.center),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            const Text('Select a course and enter cut-off score'),
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
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.tertiary),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  hintText: 'Cut-Off (Minimum score)',
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
                controller: capacityController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.tertiary),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  hintText: 'Number of Seats',
                ),
              ),
            ),
            const SizedBox(height: 25),
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
                      // courseCutOff = scoreController as int;
                      //sql query to add course/insert into table
                      await sqlCollege.addCourseToCollege(
                          Data.college!.uid,
                          selectedCourse.courseID,
                          int.parse(capacityController.text),
                          int.parse(scoreController.text),
                          selectedCourse.name);
                      selectedCourse.capacity =
                          int.parse(capacityController.text);
                      selectedCourse.cutOff = int.parse(scoreController.text);
                      offeredCourses.add(selectedCourse);
                      setState(() {});
                      isButtonEnabled = false;

                      Future.delayed(const Duration(seconds: 2), () {
                        isButtonEnabled = true;
                      });

                      print('course added');
                    } else {
                      print('course not added');
                    }
                  },
                  child: const Text(
                    "Add Course",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const Text("Courses offered by the institute: "),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Table(
                border: TableBorder.all(color: Colors.black),
                children: [
                  TableRow(
                      decoration: BoxDecoration(
                          border: Border.all(style: BorderStyle.solid)),
                      children: const [
                        Text("Courses", textAlign: TextAlign.center),
                        Text("Cut-off Score", textAlign: TextAlign.center),
                      ]),
                  ...offeredCourses
                      .map(
                        (x) => TableRow(children: [
                          Text(x.name),
                          Text(x.cutOff.toString()),
                        ]),
                      )
                      .toList()
                ],
              ),
            ),
            SizedBox(
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
                      for (var x in Data.college!.coursesOffered.values) {
                        sqlAllocate.allocateCollegeToStudent(
                            x.courseID, Data.college!.uid);
                      }
                      await getAllAllotments();
                      setState(() {});
                      isButtonEnabled = false;

                      Future.delayed(const Duration(seconds: 2), () {
                        isButtonEnabled = true;
                      });

                      print('student allotment done');
                    } else {
                      print('allotment error');
                    }
                  },
                  child: const Text(
                    "Allocate Students",
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

void allocate() {
  for (var x in Data.college!.coursesOffered.values) {
    sqlAllocate.allocateCollegeToStudent(x.courseID, Data.college!.uid);
  }
  // ...Data.college!.coursesOffered.values.map(
  //                       (x) => sqlAllocate.allocateCollegeToStudent(x.courseID, Data.college!.uid,  )
  //                     )
  //                     .toList()
}
