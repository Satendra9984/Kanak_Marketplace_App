import 'package:flutter/material.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/ui_functions.dart';

class UserAddressPage extends StatefulWidget {
  const UserAddressPage({super.key});

  @override
  State<UserAddressPage> createState() => _UserAddressPageState();
}

class _UserAddressPageState extends State<UserAddressPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // bool _showPassword = false;
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _pinCodeCtrl = TextEditingController();
  final TextEditingController _addressCtrl = TextEditingController();
  final TextEditingController _stateCtrl = TextEditingController();
  final TextEditingController _cityCtrl = TextEditingController();
  String? _state, _city;

  final List<String> _statesList = states;
  final List<String> _cityList = [];

  @override
  void initState() {
    // TODO: implement initState

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

  void fileterCitiesWithState(String state) {
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
                        return 'Please enter your Name';
                      } else if (value.length > 50) {
                        return 'Name should be less than 50 characters';
                      } else if (value.length < 2) {
                        return 'Name should be greater than 2 characters';
                      }
                      return null;
                    },
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: accent2,
                    ),
                    decoration: getInputDecoration('Name'),
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
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // STATE SELECTION
                    FormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      initialValue: _state,
                      validator: (state) {
                        if (state == null || state.isEmpty) {
                          return 'Please select your state';
                        }
                        return null;
                      },
                      builder: (formState) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'State',
                              style: TextStyle(
                                color: text500,
                                fontSize: body2,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 0),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: text100,
                              ),
                              child: DropdownButton(
                                value: _state != '' ? _state : null,
                                hint: Text(
                                  'Delhi',
                                  style: TextStyle(
                                    color: accentBG,
                                    fontSize: body1,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                items: _statesList
                                    .map<DropdownMenuItem<String>>((state) {
                                  return DropdownMenuItem(
                                    value: state,
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      state,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    setState(() {
                                      _state = value;
                                      fileterCitiesWithState(value);
                                    });
                                  }
                                  formState.didChange(_state);
                                },
                                // isDense: true,
                                isExpanded: true,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: accent2,
                                ),
                                dropdownColor: text100,
                                menuMaxHeight: 500,
                                iconSize: 32,
                                borderRadius: BorderRadius.circular(10),
                                underline: Container(),
                                alignment: AlignmentDirectional.centerStart,
                              ),
                            ),
                            if (formState.hasError)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  formState.errorText.toString(),
                                  style: TextStyle(
                                    color: error,
                                    fontSize: body2,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                    // TODO: CITY SELECTION
                    Expanded(
                      child: FormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        initialValue: _city,
                        validator: (city) {
                          if (city == null || city.isEmpty) {
                            return 'Please select your city';
                          } else if (_state == null) {
                            return 'Select your state first';
                          }
                          return null;
                        },
                        builder: (formState) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'City',
                                style: TextStyle(
                                  color: text500,
                                  fontSize: body2,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: text100,
                                ),
                                child: DropdownButton(
                                  value: _city != '' ? _city : null,
                                  hint: Text(
                                    'New Delhi',
                                    style: TextStyle(
                                      color: accentBG,
                                      fontSize: body1,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  items: _cityList
                                      .map<DropdownMenuItem<String>>((city) {
                                    return DropdownMenuItem(
                                      value: city,
                                      alignment: Alignment.centerRight,
                                      child: Text(city),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    if (value != null && _state != null) {
                                      setState(() {
                                        _city = value;
                                      });
                                    }
                                    formState.didChange(_city);
                                  },
                                  isExpanded: true,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: accent2,
                                  ),
                                  dropdownColor: text100,
                                  menuMaxHeight: 500,
                                  iconSize: 32,
                                  borderRadius: BorderRadius.circular(10),
                                  underline: Container(),
                                ),
                              ),
                              if (formState.hasError)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Text(
                                    formState.errorText.toString(),
                                    style: TextStyle(
                                      color: error,
                                      fontSize: body2,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Bank Details Submit Button
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await submitUserAddressDetails();
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
        ],
      ),
    );
  }

  Future<void> submitUserAddressDetails() async {
    // TODO: SUBMIT USER ADDRESS DETAILS
  }
}
