import 'dart:convert';

import 'package:cubex/Services/api_calls_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ProfileScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final profileData = useState<Map<String, dynamic>>({});

    void fetchProfile() async {
      try {
        final response = await ApiCallHandler().getRequest(endPoint: 'profile', includeToken: true);
        if (response?.statusCode == 200) {
          final profile = jsonDecode(response!.body) as Map<String, dynamic>;
          profileData.value = profile;
        } else {
          // Handle invalid token or other errors
        }
      } catch (e) {
        // Handle network error
      }
    }

    useEffect(() {
      // Fetch user profile data upon page load
      fetchProfile();
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Username: ${profileData.value['username']}'),
            Text('Email: ${profileData.value['email']}'),
            Text('Phone: ${profileData.value['phone']}'),
            // Display other profile information
          ],
        ),
      ),
    );
  }
}
