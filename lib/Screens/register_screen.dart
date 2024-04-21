import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterScreenState createState() => _RegisterScreenState();
}

/// Энэхүү функц нь хэрэглэгчийн оруулсан нууц үгийг хүчтэй эсэхийг
/// шалган үнэн, эсвэл худлаа гэсэн хариуг буцаах функц юм.
bool isStrongPassword(String password) {
  /// Minimum length of the password
  const minLength = 8;

  // Check if the password meets the minimum length requirement
  if (password.length < minLength) {
    return false;
  }

  // Check if the password contains at least one uppercase letter
  if (!password.contains(RegExp(r'[A-Z]'))) {
    return false;
  }

  // Check if the password contains at least one lowercase letter
  if (!password.contains(RegExp(r'[a-z]'))) {
    return false;
  }

  // Check if the password contains at least one digit
  if (!password.contains(RegExp(r'[0-9]'))) {
    return false;
  }

  // Check if the password contains at least one special character
  if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    return false;
  }

  // The password passed all criteria and is considered strong
  return true;
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isObscured = true;
  bool _isObscuredConfirm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff0f0f0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset('assets/images/background.png'),
                const Positioned.fill(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Тавтай морилно уу?",
                        style: TextStyle(
                          color: Color(0xff545151),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Бүртгэлээ хийлгэсний дараа нэвтэрнэ үү!",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            Container(
              width: 310,
              height: 53,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                      border: InputBorder.none,
                      hintText: 'Бүтэн нэрээ оруулна уу?'),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 310,
              height: 53,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                      border: InputBorder.none,
                      hintText: 'Имэйлээ оруулна уу?'),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 310,
              height: 53,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                  child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  TextField(
                    obscureText: _isObscured,
                    controller: _passwordController,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15),
                        border: InputBorder.none,
                        hintText: 'Нууц үгээ оруулна уу.'),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                        _isObscured ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _isObscured = !_isObscured;
                      });
                    },
                  ),
                ],
              )),
            ),
            const SizedBox(height: 20),
            Container(
              width: 310,
              height: 53,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    TextField(
                      controller: _confirmPasswordController,
                      obscureText: _isObscuredConfirm,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15),
                        border: InputBorder.none,
                        hintText: 'Нууц үгээ давтан оруулна уу.',
                      ),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    IconButton(
                      icon: Icon(_isObscuredConfirm
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _isObscuredConfirm = !_isObscuredConfirm;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            InkWell(
              onTap: () async {
                if (_passwordController.text ==
                    _confirmPasswordController.text) {
                  if (isStrongPassword(_passwordController.text)) {
                    try {
                      UserCredential userCredential =
                          await _auth.createUserWithEmailAndPassword(
                              email: _emailController.text.trim(),
                              password:
                                  _passwordController.text //hashedPassword
                              );
                      await FirebaseFirestore.instance
                          .collection('Users')
                          .doc(userCredential.user!.uid)
                          .set({
                        'userId': userCredential.user!.uid,
                        'Name': _nameController.text,
                        'Email': _emailController.text.trim(),
                        'password': _passwordController.text, //hashedPassword,
                        'point': 0,
                      });
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              "Амжилттай бүртгэгдлээ.\nНэвтрэх дээр дарж нэвтэрнэ үү."),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    } catch (error) {
                      if (kDebugMode) {
                        print("Error: $error");
                      }
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            "Нууц үг дор хаяж 8 тэмдэгт, 1 том үсэг, 1 жижиг үсэг,\n"
                            " 1 тоо,1 тусгай тэмдэггтэй байх ёстой."),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Нууц үг таарахгүй байна."),
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
              },
              child: Container(
                width: 310,
                height: 53,
                decoration: BoxDecoration(
                  color: const Color(0xffA3ECFF),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Text(
                    'Бүртгүүлэх',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text('Хэрэглэгчийн Эрх бий юу?'),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                  child: const Text("Нэвтрэх",
                      style: TextStyle(color: Color(0xffA3ECFF))),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
