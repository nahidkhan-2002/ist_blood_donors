import 'style.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:ist_blood_donors/apipage.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

var Loading = false;

class _RegisterpageState extends State<Registerpage> {
  Map<String, String> formdata = {
    'name': '',
    'phone': '',
    'address': '',
    'bloodGroup': '',
    'department': '',
    'session': '',
    'password': '',
    'confirmPassword': '',
  };

  void inputonchange(String key, String val) {
    setState(() {
      formdata.update(key, (value) => val);
    });
  }

  validateAndSubmit() async {
    for (var key in formdata.keys) {
      if (formdata[key] == null || formdata[key]!.trim().isEmpty) {
        showtoast('Please fill in the fields');
        // Return empty widget if validation fails
      }
    }
    if (formdata['password'] != formdata['confirmPassword']) {
      showtoast("password doesn't match");
    } else {
      setState(() {
        Loading = true;
      });
      await productcreateRequest(formdata);
      setState(() {
        Loading = false;
      });
    }
  }

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
                                onChanged: (value) {
                                  inputonchange('name', value);
                                },
                                decoration: AppInputDecoration('Name'),
                              ), //name
                              SizedBox(height: 16),
                              TextFormField(
                                onChanged: (value) {
                                  inputonchange('phone', value);
                                },
                                decoration: AppInputDecoration('Phone Number'),
                              ), //phone number
                              SizedBox(height: 16),
                              TextFormField(
                                onChanged: (value) {
                                  inputonchange('address', value);
                                },
                                decoration: AppInputDecoration('Address'),
                              ), // address
                              SizedBox(height: 16),
                              TextFormField(
                                onChanged: (value) {
                                  inputonchange('bloodGroup', value);
                                },
                                decoration: AppInputDecoration(
                                  "Blood Group (ex O+ AB+ B-)",
                                ),
                              ), // blood group
                              SizedBox(height: 16),
                              TextFormField(
                                onChanged: (value) {
                                  inputonchange('department', value);
                                },
                                decoration: AppInputDecoration("Department"),
                              ), // department
                              SizedBox(height: 16),
                              TextFormField(
                                onChanged: (value) {
                                  inputonchange('session', value);
                                },
                                decoration: AppInputDecoration("Session"),
                              ), //session
                              SizedBox(height: 16),
                              TextFormField(
                                onChanged: (value) {
                                  inputonchange('password', value);
                                },
                                decoration: AppInputDecorationPass("Password"),
                                obscureText: true,
                                obscuringCharacter: '*',
                              ), //password
                              SizedBox(height: 16),
                              TextFormField(
                                onChanged: (value) {
                                  inputonchange('confirmPassword', value);
                                },
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
                                    onPressed: () async {
                                      await validateAndSubmit();
                                      Navigator.pushReplacementNamed(
                                        context,
                                        'login',
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(45, 45),
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
