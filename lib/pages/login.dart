import 'package:flutter/material.dart';
import 'package:scanner/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _title() {
    return const Text('登入');
  }

  Widget _entryField(String title, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
      ),
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : '$errorMessage');
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed: signInWithEmailAndPassword,
      child: const Text('Submit'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                label: Text('E-mail'),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                label: Text('password'),
              ),
              keyboardType: TextInputType.number,
            ),
            // _entryField('E-mail', _emailController),
            // _entryField('password', _passwordController),
            _errorMessage(),
            _submitButton(),
          ],
        ),
      ),
    );
  }
}

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:scanner/main.dart';
//
// class Login extends StatefulWidget {
//   Login({Key? key}) : super(key: key);
//
//   @override
//   State<Login> createState() => _LoginState();
// }
//
// class _LoginState extends State<Login> {
//   final idController = TextEditingController();
//   final passController = TextEditingController();
//
//   Future<FirebaseApp> _initializeFirebase() async {
//     FirebaseApp firebaseApp = await Firebase.initializeApp();
//     return firebaseApp;
//   }
//
//   @override
//   void dispose() {
//     idController.dispose();
//     passController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('使用者登入'),
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(10),
//         children: [
//           //輸入電子郵件
//           TextField(
//             decoration: const InputDecoration(
//               label: Text('E-mail'),
//               icon: Icon(Icons.mail),
//             ),
//             controller: idController,
//           ),
//           //輸入密碼
//           TextField(
//             decoration: const InputDecoration(
//               label: Text('密碼'),
//               icon: Icon(Icons.key),
//             ),
//             controller: passController,
//             obscureText: true,
//           ),
//           Container(
//             margin: const EdgeInsets.all(10),
//             child: ElevatedButton(
//               onPressed: () {
//                 _signIn(idController.text, passController.text);
//                 // if (FirebaseAuth.instance.authStateChanges() != null) {
//                 //   Navigator.push(
//                 //     context,
//                 //     MaterialPageRoute(
//                 //       builder: (context) => MyApp(),
//                 //     ),
//                 //   );
//                 // }
//               },
//               child: const Text('登入'),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
//
// void _signIn(String id, String pass) async {
//   try {
//     final credential = await FirebaseAuth.instance
//         .signInWithEmailAndPassword(email: id, password: pass);
//   } on FirebaseAuthException catch (e) {
//     if (e.code == 'invalid-email') {
//       print('無效的電子郵件');
//     }
//   }
// }
