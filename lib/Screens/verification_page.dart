import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verifyphone/CustomWidgets/custom_textfield.dart';
import 'package:verifyphone/Providers/verification_code_provider.dart';
import 'package:verifyphone/Screens/user_location_page.dart';

class VerificationPage extends StatelessWidget {
  static const String route = '/verification_page';
  VerificationPage({Key? key}) : super(key: key);

  final TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final codeProvider =
        Provider.of<VerificationCodeProvider>(context, listen: false);
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
              CustomTextFormField(
                digitsOnly: true,
                maxLength: 6,
                label: 'Verification Code',
                controller: codeController,
                isPassword: false,
              ),
              const SizedBox(height: 25),
              Consumer<VerificationCodeProvider>(
                  builder: (context, provider, child) {
                return provider.loading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () {
                          codeProvider
                              .signInWithVerificationCode(codeController.text);
                        },
                        child: Text('Submit'),
                      );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
