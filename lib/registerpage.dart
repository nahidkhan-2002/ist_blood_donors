import 'style.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ScreenBackgroundReg(context),
          //name ,phone number,address,blood group,department,session,password,confirm password
          LayoutBuilder(
            builder: (context, constraints) {
              return Transform.scale(
                scale: 0.9,
                child: Center(
                  child: Container(
                    height: 750,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 16,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Center(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(20),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 400),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                onChanged: (value) {},
                                decoration: AppInputDecoration('Name'),
                              ), //name
                              SizedBox(height: 16),
                              TextFormField(
                                onChanged: (value) {},
                                decoration: AppInputDecoration('Phone Number'),
                              ), //phone number
                              SizedBox(height: 16),
                              TextFormField(
                                onChanged: (value) {},
                                decoration: AppInputDecoration('Address'),
                              ), // address
                              SizedBox(height: 16),
                              TextFormField(
                                onChanged: (value) {},
                                decoration: AppInputDecoration(
                                  "Blood Group (ex O+ AB+ B-)",
                                ),
                              ), // blood group
                              SizedBox(height: 16),
                              TextFormField(
                                onChanged: (value) {},
                                decoration: AppInputDecoration("Department"),
                              ), // department
                              SizedBox(height: 16),
                              TextFormField(
                                onChanged: (value) {},
                                decoration: AppInputDecoration("Session"),
                              ), //session
                              SizedBox(height: 16),
                              TextFormField(
                                onChanged: (value) {},
                                decoration: AppInputDecorationPass("Password"),
                                obscureText: true,
                                obscuringCharacter: '*',
                              ), //password
                              SizedBox(height: 16),
                              TextFormField(
                                onChanged: (value) {},
                                decoration: AppInputDecorationPass(
                                  "Confirm Password",
                                ),
                                obscureText: true,
                                obscuringCharacter: '*',
                              ), // confirm password
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Registration successful',
                                          ),
                                          duration: Duration(seconds: 3),
                                          backgroundColor: Colors.green,
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(),
                                        ),
                                      );
                                      Navigator.pushReplacementNamed(
                                        context,
                                        'login',
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(350, 50),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero,
                                      ),
                                    ),
                                    child: Shimmer.fromColors(
                                      baseColor: const Color.fromARGB(
                                        255,
                                        191,
                                        22,
                                        22,
                                      ),
                                      highlightColor: const Color.fromARGB(
                                        255,
                                        29,
                                        31,
                                        31,
                                      ),
                                      child: Text(
                                        "Register",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
