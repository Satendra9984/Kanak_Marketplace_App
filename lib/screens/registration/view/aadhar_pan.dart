import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/ui_functions.dart';

class UserKYCPage extends StatefulWidget {
  const UserKYCPage({super.key});

  @override
  State<UserKYCPage> createState() => _UserKYCPageState();
}

class _UserKYCPageState extends State<UserKYCPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _aadharCtrl = TextEditingController();
  final TextEditingController _panCtrl = TextEditingController();

  Future<void> _pickImages() async {
    await ImagePicker().pickImage(source: ImageSource.gallery).then(
          (XFile? pickedImage) {},
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          alignment: Alignment.center,
          child: SingleChildScrollView(
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
                Text(
                  'Aadhar',
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
                    controller: _aadharCtrl,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Aadhar number';
                      }
                      bool aadharValid =
                          RegExp(r'^[2-9]{1}[0-9]{3}[0-9]{4}[0-9]{4}$')
                              .hasMatch(value);

                      if (!aadharValid) {
                        return 'Please enter valid Aadhar number';
                      }
                      return null;
                    },
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: accent2,
                    ),
                    decoration: getInputDecoration('123412341234'),
                  ),
                ),

                const SizedBox(height: 10),

                /// Aadhar Card Image
                DottedBorder(
                  dashPattern: const [10, 1],
                  strokeCap: StrokeCap.butt,
                  strokeWidth: 1.0,
                  radius: const Radius.circular(10),
                  color: accent2,
                  child: GestureDetector(
                    onTap: () async {
                      await _pickImages();
                    },
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image,
                            color: accent2,
                            size: 32,
                          ),
                          const SizedBox(width: 15),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 5),
                              Text(
                                'Add your Aadhar Card image',
                                style: TextStyle(
                                  color: text400,
                                  fontSize: body2,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'supports: JPG, JPEG, PNG',
                                style: TextStyle(
                                  color: text300,
                                  fontSize: caption,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// Pan Number
                Text(
                  'Pan',
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
                DottedBorder(
                  dashPattern: const [10, 1],
                  strokeCap: StrokeCap.butt,
                  strokeWidth: 1.0,
                  radius: const Radius.circular(10),
                  color: accent2,
                  child: Container(
                    width: double.infinity,
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image,
                          color: accent2,
                          size: 32,
                        ),
                        const SizedBox(width: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 5),
                            Text(
                              'Add your Pan Card image',
                              style: TextStyle(
                                color: text400,
                                fontSize: body2,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'supports: JPG, JPEG, PNG',
                              style: TextStyle(
                                color: text300,
                                fontSize: caption,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
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
        ],
      ),
    );
  }
}
