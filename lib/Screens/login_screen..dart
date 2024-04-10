
import 'dart:convert';
import 'dart:developer';

import 'package:cubex/Screens/profile_screen.dart';
import 'package:cubex/Screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http; // Import http package

class LoginScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();

    void login() async {
      try {
        final response = await http.post(
          Uri.parse('https://stacked.com.ng/api/login'),
          body: {
            'username': usernameController.text,
            'password': passwordController.text,
          },
        );
        if (response.statusCode == 200) {
          final tokenData = json.decode(response.body) as Map<String, dynamic>;
          log(":::::: response from login screen :::: $tokenData");

          // Navigate to profile page upon successful login
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ProfileScreen()),
          );
        } else {
          // Handle login error
          // Show error message to the user
        }
      } catch (e) {
        // Handle network error
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}


















































// import 'dart:developer';

// import 'package:cubex/Screens/profile_screen.dart';
// import 'package:cubex/Screens/registration_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:dio/dio.dart';

// class LoginScreen extends HookWidget {
//   @override
//   Widget build(BuildContext context) {
//     //  final dio = UseProvider(dioProvider);
//     //  final token = useProvider(tokenProvider);
//     final dio = Dio();

//     // Login form state
//     final usernameController = useTextEditingController();
//     final passwordController = useTextEditingController();

//     void login() async {
//       try {
//         final response = await dio.post(
//           'https://stacked.com.ng/docs#/Auth/post_Login',
//           data: {
//             'username': usernameController.text,
//             'password': passwordController.text,
//           },
//         );
//         if (response.statusCode == 200) {
//           final tokenData = response.data as Map<String, dynamic>;
//           log(":::::: response from login screen :::: $tokenData");

//           // token.state = tokenData['token'];
//           // Navigate to profile page upon successful login
//           // Navigator.pushReplacement(
//           //   context,
//           //   MaterialPageRoute(builder: (context) => ProfileScreen()),
//           // );prin
//         } else {
//           // Handle login error
//           // Show error message to the user
//         }
//       } catch (e) {
//         // Handle network error
//       }
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: usernameController,
//               decoration: InputDecoration(labelText: 'Username'),
//             ),
//             TextField(
//               controller: passwordController,
//               decoration: InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             ElevatedButton(
//               onPressed: login,
//               child: Text('Login'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
