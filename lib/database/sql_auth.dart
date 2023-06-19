import 'dart:developer';

import 'package:dbms_app/database/mysql.dart';

class SqlAuth {
  late String uid;
  late int ual = 0;

  Future<void> authenticateUser(String email, String pwd) async {
    final conn = Mysql.connection;
    String sql =
        'select uID from collegeallotment_dbmsproject.user where email = ? and pwd = ?';
    String sql2 =
        'select accessLevel from collegeallotment_dbmsproject.user where email = ? and pwd = ?';
    await conn.query(sql, [email, pwd]).then((results) {
      for (var row in results) {
        uid = row[0] as String;
      }
    }).onError((error, stackTrace) {
      print("Error: ");
      print(error);
    });
    await conn.query(sql2, [email, pwd]).then((results2) {
      for (var row in results2) {
        ual = row[0] as int;
      }
      print("intialized: $ual");
      log("ual initialized");
    });
  }

  Future<void> registerStudentUser(
      String email, String password, String name, int score, String uid) async {
    final conn = Mysql.connection;
    String sql =
        'INSERT INTO collegeallotment_dbmsproject.user VALUES (\'$uid\', \'$email\', \'$password\', 0)';
    String sql2 =
        'INSERT INTO collegeallotment_dbmsproject.student VALUES (\'$uid\', \'$name\', $score)';
    await conn.query(sql);
    await conn.query(sql2);
    log("student added");
  }

  Future<void> registerAdminUser(String email, String password, String name,
      String address, String contactEmail, String uid) async {
    final conn = Mysql.connection;
    String sql =
        'INSERT INTO collegeallotment_dbmsproject.user VALUES (\'$uid\', \'$email\', \'$password\', 1)';
    String sql2 =
        'INSERT INTO collegeallotment_dbmsproject.collegeadmin VALUES (\'$uid\', \'$name\',  \'$address\', \'$contactEmail\' )';
    await conn.query(sql);
    await conn.query(sql2);
    log("College admin added");
  }
}
