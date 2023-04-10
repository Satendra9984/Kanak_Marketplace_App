import 'dart:convert';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:tasvat/models/ModelProvider.dart';
import 'package:tasvat/models/function_lifetime_enum.dart';
import 'package:tasvat/providers/user_provider.dart';
import 'package:tasvat/services/datastore_services.dart';
import 'package:tasvat/services/gold_services.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/ui_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddUserAddressPage extends ConsumerStatefulWidget {
  final String? email;
  const AddUserAddressPage({super.key, this.email});

  @override
  ConsumerState<AddUserAddressPage> createState() => _UserAddressPageState();
}

class _UserAddressPageState extends ConsumerState<AddUserAddressPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _pinCodeCtrl = TextEditingController();
  final TextEditingController _addressCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();

  FunctionLifetime _functionLifetime = FunctionLifetime.initialize;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: background,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          // color: Colors.green,
        ),
        alignment: Alignment.center,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// use details text
                Align(
                  child: Text(
                    'Add Address',
                    style: TextStyle(
                      color: text500,
                      fontSize: title,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                /// Name
                Text(
                  'Name',
                  style: TextStyle(
                    color: text500,
                    fontSize: body2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // color: text150,
                  ),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.name,
                    controller: _nameCtrl,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your First Name';
                      } else if (value.length > 30) {
                        return 'Less than 30 letters';
                      } else if (value.length < 2) {
                        return 'Greater than 2 letters';
                      }
                      return null;
                    },
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: accent2,
                    ),
                    decoration: getInputDecoration('First Name').copyWith(
                      errorStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: error,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                /// email
                Text(
                  'Email',
                  style: TextStyle(
                    color: text500,
                    fontSize: body2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // color: text150,
                  ),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailCtrl,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email';
                      } else {
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value);
                        if (!emailValid) {
                          return 'Please Enter a valid email';
                        }
                      }

                      return null;
                    },
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: accent2,
                    ),
                    decoration: getInputDecoration('example123@gmail.com'),
                  ),
                ),
                const SizedBox(height: 10),

                /// phone
                Text(
                  'Phone Number',
                  style: TextStyle(
                    color: text500,
                    fontSize: body2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  // height: 60,
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _phoneCtrl,
                    onChanged: (value) {},
                    validator: (value) {
                      String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                      RegExp regExp = RegExp(pattern);
                      if (value == null || value.isEmpty) {
                        return 'Please enter mobile number';
                      } else if (!regExp.hasMatch(value)) {
                        return 'Please enter valid mobile number';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: accent2,
                    ),
                    decoration: getInputDecoration('Phone Number'),
                  ),
                ),
                const SizedBox(height: 10),

                /// address
                Text(
                  'Address',
                  style: TextStyle(
                    color: text500,
                    fontSize: body2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.streetAddress,
                    controller: _addressCtrl,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an address';
                      } else if (value.length < 5) {
                        return 'Please Enter a valid address';
                      }
                      return null;
                    },
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: accent2,
                    ),
                    decoration: getInputDecoration(
                      '11-6-323, Goods Shed Road, Nampally',
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                /// pinCode
                Text(
                  'Pin Code',
                  style: TextStyle(
                    color: text500,
                    fontSize: body2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    controller: _pinCodeCtrl,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a pin code';
                      } else if (value.length > 6 || value.length < 6) {
                        return 'Pin code length should be 6';
                      }
                      int? pin = int.tryParse(value);
                      if (pin == null) {
                        return 'Enter a valid pin code';
                      }
                      return null;
                    },
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: accent2,
                    ),
                    decoration: getInputDecoration('123456'),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Builder(
        builder: (context) {
          if (_functionLifetime == FunctionLifetime.calling) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: accent2),
                  const SizedBox(width: 15),
                  Text(
                    'Adding Address Account',
                    style: TextStyle(
                        color: accent2,
                        fontWeight: FontWeight.w500,
                        fontSize: body1),
                  ),
                ],
              ),
            );
          } else {
            /// FunctionLifetime.initialize
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _functionLifetime = FunctionLifetime.calling;
                    });
                    await addUserAddressDetails();
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  minimumSize: const Size(double.infinity, 50.0),
                  maximumSize: const Size(double.infinity, 60.0),
                  backgroundColor: accent1,
                ),
                child: Text(
                  'Add Address',
                  style: TextStyle(
                    color: background,
                    fontSize: heading2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> addUserAddressDetails() async {
    // ADD USER ADDRESS DETAILS
    try {
      User? user = ref.read(userProvider)!;
      await GoldServices.addGoldUserAddress(
        user: user,
        email: _emailCtrl.text,
        name: _nameCtrl.text,
        address: _addressCtrl.text,
        pincode: int.parse(_pinCodeCtrl.text),
        phone: _phoneCtrl.text,
        state: '',
        city: '',
      ).then((response) async {
        if (response == null) {
          handleError();
          return;
        }
        await DatastoreServices.addUserAddress(rsp: response, userId: user.id)
            .then((value) {
          if (value == null) {
            handleError();
            return;
          }
          ref.read(userProvider.notifier).addUserAddress(address: value);
          handleSuccess();
        });
      });
    } catch (e) {
      handleError();
    }
  }

  void handleError() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: error,
        content: Text('Address Add Failed', style: TextStyle(color: text500)),
      ),
    );
    setState(() {
      _functionLifetime = FunctionLifetime.initialize;
    });
  }

  void handleSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: success,
        content: Text(
          'Address Added Successfully',
          style: TextStyle(
            color: text500,
          ),
        ),
      ),
    );
    setState(() {
      _functionLifetime = FunctionLifetime.success;
    });
    Navigator.pop(context);
  }
}
