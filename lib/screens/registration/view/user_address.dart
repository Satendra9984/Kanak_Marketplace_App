import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:tasvat/models/ModelProvider.dart';
import 'package:tasvat/services/datastore_services.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/ui_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserAddressPage extends ConsumerStatefulWidget {
  final String? email;
  const UserAddressPage({super.key, this.email});

  @override
  ConsumerState<UserAddressPage> createState() => _UserAddressPageState();
}

class _UserAddressPageState extends ConsumerState<UserAddressPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fNameCtrl = TextEditingController();
  final TextEditingController _lNameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _pinCodeCtrl = TextEditingController();
  final TextEditingController _addressCtrl = TextEditingController();
  DateTime? _dob;

  final List<String> _statesList = states;
  final List<String> _cityList = [];

  @override
  void initState() {
    _dob = getEndDate();
    if (widget.email != null) {
      _emailCtrl.text = widget.email!;
    }
    _setList();
    super.initState();
  }

  void _setList() {
    _statesList.sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));

    List<String> list =
        stateCities.map((element) => element['name'].toString()).toList();
    _cityList.addAll(list);
    _cityList.sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
  }

  void filterCitiesWithState(String state) {
    List<Map<String, dynamic>> list = stateCities.where((element) {
      return element['state'].toString().toLowerCase() == state.toLowerCase();
    }).toList();

    _cityList.clear();
    _cityList.addAll(list.map((e) => e['name']));
    _cityList.sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
    if (_cityList.isEmpty) {
      _cityList.add(state);
    }
    debugPrint(_cityList.toString());
  }

  Future<void> _createUserAccount() async {
    final authData = await Amplify.Auth.getCurrentUser();
    await DatastoreServices.addUserDetails(
      email: _emailCtrl.text,
      phone: authData.username,
      pincode: int.parse(_pinCodeCtrl.text),
      dob: _dob!.toIso8601String().split('T')[0],
      userId: authData.userId,
      fname: _fNameCtrl.text,
      lname: _lNameCtrl.text
    ).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Successfully added your details!'))
      );
    }).catchError((err) {
      print(err);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(err.toString()))
      );
    });
  }

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
                    'User Address',
                    style: TextStyle(
                      color: text500,
                      fontSize: title,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
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
                        '11-6-323, Goods Shed Road, Nampally'),
                  ),
                ),
                const SizedBox(height: 10),

                /// pincode
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

                /// state and city
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: background,
        child: Container(
          // color: success,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                await _createUserAccount();
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
              'Submit',
              style: TextStyle(
                color: background,
                fontSize: heading2,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}