import 'package:dbms_app/database/mysql.dart';
import 'package:dbms_app/database/user.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import './authentication/ui/ui.dart';
import './authentication/provider/provider.dart';
import './home/navigation/routes.dart';
import 'authentication/ui/reg.dart';
import 'database/data.dart';

class Wrapper extends ConsumerWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authentication);
    if (state is Loggingin) {
      return const LoginPageThree();
    }
    if (state is Register) {
      return const RegisterPage();
    }
    if (state is ForgotPassword) {
      return const ForgotPassPage();
    }
    if (Data.student != null) {
      return Navigator(
        key: homeNavigatorKey,
        onGenerateRoute: homeRoutes,
        initialRoute: homePageStudent,
      );
    }
    if (Data.college != null) {
      return Navigator(
        key: homeNavigatorKey,
        onGenerateRoute: homeRoutes,
        initialRoute: homePageAdmin,
      );
    } else {
      return const CircularProgressIndicator();
    }
  }
}
