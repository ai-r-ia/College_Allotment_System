import 'dart:developer';
import 'package:dbms_app/database/dataFetcher.dart';
import 'package:dbms_app/database/mysql.dart';
import 'package:dbms_app/database/sql_data.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../database/data.dart';
import '../../database/user.dart';
import 'state.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

final authentication = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(Loggingin());
  bool isbusy = false;

  Future<void> login(String email, String password) async {
    try {
      await fetchUser(email, password);
      state = Authenticated();
    } catch (e) {
      print(e);
      state = Error(e.toString());
    }
  }

  void registerStudent(
      String email, String name, String password, int score) async {
    try {
      var uuid = const Uuid();
      var v4 = uuid.v4();
      await db_auth.registerStudentUser(email, password, name, score, v4);
      await fetchUser(email, password);
      state = Authenticated();
    } catch (e) {
      print(e);
      state = Error(e.toString());
    }
  }

  void registerAdmin(String email, String name, String password, String address,
      String contactEmail) async {
    try {
      var uuid = const Uuid();
      var v4 = uuid.v4();
      await db_auth.registerAdminUser(
          email, password, name, address, contactEmail, v4);
      await fetchUser(email, password);
      state = Authenticated();
    } catch (e) {
      print(e);
      state = Error(e.toString());
    }
  }

  void updateState(AuthState state) {
    this.state = state;
  }

  void logout() {
    try {} catch (e) {
      state = Error('$e');
    }
  }
}
