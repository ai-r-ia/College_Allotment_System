import 'dart:developer';

import 'data.dart';
import 'mysql.dart';
import 'user.dart';

class SqlStudent {
  // to fetch student data for given uID
  Future<Student> getStudentData(String uID) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    final conn = Mysql.connection;
    String sql =
        'select * from collegeallotment_dbmsproject.student where uID = ?';
    var student = Student();
    await conn.query(sql, [uID]).then((results) {
      for (var row in results) {
        student.name = row[1].toString();
        student.score = row[2] as int;
        student.uid = uID;
      }
    });
    log("student data fetched");
    return student;
  }

  //to fetch all enrtries from table student
  Future<void> getAllStudentData() async {
    await Future.delayed(const Duration(milliseconds: 100));
    final conn = Mysql.connection;
    Data.students = [];
    String sql = 'select * from collegeallotment_dbmsproject.student';
    await conn.query(sql).then((results) {
      for (var row in results) {
        var studentForList = Student();
        studentForList.uid = row[0].toString();
        studentForList.name = row[1].toString();
        studentForList.score = row[2] as int;
        Data.students.add(studentForList);
      }
    });
    log("all students fetched");
  }

  //to update row entry for a given uID in table student
  Future<void> updateStudentProfile(
      String studentID, String name, int score) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final conn = Mysql.connection;
    String sql =
        'update collegeallotment_dbmsproject.student set sname=?, marks = ? where uID = ? ';
    await conn.query(sql, [name, score, studentID]);
    log("student data updated");
    for (var x in Data.students) {
      if (x.uid == studentID) {
        x.name = name;
        x.score = score;
      }
    }
    Data.student!.name = name;
    Data.student!.score = score;
  }

  //to delete the entry corresponding to a student uID in table student
  Future<void> deleteStudent(String studentID) async {
    final conn = Mysql.connection;
    String sql =
        'delete from collegeallotment_dbmsproject.student where uID = ? ';
    await conn.query(sql, [studentID]);
    log("student with id: $studentID deleted");
    // Data.students
  }

  //to delete all student entries in table student
  Future<void> deleteAllStudents() async {
    final conn = Mysql.connection;
    String sql = 'truncate table collegeallotment_dbmsproject.student ';
    await conn.query(sql);
    log("all student data deleted");
    Data.students = [];
  }

  //getStudentData in auth can be moved here
}

class SqlCourses {
  //to add a course to table courses in database
  Future<void> addCourseInDb(int courseID, String name) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final conn = Mysql.connection;
    String sql =
        'INSERT INTO collegeallotment_dbmsproject.courses VALUES (?,?)';
    await conn.query(sql, [courseID, name]);
    log("course added to table");
    var courseToAdd = Course();
    courseToAdd.courseID = courseID;
    courseToAdd.name = name;
    Data.allCourses.add(courseToAdd);
  }

  // to fetch all enrtries from table courses
  Future<void> getAllCourses() async {
    await Future.delayed(const Duration(milliseconds: 100), () async {
      final conn = Mysql.connection;
      Data.allCourses = [];
      String sql = 'select * from collegeallotment_dbmsproject.courses ';
      await conn.query(sql).then((results) {
        for (var row in results) {
          var courseForList = Course();
          courseForList.courseID = row[0] as int;
          courseForList.name = row[1].toString();
          Data.allCourses.add(courseForList);
        }
      });
      log("all course ids fetched");
    });
  }

  //to delete all entries in the table courses
  Future<void> deleteAllCourses() async {
    await Future.delayed(const Duration(milliseconds: 100));
    final conn = Mysql.connection;
    String sql = 'truncate table collegeallotment_dbmsproject.courses ';
    await conn.query(sql);
    log("all courses deleted");
    Data.allCourses = [];
  }
}

