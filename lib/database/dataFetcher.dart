import 'dart:developer';

import 'data.dart';
import 'mysql.dart';
import 'user.dart';

Future<void> fetchUser(String email, String password) async {
  await db_auth.authenticateUser(email, password);
  await Future.delayed(const Duration(milliseconds: 1000));

  if (db_auth.ual == 0) {
    Student student = Student();
    student.uid = db_auth.uid;
    student = await sqlStudent.getStudentData(student.uid);
    student.studentPreferences = await getPreferences(student.uid);
    Data.student = student;
  } else {
    College college = College();
    college.uid = db_auth.uid;
    college = await sqlCollege.getAdminData(college.uid);
    college.uid = db_auth.uid;
    college.coursesOffered = await getOfferedCourses(college.uid);
    college.allotments = await getAllotmentsToCollege(college.uid);
    Data.college = college;
  }
}

Future<void> fetchData() async {
  Data.allAllotments = await getAllAllotments();
  Data.colleges = await sqlCollege.getAllCollegeData();
  // Future.delayed(const Duration(milliseconds: 100));
  Data.allCourses = await getAllCourses();
  print("end of fetching");
}

Future<List<Course>> getAllCourses() async {
  await sqlCourses.getAllCourses();
  return Data.allCourses;
}

Future<List<Preference>> getPreferences(String studentID) async {
  await Future.delayed(const Duration(milliseconds: 1000));
  await sqlPrefernces.getAllPreferences(studentID);
  return Data.studentPreferences;
}

Future<Map<int, Course>> getOfferedCourses(String collegeID) async {
  await Future.delayed(const Duration(milliseconds: 1000));
  Map<int, Course> coursesOffered =
      await sqlCollege.getCoursesOfferedbyCollege(collegeID);
  return coursesOffered;
}

Future<List<Allotment>> getAllotmentsToCollege(String collegeID) async {
  await Future.delayed(const Duration(milliseconds: 1000));
  List<Allotment> allotments =
      await sqlAllocate.getAllAllocatedToCollege(collegeID);
  return allotments;
}

Future<List<Allotment>> getAllAllotments() async {
  List<Allotment> allotments = await sqlAllocate.getAllAllocated();
  return allotments;
}
