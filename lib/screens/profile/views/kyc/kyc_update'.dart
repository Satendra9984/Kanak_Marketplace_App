import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasvat/providers/auth_provider.dart';

import '../../../../utils/app_constants.dart';
import '../../../../utils/ui_functions.dart';
import '../../../../widgets/image_upload_widget.dart';

class UpdateUserKYCPage extends ConsumerStatefulWidget {
  const UpdateUserKYCPage({super.key});

  @override
  ConsumerState<UpdateUserKYCPage> createState() => _UserKYCPageState();
}

class _UserKYCPageState extends ConsumerState<UpdateUserKYCPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _panCtrl = TextEditingController();
  final TextEditingController _nameCtrl = TextEditingController();
  DateTime? _dob;
  DateTime getEndDate() {
    DateTime today = DateTime.now();
    DateTime endDate = DateTime(
      today.year - 18,
      today.month,
      today.day,
      today.hour,
      today.minute,
      today.second,
      today.millisecond,
      today.microsecond,
    );
    return endDate;
  }

  DateTime getFirstDate() {
    DateTime today = DateTime.now();
    DateTime endDate = DateTime(
      today.year - 130,
      today.month,
      today.day,
      today.hour,
      today.minute,
      today.second,
      today.millisecond,
      today.microsecond,
    );
    return endDate;
  }

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
    _dob = getEndDate();
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

                /// name
                Text(
                  'First Name',
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
                const SizedBox(height: 20),

                /// date of birth
                Text(
                  'Date of Birth',
                  style: TextStyle(
                    color: text500,
                    fontSize: body2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                FormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  initialValue: _dob,
                  validator: (dob) {
                    debugPrint(dob.toString());
                    if (dob == null) {
                      return 'Please enter Date of Birth';
                    }
                    return null;
                  },
                  builder: (formState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 0),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: text100,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _dob == null
                                    ? 'yyyy-mm-dd'
                                    : _dob!.toIso8601String().split('T')[0],
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: _dob == null ? accentBG : accent2,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  await showDatePicker(
                                    context: context,
                                    initialDate: getEndDate(),
                                    firstDate: getFirstDate(),
                                    lastDate: getEndDate(),
                                  ).then((value) {
                                    if (value != null) {
                                      setState(() {
                                        _dob = value;
                                      });
                                      // debugPrint(_dob);
                                      formState.didChange(_dob);
                                    }
                                  });
                                },
                                icon: Icon(
                                  Icons.date_range,
                                  color: accent2.withOpacity(0.7),
                                  size: 32,
                                ),
                              ),
                            ],
                          ),
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
                const SizedBox(height: 10),

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
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
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
                'Update KYC',
                style: TextStyle(
                  color: background,
                  fontSize: heading2,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          /// skip button
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Skip for now',
                style: TextStyle(
                  color: accent2,
                  fontSize: 16,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
