import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class EnterOtp extends StatelessWidget {
  const EnterOtp({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController pinController = TextEditingController();
    final defaultPinTheme = PinTheme(
      width: 48,
      height: 48,
      textStyle: const TextStyle(
          fontSize: 15,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.lightBlueAccent, width: 2),
        borderRadius: BorderRadius.circular(5),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, 'mobile');
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Verify Phone',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'Code is sent to 6549845781',
                style: TextStyle(color: Colors.grey, fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Pinput(
                    length: 6,
                    keyboardType: TextInputType.number,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: submittedPinTheme,
                    validator: (s) {
                      return s == '2222' ? null : 'Pin is incorrect';
                    },
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    showCursor: true,
                    androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
                    controller: pinController,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Didn’t receive the code?',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'mobile');
                      },
                      child: const Text(
                        'Request Again',
                        style: TextStyle(fontSize: 13, color: Colors.black),
                      ))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 60,
                width: 375,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'otp');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E3B62),
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text("VERIFY AND CONTINUE"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
