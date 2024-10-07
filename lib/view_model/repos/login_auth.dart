// Method to handle login
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:jyothi_labs/view/screens/porduct_screen.dart';

Future<void> loginUser(
  BuildContext context,
  TextEditingController emailController,
  TextEditingController passwordController,
) async {
  String email = emailController.text;
  String password = passwordController.text;

  if (email.isEmpty || password.isEmpty) {
    // Show a dialog if fields are empty
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text('Please fill in both fields.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
    return;
  }

  // Define the login API endpoint
  var url = Uri.parse('https://dummyjson.com/auth/login');

  try {
    // Send the POST request with user credentials
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': email, // You can change this according to your API
        'password': password,
        'expiresInMins': 30,
      }),
    );

    if (response.statusCode == 200) {
      // Decode the response body
      var jsonResponse = jsonDecode(response.body);
      print('Login successful: $jsonResponse');
      Get.to(() => HomeScreen());
      Get.snackbar('Success', 'User Registered Successfully!');
    } else {
      print('Login failed with status: ${response.statusCode}');
      // Show an error message if login failed
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Login Failed'),
          content: Text('Please check your credentials and try again.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  } catch (error) {
    print('An error occurred: $error');
    // Handle error here
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text('An error occurred. Please try again.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
