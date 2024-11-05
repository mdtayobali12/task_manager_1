import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:task_manager_1/presentation/screen/auth/sing_up_screen.dart';
import '../../controllers/sing_in_controller.dart';
import '../../widgets/background_widget.dart';
import '../../widgets/show_snack_bar_message.dart';
import '../main_bottom_nav_screen.dart';
import 'email_verification_screen.dart';


class SingInScreen extends StatefulWidget {
  const SingInScreen({super.key});

  @override
  State<SingInScreen> createState() => _SingInScreenState();
}

class _SingInScreenState extends State<SingInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final SingInController _singInController = Get.find<SingInController>();

  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100),
                  Text(
                    "Get Started With",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 50),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter you email";
                      }
                      return null;
                    },
                    controller: _emailController,
                    decoration: const InputDecoration(hintText: "Email"),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter you Password";
                      }
                      if (value.length <= 6) {
                        return "Password shed be 6 characters";
                      }
                      return null;
                    },
                    obscureText: true,
                    controller: _passwordController,
                    decoration: const InputDecoration(hintText: "Password"),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: GetBuilder<SingInController>(
                        builder: (singInController) {
                          return Visibility(
                            visible: singInController.inProgress == false,
                            replacement:
                            const Center(child: CircularProgressIndicator()),
                            child: ElevatedButton(
                                onPressed: () async {
                                  if (_formkey.currentState!.validate()) {
                                    _singIn();
                                  }
                                },
                                child:
                                const Icon(Icons.arrow_circle_right_outlined)),
                          );
                        }),
                  ),
                  const SizedBox(height: 60),
                  Center(
                    child: TextButton(
                      style:
                      TextButton.styleFrom(foregroundColor: Colors.red),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                              const EmailVerificationScreen(),
                            ));
                      },
                      child: const Text(
                        "Forget Password ?",
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(fontSize: 16),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SingUpScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Sing up",
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _singIn() async {
    final result = await _singInController.singIn(
        _emailController.text.trim(), _passwordController.text);
    if (result) {
      if (mounted) {
        showSnackBarMessage(context, "Login Successful");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const MainBottomNavScreen(),
            ),
                (route) => false);
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context, _singInController.errorMessage);
      }
    }
  }
}