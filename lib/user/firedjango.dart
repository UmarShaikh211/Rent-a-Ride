// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//   Future<void> _login() async {
//     try {
//       final UserCredential userCredential =
//           await _auth.signInWithEmailAndPassword(
//         email: _emailController.text,
//         password: _passwordController.text,
//       );
//       final User? user = userCredential.user;
//       // Navigate to the next screen or perform other actions upon successful login
//     } catch (e) {
//       // Handle login errors
//       print(e.toString());
//     }
//   }
//
//   Future<void> _signup() async {
//     try {
//       final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//         email: _emailController.text,
//         password: _passwordController.text,
//       );
//
//       final User? user = userCredential.user;
//
//       if (user != null) {
//         // Update the user's profile with the provided name
//         await user.updateProfile(displayName: _nameController.text);
//
//         // Navigate to the next screen or perform other actions upon successful signup
//       } else {
//         // Handle the case where user is null (unexpected error)
//         print('User is null after sign-up.');
//       }
//     } catch (e) {
//       // Handle signup errors
//       print(e.toString());
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Firebase Auth Example')),
//       body: Center(
//         child: Column(
//           children: [
//             TextField(
//               controller: _nameController,
//               decoration: InputDecoration(labelText: 'Name'),
//             ),
//             TextField(
//               controller: _emailController,
//               decoration: InputDecoration(labelText: 'Email'),
//             ),
//             TextField(
//               controller: _passwordController,
//               decoration: InputDecoration(labelText: 'Password'),
//             ),
//             ElevatedButton(
//               onPressed: _login,
//               child: Text('Login'),
//             ),
//             ElevatedButton(
//               onPressed: _signup,
//               child: Text('Sign Up'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
