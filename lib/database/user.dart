class User {}

// class User {
//   static late String name;
//   static late String uid;
//   static late int score;
//   static late String address;
//   static late String contactEmail;
// }

class College extends User {
  late Map<int, Course> coursesOffered;
  late List<Allotment> allotments;
  late String name;
  late String address;
  late String contactEmail;
  late String uid;
}

class Course {
  late String name;
  int cutOff = 0;
  late int courseID;
  int capacity = 0;
}

class Student extends User {
  late String name;
  late int score;
  late String uid;
  late List<Preference> studentPreferences;
}

class Preference {
  late College college;
  late Course course;
  late String studentID;
  late int prefNo;
  String status = "Not alloted";
}

class Allotment {
  late Student student;
  late Course course;
  late College college;
}
