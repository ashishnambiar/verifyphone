import 'package:flutter/material.dart';
import 'package:verifyphone/CustomWidgets/custom_textfield.dart';
import 'package:verifyphone/Screens/verification_page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Number Verification'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                label: 'Phone Number',
                controller: phoneController,
                isPassword: false,
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  //TODO: send verification code to phone.
                  Navigator.pushNamed(context, VerificationPage.route);
                },
                child: Text('Verify Phone Number'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
