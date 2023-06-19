import 'package:dbms_app/database/mysql.dart';
import 'package:dbms_app/database/user.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../database/data.dart';
import '../../theme.dart';
import '../navigation/routes.dart';

class Allotments extends ConsumerStatefulWidget {
  const Allotments({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AllotmentsState();
}

class _AllotmentsState extends ConsumerState<Allotments> {
  bool isButtonEnabled = true;
  bool mycollege = true;
  String buttonText = "View all allotments";
  List<Allotment> collegeAllotments = [];

  @override
  void initState() {
    super.initState();
    collegeAllotments = Data.college!.allotments;
    getAltmnts().then((value) {
      setState(() {});
    });
  }

  Future<void> getAltmnts() async {
    collegeAllotments =
        await sqlAllocate.getAllAllocatedToCollege(Data.college!.uid);
    Data.allAllotments = await sqlAllocate.getAllAllocated();
  }

  void update() {
    setState(() {
      mycollege = !mycollege;
      if (buttonText == "View all allotments") {
        buttonText = "View my college allotments";
      } else if (buttonText == "View my college allotments") {
        buttonText = "View all allotments";
      }
    });
  }

  Widget mycollegeAltmnt() {
    return Column(children: [
      Text("List of all students allotted to this college : "),
      Container(
        padding: EdgeInsets.all(20.0),
        child: Table(
          border: TableBorder.all(color: Colors.black),
          children: [
            TableRow(
                decoration:
                    BoxDecoration(border: Border.all(style: BorderStyle.solid)),
                children: const [
                  Text("Student", textAlign: TextAlign.center),
                  Text("College", textAlign: TextAlign.center),
                  Text("Course", textAlign: TextAlign.center)
                ]),
            ...collegeAllotments
                .map(
                  (x) => TableRow(children: [
                    Text(x.student.name),
                    Text(x.college.name),
                    Text(x.course.name),
                  ]),
                )
                .toList()
          ],
        ),
      ),
    ]);
  }

  Widget allAltmnts() {
    return Column(children: [
      Text("List of all allottments to all colleges : "),
      Container(
        padding: EdgeInsets.all(20.0),
        child: Table(
          border: TableBorder.all(color: Colors.black),
          children: [
            TableRow(
                decoration:
                    BoxDecoration(border: Border.all(style: BorderStyle.solid)),
                children: const [
                  Text("Student", textAlign: TextAlign.center),
                  Text("College", textAlign: TextAlign.center),
                  Text("Course", textAlign: TextAlign.center)
                ]),
            ...Data.allAllotments
                .map(
                  (x) => TableRow(children: [
                    Text(x.student.name),
                    Text(x.college.name),
                    Text(x.course.name),
                  ]),
                )
                .toList()
          ],
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Container(
            alignment: Alignment.center,
            child: Column(children: [
              Row(
                children: [
                  Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width / 2,
                    color: Colors.transparent,
                    child: GestureDetector(
                      child: const Text("Add courses",
                          textAlign: TextAlign.center),
                      onTap: () {
                        Navigator.pushNamed(context, homePageAdmin);
                      },
                    ),
                  ),
                  Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width / 2,
                    color: myTheme.buttonTheme.colorScheme?.primary,
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
              Container(
                height: 30,
                width: 200,
                margin: const EdgeInsets.symmetric(horizontal: 50),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: myTheme.buttonTheme.colorScheme?.primary),
                child: Center(
                  child: GestureDetector(
                    onTap: () async {
                      // if (isButtonEnabled) {
                      //   isButtonEnabled = false;
                      update();
                      // Future.delayed(const Duration(seconds: 2), () {
                      //   isButtonEnabled = true;
                      // });

                      //   print('CutOff cleared');
                      // } else {
                      //   print('CutOff not cleared');
                      // }
                    },
                    child: Text(
                      buttonText,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              if (mycollege) mycollegeAltmnt(),
              if (!mycollege) allAltmnts()
            ]),
          ),
        ),
      ),
    );
  }
}
