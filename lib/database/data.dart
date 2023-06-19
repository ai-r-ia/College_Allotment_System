import 'user.dart';

class Data {
  static List<Course> allCourses = [];
  static List<College> colleges = [];
  static List<Student> students = [];
  static List<Preference> studentPreferences = [];
  static List<Allotment> allAllotments = [];
  // static Map<int, String> courses = {};

  static List<String> collegesCapacityReached = [];

  static User user = User();
  static Student? student;
  static College? college;
}
