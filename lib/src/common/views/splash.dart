import 'package:biteblitz/dashBoard.dart';
import 'package:biteblitz/src/features/auth/views/add_Bank_detail_Screen.dart';
import 'package:biteblitz/src/features/auth/views/add_fssai_Screen.dart';
import 'package:biteblitz/src/features/auth/views/add_gstIn_screen.dart';
import 'package:biteblitz/src/features/auth/views/add_pan_card_Screen.dart';
import 'package:biteblitz/src/features/auth/views/add_res_info_screen.dart';
import 'package:biteblitz/src/features/auth/views/pending_verification.dart';
import 'package:biteblitz/src/features/auth/views/verification.dart';
import 'package:biteblitz/src/res/imges.dart';
import 'package:biteblitz/src/utils/SharedPrefHelper.dart';
import 'package:biteblitz/src/utils/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/views/menu_images.dart';
import '../providers/common_providers.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _moveAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 9.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _moveAnimation = Tween<Offset>(begin: Offset(60, 0), end: Offset(73, 0)).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _startAnimation();
  }

  void _startAnimation() {
    _controller.forward().then((_) {
      Navigator.of(context).push(
        FadePageRoute(widget: BlankScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Transform.translate(
                offset: _moveAnimation.value,
                child: Image.asset(AppImages.logo),
              ),
            );
          },
        ),
      ),
    );
  }
}

class BlankScreen extends ConsumerStatefulWidget {
  @override
  _BlankScreenState createState() => _BlankScreenState();
}

class _BlankScreenState extends ConsumerState<BlankScreen> {
  @override
  void initState() {
    super.initState();

    _checkToken();
  }

  Future<void> _checkToken() async {
    final token = await SharedPrefHelper.getToken();

    // Navigate to Dashboard if token exists; otherwise, go to Login
    if (token != null && token.isNotEmpty) {
      ref.read(authTokenProvider.notifier).state = token;
      final onboardingStage = await SharedPrefHelper.getValue<int>(SharedPrefKeys.onboarding_stage);

      if (onboardingStage != null) {
        // Redirect to the next onboarding step based on the current stage
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => OnboardingScreen(stage: onboardingStage)));
      } else {
        _navigateToDashboard();
      }
    } else {
      _navigateToLogin();
    }
  }

  void _navigateToDashboard() {
    // Delay for 1 second before navigating to the LoginScreen
    Future.delayed(const Duration(seconds: 0), () {
      context.go(routeNames.dashboard);
    });
  }

  void _navigateToLogin() {
    // Delay for 1 second before navigating to the LoginScreen
    Future.delayed(const Duration(seconds: 0), () {
      context.go(routeNames.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorChanger("#ff5733"), // Set your desired background color
      body: const Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Indulge Your\nAppetite!', // Your desired text
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      )),
    );
  }
}

Color colorChanger(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  return Color(int.parse(hexColor, radix: 16));
}

class FadePageRoute extends PageRouteBuilder {
  final Widget widget;
  final double scaleFactor;

  FadePageRoute({required this.widget, this.scaleFactor = 1.0})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => widget,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return ScaleTransition(
              scale: Tween<double>(begin: 1, end: 1.0).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                ),
              ),
              child: child,
            );
          },
          transitionDuration: Duration(milliseconds: 500),
        );
}

class OnboardingScreen extends StatelessWidget {
  final int stage;

  OnboardingScreen({required this.stage});

  @override
  Widget build(BuildContext context) {
    // Show the appropriate screen based on the stage
    Widget currentScreen;
    switch (stage) {
      case 0:
        currentScreen = const verification();
        break;
      case 1:
        currentScreen = const add_res_Info_Screen();
        break;
      case 2:
        currentScreen = const add_panCard_Screen();
        break;
      case 3:
        currentScreen = const add_bankDetails_Screen();
        break;
      case 4:
        currentScreen = const add_menuImages_Screen();
        break;
      case 5:
        currentScreen = const add_fssai_Screen();
        break;
      case 6:
        currentScreen = const add_gstIN_screen();
        break;
      case 7:
        currentScreen = const pending_verification();
        break;
      default:
        currentScreen = dashboard();
    }
    return currentScreen;
  }
}
