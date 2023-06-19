import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../wrapper.dart';

import '../../home/navigation/routes.dart';
import '../../theme.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bg3.jpg"), fit: BoxFit.cover),
        ),
        // color: myTheme.primaryColor.withOpacity(0.5),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/get_started.png'),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WillPopScope(
                            onWillPop: () async {
                              homeNavigatorKey.currentState?.pop();
                              SystemChrome.setPreferredOrientations(
                                  [DeviceOrientation.portraitUp]);
                              return false;
                            },
                            child: const Wrapper())));
              },
              child: Container(
                height: 50,
                width: size.width * 0.7,
                decoration: BoxDecoration(
                  color: myTheme.buttonTheme.colorScheme?.primary,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: const Center(
                  child: Text(
                    'Get Started',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
          ],
        )),
      ),
    );
  }
}
