import 'package:dbms_app/database/dataFetcher.dart';
import 'package:dbms_app/database/mysql.dart';
import 'package:dbms_app/home/ui/admin_home.dart';
import 'package:dbms_app/home/ui/allotments.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'authentication/ui/get started.dart';
import 'home/navigation/routes.dart';
import 'home/ui/homescreen1.dart';
import 'home/ui/profile_screen.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Mysql.getConnection();
  await fetchData();
  // if (Firebase.apps.isEmpty) {
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );
  // }
  // MaterialPageRoute.debugEnableFadingRoutes = true;
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DBMS',
      theme: myTheme,
      home: WillPopScope(
          onWillPop: () async {
            homeNavigatorKey.currentState?.pop();
            SystemChrome.setPreferredOrientations(
                [DeviceOrientation.portraitUp]);
            return false;
          },
          child: const GetStarted()),
      // child: AdminHome()),
      // child: Allotments()),
    );
  }
}
