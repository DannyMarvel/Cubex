import 'dart:convert';
import 'dart:io';

import 'package:cubex/Screens/login_screen..dart';
import 'package:cubex/Services/api_calls_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';

class RegistrationScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final emailController = useTextEditingController();
    final phoneController = useTextEditingController();
    final addressController = useTextEditingController();
    final imagePicker = ImagePicker();

    final selectedImageState = useState<XFile?>(null);

    void _selectImage() async {
      final XFile? selectedImage = await imagePicker.pickImage(source: ImageSource.gallery);
      if (selectedImage != null) {
        selectedImageState.value = selectedImage;
      }
    }

    void register() async {
      // Prepare form data
      final Map<String, String> formData = {
        'username': usernameController.text,
        'password': passwordController.text,
        'email': emailController.text,
        'phone': phoneController.text,
        'address': addressController.text,
        "image": 'string',
      };

      // Check if an image is selected
      if (selectedImageState.value != null) {
        // Read the image file as bytes and encode it to base64
        final File imageFile = File(selectedImageState.value!.path);
        List<int> imageBytes = await imageFile.readAsBytes();
        String base64Image = base64Encode(imageBytes);

        // Add base64 encoded image to form data
        formData['image'] = base64Image;
      }

      // Make POST request using http package
      final response = await ApiCallHandler().postRequest(
        endPoint: "register",
        body: formData,
      );
      print('Welcome');
      if (response?.statusCode == 201) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } else {}
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Phone'),
            ),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(labelText: 'Address'),
            ),
            ElevatedButton(
              onPressed: _selectImage,
              child: const Text('Select Image'),
            ),
            if (selectedImageState.value != null) Image.file(File(selectedImageState.value!.path)),
            ElevatedButton(
              onPressed: register,
              child: const Text('Register'),
            ),
            const SizedBox(height: 10),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: const Text(
                  "Already have account? Login",
                  style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.w600,
                  ),
                ))
          ]),
        ),
      ),
    );
  }
}

// import 'dart:io';

// import 'package:cubex/Screens/login_screen..dart';
// import 'package:cubex/Services/helpers.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:dio/dio.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:image_picker/image_picker.dart';

// final dioProvider = Provider<Dio>((ref) => Dio());

// class RegistrationScreen extends HookWidget {
//   @override
//   Widget build(BuildContext context) {
//     //  final dio = useProvider(dioProvider);
//     final dio = Dio();
//     final usernameController = useTextEditingController();
//     final passwordController = useTextEditingController();
//     final emailController = useTextEditingController();
//     final phoneController = useTextEditingController();
//     final addressController = useTextEditingController();
//     final imagePicker = ImagePicker();

//     final selectedImageState = useState<XFile?>(null);

//     void _selectImage() async {
//       final XFile? selectedImage =
//           await imagePicker.pickImage(source: ImageSource.gallery);
//       if (selectedImage != null) {
//         selectedImageState.value = selectedImage;
//       }
//     }

//     void register() async {
//       try {
//         FormData formData = FormData.fromMap({
//           'username': usernameController.text,
//           'password': passwordController.text,
//           'email': emailController.text,
//           'phone': phoneController.text,
//           'address': addressController.text,
//         });
//         print('hello');

//         if (selectedImageState.value != null) {
//           formData.fields.add({
//             "image",
//             Helpers.getFileString(filePath: selectedImageState.value!.path)
//           } as MapEntry<String, String>);
//         }
//         print(formData.fields);
//         final response = await dio.post(
//           'https://stacked.com.ng/api/register',
//           data: formData,
//         );
//         print('Welcome');
//         print(formData.fields);

//         if (response.statusCode == 200) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => LoginScreen()),
//           );
//         } else {
//           // Handle registration error
//         }
//       } catch (e) {
//         print(":::::: from the error room:::: $e");
//         // Handle network error
//       }
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Registration'),
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
//             TextField(
//               controller: emailController,
//               decoration: InputDecoration(labelText: 'Email'),
//             ),
//             TextField(
//               controller: phoneController,
//               decoration: InputDecoration(labelText: 'Phone'),
//             ),
//             TextField(
//               controller: addressController,
//               decoration: InputDecoration(labelText: 'Address'),
//             ),
//             ElevatedButton(
//               onPressed: _selectImage,
//               child: Text('Select Image'),
//             ),
//             if (selectedImageState.value != null)
//               Image.file(File(selectedImageState.value!.path)),
//             ElevatedButton(
//               onPressed: register,
//               child: Text('Register'),
//             ),
//             //             ElevatedButton(
//             //   onPressed: login,
//             //   child: Text('Login'),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }
