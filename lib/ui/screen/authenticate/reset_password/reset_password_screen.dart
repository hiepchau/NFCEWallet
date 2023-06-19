import 'package:flutter/material.dart';
import 'package:nfc_e_wallet/ui/style/color.dart';
import 'package:nfc_e_wallet/utils/toast_helper.dart';

class ResetPasswordPage extends StatelessWidget {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reset password',
          style: TextStyle(
            color: Colors.white ),),
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
              controller: _newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'New password',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
              ),
              onChanged: (value) {

              },
            ),
            SizedBox(height: 24.0),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Confirm new password',
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
                  if (_newPasswordController.text.isNotEmpty && _confirmPasswordController.text.isNotEmpty) {
                    if (_newPasswordController.text == _confirmPasswordController.text) {
                      // TODO: Call the API to reset the password
                    } else {
                      ToastHelper.showToast('The passwords do not match', status: ToastStatus.failure);
                    }
                  } else {
                    ToastHelper.showToast('Please fill out all fields', status: ToastStatus.failure);
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
