import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verifyphone/CustomWidgets/custom_textfield.dart';
import 'package:verifyphone/Providers/verification_code_provider.dart';
import 'package:verifyphone/Screens/user_location_page.dart';
import 'package:verifyphone/Screens/verification_page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final TextEditingController phoneController =
      TextEditingController();

  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final codeProvider =
        Provider.of<VerificationCodeProvider>(context, listen: false)
          ..init(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Number Verification'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Form(
            key: _form,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextFormField(
                  digitsOnly: true,
                  validator: (value) {
                    if (value == null || value == '') {
                      return 'Enter a Phone Number';
                    }
                    if (value.length < 9) {
                      return 'Enter a valid Phone Number';
                    }
                    return null;
                  },
                  label: 'Phone Number',
                  controller: phoneController,
                  isPassword: false,
                ),
                const SizedBox(height: 25),
                Consumer<VerificationCodeProvider>(
                    builder: (context, provider, child) {
                  return provider.loading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            if (_form.currentState!.validate()) {
                              codeProvider.verifyNumber(
                                phoneNumber: phoneController.text,
                                afterCodeSent: () async {
                                  log('after code sent');
                                  Navigator.pushNamed(
                                      context, VerificationPage.route);
                                },
                              );
                            }
                          },
                          child: Text('Verify Phone Number'),
                        );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
