import 'dart:convert';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:tasvat/providers/user_provider.dart';
import 'package:tasvat/services/datastore_services.dart';
import 'package:tasvat/services/gold_services.dart';
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
  final TextEditingController _pinCodeCtrl = TextEditingController();
  final TextEditingController _addressCtrl = TextEditingController();
  final TextEditingController _stateCtrl = TextEditingController();
  final TextEditingController _cityCtrl = TextEditingController();
  List<Map<dynamic, dynamic>>? _statesList;
  List<Map<dynamic, dynamic>> _citiesList = [];

  Map<dynamic, dynamic>? _state, _stateId, _city, _cityId;
  Future<void> getCitiesList() async {
    debugPrint(_citiesList.toString());
    try {
      if (_state == null) {
        await GoldServices.getCityList(_state!['id']).then((value) {
          //List<Map<dynamic, dynamic>> cityList = [];
          _citiesList = [];
          for (var city in value) {
            Map<dynamic, dynamic> cityMap = Map.from(city);
            _citiesList.add(cityMap);
          }
          setState(() {
            _citiesList;
          });
          debugPrint('citiesList: $_state');
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _initializeStatesList() async {
    try {
      if (_statesList == null) {
        List<dynamic> states = await GoldServices.getStateCityList();
        _statesList = [];
        for (var element in states) {
          Map<dynamic, dynamic> state = Map.from(element);
          _statesList!.add(state);
        }
        await getCitiesList();
        setState(() {
          _statesList;
        });
        debugPrint(_statesList.toString());
      }
    } catch (e) {
      _statesList = [];
    }
  }

  @override
  void initState() {
    // _initializeStatesList();
    super.initState();
  }

  // flow | registerGoldUser > updateGPDetails > addGoldUserAddress > addUserAddress > provider
  Future<void> _createGoldUserWithAddress() async {
    final authData = await Amplify.Auth.getCurrentUser();
    final user = ref.read(userProvider);
    await GoldServices.registerGoldUser(
            phone: authData.username.substring(3),
            email: user!.email!,
            userId: authData.userId,
            name: '${user.fname!} ${user.lname!}',
            pincode: _pinCodeCtrl.text,
            dob: user.dob!.getDateTime().toIso8601String().split('T')[0])
        .then((goldUser) async {
      if (goldUser == null) {
        return;
      }
      await DatastoreServices.updateGPDetails(user: user, details: goldUser)
          .then((updatedUser) async {
        if (updatedUser == null) {
          return;
        }
        ref.read(userProvider.notifier).updateUserDetails(
            gpDetails: jsonDecode(updatedUser.goldProviderDetails!));
        await GoldServices.addGoldUserAddress(
                user: user,
                name: 'primary',
                address: _addressCtrl.text,
                pincode: int.parse(_pinCodeCtrl.text),
                //TODO: Add state and city controller with dropdown
                state: 'state',
                city: 'city')
            .then((rsp) async {
          if (rsp == null) {
            return;
          }
          await DatastoreServices.addUserAddress(rsp: rsp).then((addr) {
            if (addr == null) {
              return;
            }
            ref.read(userProvider.notifier).addUserAddress(address: addr);
          });
        });
      });
    });
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

                /// state and city
                Text(
                  'State',
                  style: TextStyle(
                    color: text500,
                    fontSize: body2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 5),
                FormField(
                  initialValue: _state,
                  validator: (state) {
                    if (state == null) {
                      return 'Select State';
                    }
                    return null;
                  },
                  builder: (formState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: text100,
                          ),
                          child: FutureBuilder(
                            future: _initializeStatesList(),
                            builder: (context, snap) {
                              if (snap.connectionState ==
                                      ConnectionState.waiting ||
                                  snap.hasError == false) {
                                return DropdownButton<Map<dynamic, dynamic>>(
                                  hint: Text(
                                    'Delhi',
                                    style: TextStyle(
                                      color: accentBG,
                                    ),
                                  ),
                                  value: _state == null || _state!.isEmpty
                                      ? null
                                      : _state,
                                  items: _statesList == null
                                      ? []
                                      : _statesList!.map((state) {
                                          return DropdownMenuItem(
                                            value: state,
                                            child: Text(
                                              state['name'],
                                              style: TextStyle(color: accent2),
                                            ),
                                          );
                                        }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _state = value;
                                      _city = null;
                                      _citiesList = [];
                                      debugPrint(_state.toString());
                                    });
                                    getCitiesList();
                                  },
                                  menuMaxHeight: 400,
                                  underline: Container(),
                                  dropdownColor: text150,
                                  isExpanded: true,
                                  borderRadius: BorderRadius.circular(10),
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color:
                                        _statesList != null ? accent2 : text100,
                                  ),
                                );
                              } else {
                                return Container(
                                  height: 45,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: text100,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Something Went Wrong',
                                    style: TextStyle(color: error),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        if (formState.hasError)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
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

                const SizedBox(height: 25),
                Text(
                  'City',
                  style: TextStyle(
                    color: text500,
                    fontSize: body2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 5),
                FormField(
                  initialValue: _city,
                  validator: (city) {
                    if (_state == null) {
                      return 'First Select State';
                    } else if (city == null) {
                      return 'Select City';
                    }
                    return null;
                  },
                  builder: (formState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: text100,
                          ),
                          child: DropdownButton<Map<dynamic, dynamic>>(
                            hint: Text(
                              'New Delhi',
                              style: TextStyle(
                                color: accentBG,
                              ),
                            ),
                            value: _city != null ? _city! : null,
                            items: _citiesList.map((city) {
                              return DropdownMenuItem<Map<dynamic, dynamic>>(
                                value: city,
                                child: Text(
                                  city['name'],
                                  style: TextStyle(color: accent2),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  _city = value;
                                });
                              }
                            },
                            menuMaxHeight: 400,
                            underline: Container(),
                            dropdownColor: text150,
                            isExpanded: true,
                            borderRadius: BorderRadius.circular(10),
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: _citiesList.isNotEmpty ? accent2 : text100,
                            ),
                          ),
                        ),
                        if (formState.hasError)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
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
      bottomNavigationBar: Container(
        color: background,
        child: Container(
          // color: success,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                await _createGoldUserWithAddress();
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

  Future<void> req() async {}
}
