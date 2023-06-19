import 'package:flutter/material.dart';
import 'package:nfc_e_wallet/ui/style/color.dart';
import 'package:nfc_e_wallet/utils/toast_helper.dart';

import '../reset_password/reset_password_screen.dart';

class ForgotPasswordPage extends StatelessWidget {
  final _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Forgot password',
          style: TextStyle(color: Colors.white),),
        backgroundColor: primary,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(
                hintText: 'Your phone number',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
              ),
              onChanged: (value) {

              },
            ),
            SizedBox(height: 24.0),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_phoneNumberController.text.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ResetPasswordPage()),
                    );
                  } else {
                    ToastHelper.showToast('Please enter your phone number', status: ToastStatus.failure);
                  }
                },
                child: Text('Submit'),
                style: ElevatedButton.styleFrom(
                  primary: green1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
