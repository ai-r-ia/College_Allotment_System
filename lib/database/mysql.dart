import 'package:dbms_app/database/sql_auth.dart';
import 'package:mysql1/mysql1.dart';

import 'sql_data.dart';

class Mysql {
  static String host = 'localhost',
      user = 'root',
      password = 'password',
      db = 'collegeallotment_dbmsproject';
  static int port = 3306;
  static late MySqlConnection connection;

  static Future<void> getConnection() async {
    var settings = ConnectionSettings(
        host: host, port: port, user: user, password: password, db: db);
    connection = await MySqlConnection.connect(settings);
  }
}

var db_auth = SqlAuth();
var sqlStudent = SqlStudent();
var sqlCollege = SqlCollege();
var sqlCourses = SqlCourses();
var sqlAllocate = SqlAllocation();
var sqlPrefernces = SqlPreferences();
