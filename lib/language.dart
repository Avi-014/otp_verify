import 'package:flutter/material.dart';
import 'package:otp_verify/mobile.dart';

class SelectLanguage extends StatefulWidget {
  const SelectLanguage({super.key});

  @override
  State<SelectLanguage> createState() => _SelectLanguageState();
}

class _SelectLanguageState extends State<SelectLanguage> {
  String valueChoose = 'English';
  List listItem = ["English", "हिंदी", "বাংলা", "मराठी"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 150),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.purple.shade50),
                    child: Image.asset(
                      'assets/images/gallery.png',
                      height: 90,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Please select your Language',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'You can change the Language\nat anytime',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: DropdownButton(
                      hint: const Text('Choose Language'),
                      dropdownColor: Colors.blueGrey,
                      value: valueChoose,
                      onChanged: (newValue) {
                        // setState(() {
                        //   valueChoose = newValue;
                        // });
                      },
                      items: listItem.map((valueItem) {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Text(valueItem),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: 60,
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EnterMobile(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E3B62),
                        textStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("NEXT"),
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image.asset(
                  'assets/images/vector2.png',
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fitWidth,
                ),
                Positioned(
                  bottom: 0,
                  child: Image.asset('assets/images/vector.png',
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.contain),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
