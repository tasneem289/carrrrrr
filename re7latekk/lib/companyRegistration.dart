import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:re7latekk/addCarrr.dart';

enum AddressChoice { Cairo, Giza, Tanta, Fayoum, Minia, Assiut, Sohag, Aswan }

class SignUpCompany extends StatelessWidget {
  const SignUpCompany({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.white,
        textSelectionTheme:
            const TextSelectionThemeData(selectionColor: Colors.black),
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            '',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: const RegistrationFields(),
      ),
    );
  }
}

class RegistrationFields extends StatefulWidget {
  const RegistrationFields({Key? key}) : super(key: key);

  @override
  _RegistrationFieldsState createState() => _RegistrationFieldsState();
}

class _RegistrationFieldsState extends State<RegistrationFields> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? fullName, email, password, phoneNumber, taxNumber;
  AddressChoice? selectedAddressChoice;

  String? validateRequiredField(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your $fieldName';
    }
    return null;
  }

  FormFieldValidator<String>? passwordValidator = (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  };

  Future<void> registerUser() async {
    // Validate all fields here
    String? fullNameError = validateRequiredField(fullName, 'full name');
    String? phoneNumberError =
        validateRequiredField(phoneNumber, 'phone number');
    String? taxNumberError = validateRequiredField(taxNumber, 'tax number');
    String? emailError = validateRequiredField(email, 'email');
    String? passwordError = passwordValidator!(password);

    if (fullNameError != null ||
        phoneNumberError != null ||
        taxNumberError != null ||
        emailError != null ||
        passwordError != null) {
      // Display the first error message encountered
      String? errorMessage = fullNameError ??
          phoneNumberError ??
          taxNumberError ??
          emailError ??
          passwordError;
      final snackBar = SnackBar(content: Text(errorMessage!));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return; // Stop registration if any field is invalid
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddCar()),
    );
  }

  @override
  Widget build(BuildContext context) {
    const labelStyle = TextStyle(color: Colors.grey, fontSize: 16);
    const inputStyle = TextStyle(color: Colors.black, fontSize: 18);

    buildAddressDropdown(TextStyle labelStyle, TextStyle inputStyle) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonFormField<AddressChoice>(
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'ADDRESS',
                labelStyle: labelStyle,
              ),
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.black, // Change the arrow color
              ),
              style: inputStyle,
              value: selectedAddressChoice,
              onChanged: (AddressChoice? value) {
                setState(() {
                  selectedAddressChoice = value;
                });
              },
              items: AddressChoice.values.map((AddressChoice choice) {
                return DropdownMenuItem<AddressChoice>(
                  value: choice,
                  child: Text(
                    choice.toString().split('.').last,
                    style: TextStyle(
                      color: Colors.black, // Change the text color
                    ),
                  ),
                );
              }).toList(),
              dropdownColor: Colors.white, // Change the background color
            ),
          ),
        ],
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 330,
            height: 330, // Adjust the height as needed
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('Images/SignUpCompany.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Color(0xFF164863),
                    fontSize: 28,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 20),
                buildGrayBoxTextField(
                  'FULL NAME',
                  labelStyle,
                  inputStyle,
                  onChanged: (value) {
                    setState(() {
                      fullName = value.trim();
                    });
                  },
                ),
                const SizedBox(height: 5),
                buildGrayBoxTextField(
                  'PHONE NUMBER',
                  labelStyle,
                  inputStyle,
                  onChanged: (value) {
                    setState(() {
                      phoneNumber = value;
                    });
                  },
                ),
                const SizedBox(height: 5),
                buildGrayBoxTextField(
                  'TAX NUMBER',
                  labelStyle,
                  inputStyle,
                  onChanged: (value) {
                    setState(() {
                      taxNumber = value;
                    });
                  },
                ),
                const SizedBox(height: 5),
                buildAddressDropdown(labelStyle, inputStyle),
                const SizedBox(height: 5),
                buildGrayBoxTextField(
                  'EMAIL',
                  labelStyle,
                  inputStyle,
                  onChanged: (value) {
                    setState(() {
                      email = value.trim();
                    });
                  },
                  validator: (value) => validateRequiredField(value, 'email'),
                ),
                const SizedBox(height: 5),
                buildGrayBoxTextField(
                  'PASSWORD',
                  labelStyle,
                  inputStyle,
                  obscureText: true,
                  validator: passwordValidator,
                  onChanged: (value) {
                    setState(() {
                      password = value.trim();
                    });
                  },
                ),
                const SizedBox(height: 20),
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      await registerUser();
                      try {
                        UserCredential userCredential =
                            await _auth.createUserWithEmailAndPassword(
                          email: email!,
                          password: password!,
                        );

                        if (userCredential.user != null) {
                          await _firestore
                              .collection('Companies')
                              .doc(userCredential.user!.uid)
                              .set({
                            'full_name': fullName,
                            'phoneNumber': phoneNumber,
                            'taxNumber': taxNumber,
                            'address': selectedAddressChoice
                                .toString()
                                .split('.')
                                .last,
                            'email': email,
                          });
                        }
                      } catch (e) {
                        print(e);
                        final snackBar = SnackBar(
                            content: Text(
                                'Error registering user. ${e.toString()}'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } // Wait for registerUser to complete
                    },
                    child: Container(
                      width: 180,
                      height: 47,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(14)),
                        color: Color(0xFF045F91),
                      ),
                      child: const Center(
                        child: Text(
                          'SIGN UP',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGrayBoxTextField(
    String label,
    TextStyle labelStyle,
    TextStyle inputStyle, {
    ValueChanged<String>? onChanged,
    FormFieldValidator<String>? validator,
    bool obscureText = false,
  }) {
    return TextFormField(
      style: TextStyle(color: Colors.black, fontSize: 18),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: labelStyle,
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText,
    );
  }
}
