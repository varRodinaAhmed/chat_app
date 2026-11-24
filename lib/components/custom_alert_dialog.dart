import 'package:chat_app/components/custom_button.dart';
import 'package:chat_app/components/custom_textfield.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/services/firebase_services.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatefulWidget {
  const CustomAlertDialog({super.key});

  @override
  State<CustomAlertDialog> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  final emailController = TextEditingController();

  final nameController = TextEditingController();

  bool isLoading = false;

  String? errMsg;
  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    super.dispose();
  }

  Future<void> _add() async {
    if (isLoading) return;

    if (emailController.text.trim().isEmpty ||
        nameController.text.trim().isEmpty) {
      setState(() => errMsg = "write email and name");
      return;
    }
    if (emailController.text.trim() == user!.email) {
      setState(() => errMsg = "you can\'t add yourself !");
      return;
    }

    setState(() {
      isLoading = true;
      errMsg = null;
    });

    try {
      final isAdded = await FirebaseServices.addContact(
        emailController.text.trim(),
        nameController.text.trim(),
      );

      if (!mounted) return;

      if (isAdded) {
        Navigator.pop(context, true); // true = اتضاف، علشان الشاشة تتحدث
      } else {
        setState(() {
          errMsg = "this email is not found in users";
          isLoading = false;
        });
      }
    } catch (e) {
      print('ERROR: $e');
      if (!mounted) return;
      setState(() {
        errMsg = "error, try again";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              "Add new contact",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          SizedBox(height: 10),
          customTextfield(
            title: "email",
            onSubmitted: (Value) {},
            controller: emailController,
          ),
          SizedBox(height: 10),
          customTextfield(
            title: "name",
            onSubmitted: (Value) {},
            controller: nameController,
          ),
          SizedBox(height: 10),
          if (errMsg != null)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(errMsg!, style: TextStyle(color: Colors.red)),
            ),
          SizedBox(height: 10),
          customButton(
            buttonColor: Colors.teal,
            textColor: Colors.white,
            title: isLoading ? "Adding..." : "Add contact",
            onTapFun: _add,
          ),
        ],
      ),
    );
  }
}
