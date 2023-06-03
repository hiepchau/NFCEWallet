import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Color(0xFF3F63F6),
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    // Replace this with your logo
                    child: Icon(Icons.wallet),
                  ),
                  SizedBox(height: 32),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome Back!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigate to create account screen
                        },
                        child: Text(
                          'Don’t have an account? Create Account',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter your email address',
                    contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        // Toggle password visibility
                      },
                      icon: Icon(Icons.visibility),
                    ),
                  ),
                ),
                SizedBox(height: 208),
                GestureDetector(
                  onTap: () {
                    // Forgot password action
                  },
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(
                      color: Color(0xFF3F63F6),
                    ),
                  ),
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    // Sign in action
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: Size(327, 52),
                  ),
                  child: Text('Sign in'),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to phone login screen
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Color(0xFF3F63F6)),
                    ),
                    minimumSize: Size(327, 52),
                  ),
                  child: Text(
                    'Sign in with Phone Number',
                    style: TextStyle(
                      color: Color(0xFF3F63F6),
                    ),
                  ),
                ),
                SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
