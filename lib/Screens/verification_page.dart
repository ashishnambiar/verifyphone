import 'package:flutter/material.dart';
import 'package:verifyphone/CustomWidgets/custom_textfield.dart';
import 'package:verifyphone/Screens/user_location_page.dart';

class VerificationPage extends StatelessWidget {
  static const String route = '/verification_page';
  VerificationPage({Key? key}) : super(key: key);

  final TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Verification Code'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                label: 'Verification Code',
                controller: codeController,
                isPassword: false,
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  //TODO: verifyCode sent to user
                  Navigator.pushNamed(context, UserLocationPage.route);
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
