
import 'package:biteblitz/src/common/views/widgets/appBar.dart';
import 'package:biteblitz/src/common/views/widgets/button.dart';
import 'package:biteblitz/src/common/views/widgets/text_field_.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../res/strings.dart';

class edit_restaurant_information_screen extends StatelessWidget {
  const edit_restaurant_information_screen({super.key});


  @override
  Widget build(BuildContext context) {


    // Create a TextEditingController with default text
    TextEditingController _email_controller = TextEditingController(text: restaurant_Email);
    TextEditingController _name_controller = TextEditingController(text: restaurant_Owner_Name);
    TextEditingController _phone_controller = TextEditingController(text: restaurant_Mobile);
    TextEditingController _address_controller = TextEditingController(text: restaurant_address);


    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const appbar(
          title: 'Edit Restaurant\'s Information',
        ),


      ),
      body: Padding(
        padding: EdgeInsets.all(screenHeight * 0.02),
        child: Column(
          children: [


            Container(
              padding: EdgeInsets.all(screenHeight * 0.02),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    spreadRadius: 0,
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Column(
                children: [
                  textField_second(
                    title: "Email Address",
                    hint: 'Enter your email',
                    controller: _email_controller,
                    icon: Icons.check_circle_outline_rounded,
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  textField_second(
                    title: "Owner/Manager Name",
                    hint: 'Enter Owner/Manager Name',
                    controller: _name_controller,
                    icon: Icons.check_circle_outline_rounded,
                  ),
                  SizedBox(height: screenHeight * 0.01),

                  textField_second(
                    title: "Phone",
                    hint: 'Enter Phone',
                    controller: _phone_controller,
                    icon: Icons.contact_phone_outlined,

                  ),
                  SizedBox(height: screenHeight * 0.01),

                  textField_second(
                    title: "Address",
                    hint: 'Enter Address',
                    controller: _address_controller,
                    icon: Icons.contact_phone_outlined,
                  ),

                ],
              ),
            ),



            Spacer(),
            button_Primary(onPressed: () {
              context.pop();

            }, title: 'Save Changes',)

          ],
        ),
      ),
    );
  }


}
