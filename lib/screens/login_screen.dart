import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  final bool isFirstTime;

  const LoginScreen({super.key, required this.isFirstTime});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = TextEditingController();
  String error = "";

  void submit() async {
    if (widget.isFirstTime) {
      await StorageService.savePin(controller.text);
      goHome();
    } else {
      String? pin = await StorageService.getPin();
      if (controller.text == pin) {
        goHome();
      } else {
        setState(() => error = "Wrong PIN");
      }
    }
  }

  void goHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock, size: 60),
            SizedBox(height: 20),
            Text(
              widget.isFirstTime ? "Create PIN" : "Enter PIN",
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 20),
            TextField(
              controller: controller,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "PIN",
              ),
            ),
            SizedBox(height: 10),
            Text(error, style: TextStyle(color: Colors.red)),
            SizedBox(height: 20),
            ElevatedButton(onPressed: submit, child: Text("Continue"))
          ],
        ),
      ),
    );
  }
}