class SqlCollege {
  Future<College> getAdminData(String uID) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    final conn = Mysql.connection;
    String sql =
        'select * from collegeallotment_dbmsproject.collegeadmin where uID = ?';
    var collegeAdmin = College();
    await conn.query(sql, [uID]).then((results) {
      for (var row in results) {
        collegeAdmin.name = row[1].toString();
        collegeAdmin.address = row[2].toString();
        collegeAdmin.contactEmail = row[3].toString();
        // collegeAdmin.uid = uID;
      }
    });
    log("admin data fetched");
    return collegeAdmin;
  }

  //get all college admin data from table collegeadmin
  Future<List<College>> getAllCollegeData() async {
    await Future.delayed(const Duration(milliseconds: 100));
    final conn = Mysql.connection;
    List<College> colleges = [];
    String sql = 'select * from collegeadmin';
    await conn.query(sql).then((results) async {
      for (var row in results) {
        var collegeAdmin = College();
        collegeAdmin.uid = row[0].toString();
        collegeAdmin.name = row[1].toString();
        collegeAdmin.address = row[2].toString();
        collegeAdmin.contactEmail = row[3].toString();
        collegeAdmin.allotments =
            await sqlAllocate.getAllAllocatedToCollege(collegeAdmin.uid);

        collegeAdmin.coursesOffered =
            await sqlCollege.getCoursesOfferedbyCollege(collegeAdmin.uid);
        colleges.add(collegeAdmin);
      }
      log("all colleges fetched");
    });
    return colleges;
  }

  //adds a course to the courses offered by a college by inserting row in table courses_offered
  Future<void> addCourseToCollege(String collegeID, int courseID, int capacity,
      int cutOff, String name) async {
    final conn = Mysql.connection;
    String sql =
        'INSERT INTO collegeallotment_dbmsproject.courses_offered VALUES (?,?,?,?)';
    await conn.query(sql, [collegeID, courseID, capacity, cutOff]);
    log("course added for collegeID: $collegeID");
    var course = Course();
    course.name = name;
    course.courseID = courseID;
    course.capacity = capacity;
    course.cutOff = cutOff;
    Data.college!.coursesOffered[courseID] = (course);
  }

  //to get courseIDs of all courses offered by a college and insert into global list offeredCourseIDs
  Future<Map<int, Course>> getCoursesOfferedbyCollege(String collegeId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final conn = Mysql.connection;
    Map<int, Course> coursesOffered = {};
    String sql =
        'select * from collegeallotment_dbmsproject.courses natural join collegeallotment_dbmsproject.courses_offered where collegeadmin_uID = ?';
    await conn.query(sql, [collegeId]).then((results) {
      for (var row in results) {
        var course = Course();
        course.courseID = row[0] as int;
        course.name = row[1].toString();
        course.capacity = row[3] as int;
        course.cutOff = row[4] as int;
        coursesOffered[course.courseID] = course;
      }
    });
    log("courses offered by collegeID: $collegeId fetched");
    return coursesOffered;
  }

  //to update selection criteria(cutOff score) of a given course offered by a given college
  Future<void> updateCourseCutoff(
      String collegeID, int courseID, int cutOff) async {
    final conn = Mysql.connection;
    String sql =
        'update collegeallotment_dbmsproject.courses_offered set cutOff=? where collegeadmin_uID = ? and courseID = ?';
    await conn.query(sql, [cutOff, collegeID, courseID]);
    log("cutOff updated");
  }

  //to get list of all colleges whose capacity has been reached
  Future<void> getAllCollegesCapacityReached() async {
    final conn = Mysql.connection;
    String sql =
        'select distinct collegeadmin_uId from collegeallotment_dbmsproject.courses_offered where courseCapacity = ?';
    await conn.query(sql, [0]).then((results) {
      for (var row in results) {
        Data.collegesCapacityReached.add(row[0].toString());
      }
    });
    log("colleges with capaciy reached fetched");
  }

  //to retrieve count of number of seats/capacity remainig in a college
  Future<int> getCollegeCapacity(String collegeID) async {
    late int remainingSeats;
    final conn = Mysql.connection;
    String sql =
        'select sum(cutOff) from collegeadmin_uId from collegeallotment_dbmsproject.courses_offered where collegeadmin_uID = ?';
    await conn.query(sql, [collegeID]).then((results) {
      for (var row in results) {
        remainingSeats = {row[0]} as int;
      }
    });
    log("college capaciy found");

    return remainingSeats;
  }
}

class SqlAllocation {
  //allocate college to student based on score, cutoff and prefernce, reduce course capacity
  Future<void> allocateCollegeToStudent(int courseid, String collegeID) async {
    final conn = Mysql.connection;
    String sql =
        'set @capacity = (select coursecapacity from courses_offered where collegeadmin_uid = ? and courseid= ?)';
    await conn.query(sql, [collegeID, courseid]);
    log("capacity variable set");
    String sql2 = 'call get_altmnt(? , ?, @capacity)';
    await conn.query(sql2, [courseid, collegeID]);
    log("allotments done");
  }

