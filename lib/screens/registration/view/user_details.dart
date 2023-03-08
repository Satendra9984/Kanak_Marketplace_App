import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:tasvat/models/ModelProvider.dart';
import 'package:tasvat/providers/auth_provider.dart';
import 'package:tasvat/services/datastore_services.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/ui_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserDetailsPage extends ConsumerStatefulWidget {
  const UserDetailsPage({super.key});

  @override
  ConsumerState<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends ConsumerState<UserDetailsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fNameCtrl = TextEditingController();
  final TextEditingController _lNameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _pinCodeCtrl = TextEditingController();
  String? _state, _city;
  DateTime? _dob;

  final List<String> _statesList = states;
  final List<String> _cityList = [];

  @override
  void initState() {
    _emailCtrl.text = ref.read(authProvider).email!;
    _dob = getEndDate();
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
                    'User Details',
                    style: TextStyle(
                      color: text500,
                      fontSize: title,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                /// Name
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'First Name',
                            style: TextStyle(
                              color: text500,
                              fontSize: body2,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              // color: text150,
                            ),
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.name,
                              controller: _fNameCtrl,
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
                              decoration:
                                  getInputDecoration('First Name').copyWith(
                                errorStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: error,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Last Name',
                            style: TextStyle(
                              color: text500,
                              fontSize: body2,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              // color: text150,
                            ),
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.name,
                              controller: _lNameCtrl,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter your Last Name';
                                } else if (value.length > 20) {
                                  return 'Less than 20 letters';
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
                              decoration:
                                  getInputDecoration('Last Name').copyWith(
                                errorStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: error,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
                                _dob == null ? 'yyyy-mm-dd' : _dob!.toIso8601String().split('T')[0],
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
                const SizedBox(height: 10)
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
