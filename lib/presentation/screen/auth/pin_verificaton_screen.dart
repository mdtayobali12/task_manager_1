import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_1/presentation/screen/auth/set_password_screen.dart';
import 'package:task_manager_1/presentation/screen/auth/sing_in_screen.cpp.dart';
import '../../../data/services/network_caller.dart';
import '../../../data/utility/Urls.dart';
import '../../widgets/background_widget.dart';
import '../../widgets/show_snack_bar_message.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({
    Key? key,
    required this.email,
  }) : super(key: key);

  final String email;

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final TextEditingController _pinController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _pinverifyInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                Text(
                  "Pin Verification",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 5),
                const Text(
                  "A 6 Digits verification code will be sent to your email address",
                  style: TextStyle(color: Colors.teal),
                ),
                const SizedBox(height: 45),
                PinCodeTextField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter otp";
                    }
                    return null;
                  },
                  controller: _pinController,
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                    inactiveFillColor: Colors.white,
                    inactiveColor: Colors.green,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  onCompleted: (v) {
                    print("Completed");
                  },
                  onChanged: (value) {},
                  appContext: context,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    visible: _pinverifyInProgress == false,
                    replacement:
                    const Center(child: CircularProgressIndicator()),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _receivedOtp();
                        }
                      },
                      child: const Text(
                        "Verify",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Have an account?",
                      style: TextStyle(fontSize: 16),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SingInScreen(),
                          ),
                              (route) => false,
                        );
                      },
                      child: const Text(
                        "Sign in",
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  Future<void> _receivedOtp() async {
    setState(() {
      _pinverifyInProgress = true;
    });
    final response = await NetworkCaller.getRequest(
        Urls.receivedSendOtp(widget.email, _pinController.text));
    _pinverifyInProgress = false;
    setState(() {});
    if (response.ResponseBody['status'] == 'success') {
      if (mounted) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SetPasswordScreen(
                  email: widget.email, otp: _pinController.text),
            ));
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context, "wrong otp");
      }
    }
  }
}