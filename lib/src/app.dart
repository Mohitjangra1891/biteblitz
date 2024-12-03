
import 'package:biteblitz/src/utils/router.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);

    final textTheme = Theme.of(context).textTheme;
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        scaffoldBackgroundColor: Colors.grey.shade100,
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white
        ),

        switchTheme: SwitchThemeData(
        ),
        // scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.openSansTextTheme(textTheme).copyWith(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
