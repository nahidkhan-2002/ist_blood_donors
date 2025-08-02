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
  };

  void inputonchange(String key, String val) {
    setState(() {
      formdata.update(key, (value) => val);
    });
  }

  Future<bool> validateAndSubmit() async {
    bool ok = true;
    for (var key in formdata.keys) {
      if (formdata[key] == null || formdata[key]!.trim().isEmpty) {
        showtoast('Please fill in the fields');
        ok = false;
        break;
        // Return empty widget if validation fails
      }
    }
    if (ok) {
      setState(() {
        Loading = true;
      });

      bool success = await createRequest(formdata);

      setState(() {
        Loading = false;
      });

      return success;
    }

    return false;
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
                              ), //session // confirm password
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Loading
                                      ? (Center(
                                        child: CircularProgressIndicator(),
                                      ))
                                      : (ElevatedButton(
                                        onPressed: () async {
                                          bool success =
                                              await validateAndSubmit();
                                          showtoast(
                                            "Redirecting to Main Page...",
                                          );
                                          if (success) {
                                            showtoast(
                                              'Redirecting to Main Page',
                                            );
                                            Navigator.pushReplacementNamed(
                                              context,
                                              'secondsplashscreen',
                                            );
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: Size(
                                            MediaQuery.of(context).size.width *
                                                0.85,
                                            MediaQuery.of(context).size.height *
                                                0.055,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.zero,
                                          ),
                                        ),
                                        child: Shimmer.fromColors(
                                          baseColor: const Color.fromARGB(
                                            255,
                                            0,
                                            0,
                                            0,
                                          ),
                                          highlightColor: const Color.fromARGB(
                                            163,
                                            225,
                                            70,
                                            27,
                                          ),
                                          child: Text(
                                            "Register",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      )),
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
