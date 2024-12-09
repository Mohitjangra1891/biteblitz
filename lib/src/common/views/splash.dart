import 'package:biteblitz/dashBoard.dart';
import 'package:biteblitz/src/features/auth/views/login_screen.dart';
import 'package:biteblitz/src/res/imges.dart';
import 'package:biteblitz/src/utils/SharedPrefHelper.dart';
import 'package:biteblitz/src/utils/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      _navigateToDashboard();
    } else {
      _navigateToLogin();
    }
  }

  void _navigateToDashboard() {
    // Delay for 1 second before navigating to the LoginScreen
    Future.delayed(Duration(seconds: 2), () {
      context.go(routeNames.dashboard);
    });
  }

  void _navigateToLogin() {
    // Delay for 1 second before navigating to the LoginScreen
    Future.delayed(Duration(seconds: 2), () {
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
