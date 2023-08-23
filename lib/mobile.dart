import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otp_verify/otp.dart';

class EnterMobile extends StatefulWidget {
  const EnterMobile({Key? key}) : super(key: key);

  @override
  State<EnterMobile> createState() => _EnterMobileState();
}

class _EnterMobileState extends State<EnterMobile> {
  TextEditingController phoneController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  String otp = "";
  Country selectedCountry = Country(
    phoneCode: "91",
    countryCode: "IN",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "India",
    example: "India",
    displayName: "India",
    displayNameNoCountryCode: "IN",
    e164Key: "",
  );
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    phoneController.addListener(checkButtonEnabled);
  }

  void checkButtonEnabled() {
    setState(() {
      isButtonEnabled = phoneController.text.length >= 9;
    });
  }

  @override
  void dispose() {
    phoneController.removeListener(checkButtonEnabled);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, 'language');
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Please enter your mobile number',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  'You’ll receive a 6 digit code\nto verify next.',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                    controller: phoneController,
                    onChanged: (value) {
                      checkButtonEnabled();
                    },
                    decoration: InputDecoration(
                      hintText: "Mobile Number",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      prefixIcon: Container(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, top: 13),
                        child: InkWell(
                          onTap: () {
                            showCountryPicker(
                              context: context,
                              countryListTheme: const CountryListThemeData(
                                bottomSheetHeight: 500,
                              ),
                              onSelect: (value) {
                                setState(() {
                                  selectedCountry = value;
                                });
                                checkButtonEnabled();
                              },
                            );
                          },
                          child: Text(
                            "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
                            style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 60,
                  width: 375,
                  child: ElevatedButton(
                    onPressed: isButtonEnabled
                        ? () {
                            sendPhone();
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E3B62),
                      textStyle: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("CONTINUE"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void sendPhone() async {
    // Make sure to use the full phone number format, including the country code
    String fullPhoneNumber =
        '+${selectedCountry.phoneCode}${phoneController.text}';

    try {
      await auth.verifyPhoneNumber(
        phoneNumber: fullPhoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
          print("Signed in successfully");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EnterOtp(),
            ),
          );
        },
        verificationFailed: (FirebaseAuthException exception) {
          print("Verification failed: ${exception.message}");
        },
        codeSent: (String verificationId, int? resendToken) {
          otp = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      print("Error sending OTP: $e");
    }
  }
}
