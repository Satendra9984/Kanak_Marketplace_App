import 'dart:io';
import 'dart:typed_data';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tasvat/providers/auth_provider.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/ui_functions.dart';
import '../../../widgets/image_upload_widget.dart';

class UserKYCPage extends ConsumerStatefulWidget {
  const UserKYCPage({super.key});

  @override
  ConsumerState<UserKYCPage> createState() => _UserKYCPageState();
}

class _UserKYCPageState extends ConsumerState<UserKYCPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _panCtrl = TextEditingController();
  XFile? _image;

  Future<void> _uploadPanCardImage() async {
    try {} catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _uploadAadharCardImage() async {
    try {} catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider);
    return Scaffold(
      backgroundColor: background,
      body: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// KYC text
                Align(
                  child: Text(
                    'KYC Details',
                    style: TextStyle(
                      color: text500,
                      fontSize: title,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                /// Aadhar number
                // Text(
                //   'Aadhar',
                //   style: TextStyle(
                //     color: text500,
                //     fontSize: body2,
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
                // Container(
                //   margin:
                //       const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                //   child: TextFormField(
                //     autovalidateMode: AutovalidateMode.onUserInteraction,
                //     keyboardType: TextInputType.number,
                //     controller: _aadharCtrl,
                //     validator: (value) {
                //       if (value == null || value.isEmpty) {
                //         return 'Please enter Aadhar number';
                //       }
                //       bool aadharValid =
                //           RegExp(r'^[2-9]{1}[0-9]{3}[0-9]{4}[0-9]{4}$')
                //               .hasMatch(value);
                //
                //       if (!aadharValid) {
                //         return 'Please enter valid Aadhar number';
                //       }
                //       return null;
                //     },
                //     style: TextStyle(
                //       fontSize: 16,
                //       fontWeight: FontWeight.w500,
                //       color: accent2,
                //     ),
                //     decoration: getInputDecoration('123412341234'),
                //   ),
                // ),
                // const SizedBox(height: 10),
                /// Aadhar Card Image
                // ImageUploadButtonWidget(
                //   uploadPath: 'tasvatusercontent/aadhar/${user.id}',
                //   title: 'Aadhar',
                // ),

                const SizedBox(height: 20),

                /// Pan Number
                Text(
                  'Pan Number',
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
                    keyboardType: TextInputType.text,
                    controller: _panCtrl,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Pan Number';
                      } else {
                        bool emailValid =
                            RegExp(r"[A-Z]{5}[0-9]{4}[A-Z]{1}").hasMatch(value);
                        if (!emailValid) {
                          return 'Please Enter a valid Pan number';
                        }
                      }

                      return null;
                    },
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: accent2,
                    ),
                    decoration: getInputDecoration('ABCTY1234D'),
                  ),
                ),
                const SizedBox(height: 10),

                /// Pan Card image
                FormField(
                  initialValue: _image,
                  validator: (image) {
                    if (image == null) {
                      return 'Please Upload Pan Card';
                    }
                    return null;
                  },
                  builder: (formState) {
                    return Column(
                      children: [
                        ImageUploadButtonWidget(
                          uploadPath: 'tasvatusercontent/pan/${user.id}',
                          title: 'Pan',
                          onUploaded: (image) {
                            if (image != null) {
                              setState(() {
                                _image = image;
                                debugPrint('image uploaded');
                              });
                            }
                          },
                        ),
                        if (formState.hasError)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              formState.errorText.toString(),
                              style: TextStyle(
                                color: error,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Confirm BUTTON
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  // todo: complete KYC
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
                'Complete KYC',
                style: TextStyle(
                  color: background,
                  fontSize: heading2,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          // Container(
          //   margin: const EdgeInsets.only(top: 5),
          //   child: TextButton(
          //     onPressed: () {},
          //     child: Text(
          //       'Skip for now',
          //       style: TextStyle(
          //         color: accent2,
          //         fontSize: 16,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}