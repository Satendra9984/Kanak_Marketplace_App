import 'dart:convert';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:tasvat/providers/user_provider.dart';
import 'package:tasvat/services/datastore_services.dart';
import 'package:tasvat/services/gold_services.dart';
import 'package:tasvat/services/rest_services.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/ui_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'city_widget.dart';

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
  List<Map<dynamic, dynamic>> _statesList = [];

  Map<dynamic, dynamic>? _state, _city;

  Future<void> _initializeStatesList() async {
    if (_statesList.isEmpty) {
      // List<Map<dynamic, dynamic>> states =
      //     await GoldServices.getStateCityList('state');
      // debugPrint(states.toString());
      // setState(() {
      //   _statesList = states;
      // });
    } else {
      return;
    }
  }

  @override
  void initState() {
    _initializeStatesList();
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
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
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
                            padding: const EdgeInsets.only(left: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: text100,
                            ),
                            child: FutureBuilder(
                                future: _initializeStatesList(),
                                builder: (context, snap) {
                                  if (snap.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(
                                          color: accent2),
                                    );
                                  } else if (snap.hasData) {
                                    return DropdownButton<
                                        Map<dynamic, dynamic>>(
                                      hint: Text(
                                        'Delhi',
                                        style: TextStyle(
                                          color: accentBG,
                                        ),
                                      ),
                                      value: _state == null || _state!.isEmpty
                                          ? null
                                          : _state,
                                      items: _statesList.map((state) {
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
                                        });
                                      },
                                      menuMaxHeight: 400,
                                      underline: Container(),
                                      dropdownColor: text150,
                                      isExpanded: true,
                                      borderRadius: BorderRadius.circular(10),
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: accent2,
                                      ),
                                    );
                                  } else {
                                    return const Center(
                                        child: Text('Something Went Wrong'));
                                  }
                                }),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
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
                            padding: const EdgeInsets.only(left: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: text100,
                            ),
                            child: _state != null
                                ? CityWidget(
                                    state: _state!['id'],
                                    onCitySelected: (city) {
                                      _city = city['id'];
                                    },
                                  )
                                : DropdownButton(
                                    hint: Text(
                                      'New Delhi',
                                      style: TextStyle(
                                        color: accentBG,
                                      ),
                                    ),
                                    value: null,
                                    items: null,
                                    onChanged: (value) {},
                                    menuMaxHeight: 400,
                                    underline: Container(),
                                    dropdownColor: text150,
                                    isExpanded: true,
                                    borderRadius: BorderRadius.circular(10),
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: text100,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
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
}
