import 'package:biteblitz/src/common/views/widgets/appBar.dart';
import 'package:biteblitz/src/features/account/views/widgets/account%20list%20item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../res/colors.dart';
import '../../../../utils/router.dart';

class settings_screen extends StatefulWidget {
  const settings_screen({super.key});

  @override
  State<settings_screen> createState() => _settings_screenState();
}

class _settings_screenState extends State<settings_screen> {
  bool _pushNotifications = false;
  bool _soundNotifications = false;
  bool _vibrationNotifications = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const appbar(
          title: 'Settings',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenHeight * 0.02),
        child: Column(
          children: [
            Container(
              width: screenWidth,
              // margin: EdgeInsets.symmetric(vertical: screenHeight*0.01),
              padding: EdgeInsets.all(screenHeight * 0.02),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 0,
                    blurRadius: 3,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Notification Settings',
                    style: TextStyle(fontSize: 14, color: AppColors.primary_orange_color, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),

                  // First Switch with Title
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    tileColor: Colors.yellow,
                    title: const Text(
                      "Enable Push Notifications",
                      style: TextStyle(fontSize: 13, color: AppColors.dark_text_color, fontWeight: FontWeight.w600),
                    ),

                    value: _pushNotifications,
                    onChanged: (bool value) {
                      setState(() {
                        _pushNotifications = value;
                      });
                    },

                    activeColor: Colors.white70,
                    // Thumb color when active
                    activeTrackColor: Colors.redAccent.shade100,
                    // Track color when active
                    inactiveThumbColor: Colors.white70,
                    // Thumb color when inactive
                    inactiveTrackColor: Colors.redAccent.shade100, // Track color when inactive
                  ),
                  // Second Switch with Title
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text(
                      "Sound Notifications",
                      style: TextStyle(fontSize: 13, color: AppColors.dark_text_color, fontWeight: FontWeight.w600),
                    ),
                    value: _soundNotifications,
                    onChanged: (bool value) {
                      setState(() {
                        _soundNotifications = value;
                      });
                    },
                    activeColor: Colors.white70,
                    // Thumb color when active
                    activeTrackColor: Colors.redAccent.shade100,
                    // Track color when active
                    inactiveThumbColor: Colors.white70,
                    // Thumb color when inactive
                    inactiveTrackColor: Colors.redAccent.shade100, // Track color when inactive
                  ),
                  // Third Switch with Title
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      "Vibration Notifications",
                      style: TextStyle(fontSize: 13, color: AppColors.dark_text_color, fontWeight: FontWeight.w600),
                    ),
                    value: _vibrationNotifications,
                    onChanged: (bool value) {
                      setState(() {
                        _vibrationNotifications = value;
                      });
                    },
                    activeColor: Colors.white70,
                    // Thumb color when active
                    activeTrackColor: Colors.redAccent.shade100,
                    // Track color when active
                    inactiveThumbColor: Colors.white70,
                    // Thumb color when inactive
                    inactiveTrackColor: Colors.redAccent.shade100, // Track color when inactive
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            account_list_item(
              onPressed: () {
                context.pushNamed(routeNames.changePassword );

                // Navigator.push(context, MaterialPageRoute(builder: (context) => change_passwod_screen()));
              },
              title: 'Change Password',
              icon: Icons.password_rounded,
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            account_list_item(
              onPressed: () {
                context.pushNamed(routeNames.deleteAccount );

                // Navigator.push(context, MaterialPageRoute(builder: (context) => delete_account_screen()));
              },
              title: 'Delete Account',
              icon: Icons.delete_sweep_outlined,
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            account_list_item(
              onPressed: () {
                context.pushNamed(routeNames.termOfService );

                // Navigator.push(context, MaterialPageRoute(builder: (context) => term_of_service()));
              },
              title: 'Term of Service',
              icon: Icons.feed_outlined,
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            account_list_item(
              onPressed: () {
                context.pushNamed(routeNames.privacyPolicy );

                // Navigator.push(context, MaterialPageRoute(builder: (context) => privacy_policy()));
              },
              title: 'Privacy Policy',
              icon: Icons.lock_outline_rounded,
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
          ],
        ),
      ),
    );
  }
}