  //to fetch all alotments to a given college from table allocated
  Future<List<Allotment>> getAllAllocated() async {
    List<Allotment> allotments = [];
    final conn = Mysql.connection;
    String sql =
        'select distinct * from collegeallotment_dbmsproject.allocated inner join student on allocated.student_uID = uID inner join collegeadmin on collegeadmin.uID = allocated.collegeadmin_uID inner join courses on allocated.courseID = courses.courseID';

    await conn.query(sql).then((results) {
      for (var row in results) {
        var allotmentToAdd = Allotment();
        var student = Student();
        var college = College();
        var course = Course();
        student.uid = row[0].toString();
        student.name = row[4].toString();
        student.score = row[5] as int;
        college.uid = row[2].toString();
        college.name = row[7].toString();
        college.address = row[8].toString();
        college.contactEmail = row[9].toString();
        course.name = row[11].toString();
        course.courseID = row[1] as int;
        allotmentToAdd.college = college;
        allotmentToAdd.student = student;
        allotmentToAdd.course = course;
        allotments.add(allotmentToAdd);
      }
    });
    log("all students allocated fetched");
    return allotments;
  }

  //to fetch all alotments to a given college from table allocated
  Future<List<Allotment>> getAllAllocatedToCollege(String collegeId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    List<Allotment> allotments = [];
    final conn = Mysql.connection;
    String sql =
        'select distinct * from collegeallotment_dbmsproject.allocated inner join student on allocated.student_uID = uID inner join collegeadmin on collegeadmin.uID = allocated.collegeadmin_uID inner join courses on allocated.courseID = courses.courseID where allocated.collegeadmin_uID = ?';
    await conn.query(sql, [collegeId]).then((results) {
      for (var row in results) {
        var allotmentToAdd = Allotment();
        var student = Student();
        var college = College();
        var course = Course();
        student.uid = row[0].toString();
        student.name = row[4].toString();
        student.score = row[5] as int;
        college.uid = row[2].toString();
        college.name = row[7].toString();
        college.address = row[8].toString();
        college.contactEmail = row[9].toString();
        course.name = row[11].toString();
        course.courseID = row[1] as int;
        allotmentToAdd.college = college;
        allotmentToAdd.student = student;
        allotmentToAdd.course = course;
        allotments.add(allotmentToAdd);
      }
    });
    log("students allocated to college fetched");

    return allotments;
  }

  //to fetch all studentIds allocated to a given college and given course
  Future<List<String>> getStudentsAllocatedToCollegeAndCourse(
      String collegeId, String courseID) async {
    late List<String> students = [];
    final conn = Mysql.connection;
    String sql =
        'select student_uID from collegeallotment_dbmsproject.allocated where collegeadmin_uID = ? and courseID = ?';
    await conn.query(sql, [collegeId, courseID]).then((results) {
      int i = 0;
      for (var row in results) {
        students[i] = {row[0]}.toString();
        i++;
      }
    });
    log("students allocated to college fetched");
    return students;
  }
}

class SqlPreferences {
  // to fetch all prefernces from the table student_prefernces
  Future<void> getAllPreferences(String studentID) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final conn = Mysql.connection;
    Data.studentPreferences = [];
    String sql =
        'select distinct * from student_preferences inner join courses on student_preferences.courseID = courses.courseID inner join  collegeadmin on student_preferences.collegeadmin_uID = collegeadmin.uID where student_uID = ? order by preferenceno asc, collegeadmin_uID asc, student_preferences.courseID asc';

    await conn.query(sql, [studentID]).then((results) {
      for (var row in results) {
        var preference = Preference();
        var college = College();
        var course = Course();
        preference.studentID = row[0].toString();
        course.name = row[5].toString();
        course.courseID = row[1] as int;
        college.uid = row[2].toString();
        college.name = row[7].toString();
        college.address = row[8].toString();
        college.contactEmail = row[9].toString();
        preference.course = course;
        preference.college = college;
        preference.prefNo = row[3] as int;
        Data.studentPreferences.add(preference);
      }
    });

    log("all preferences retrieved for studentID: $studentID");
  }

  // to add a prefernce for a student in the table student_prefernces
  Future<void> addPreference(
      String studentID, String collegeID, int courseID, int prefno) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final conn = Mysql.connection;
    String sql =
        'INSERT INTO collegeallotment_dbmsproject.student_preferences VALUES (?,?,?,?)';
    await conn.query(sql, [studentID, collegeID, courseID, prefno]);
    log("prefernce added for studentID: $studentID");
  }

  //update prefernce number for a given student's prefernce in the table student_prefernces
  Future<void> updatePreference(
      String studentID, String collegeID, int courseID, int prefno) async {
    final conn = Mysql.connection;
    String sql =
        'update collegeallotment_dbmsproject.student_preferences set preferenceNo = ? where student_uID = ? and collegeadmin_uID = ? and courseID = ?)';
    await conn.query(sql, [prefno, studentID, collegeID, courseID]);
    log("prefernce updated for studentID: $studentID");
  }
}
