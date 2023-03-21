import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasvat/services/rest_services.dart';

import '../../../utils/app_constants.dart';

class CityWidget extends StatefulWidget {
  final String state;
  final Function(Map<dynamic, dynamic> city) onCitySelected;
  const CityWidget({
    Key? key,
    required this.state,
    required this.onCitySelected,
  }) : super(key: key);

  @override
  State<CityWidget> createState() => _CityWidgetState();
}

class _CityWidgetState extends State<CityWidget> {
  String? _city;
  Future<List<Map<dynamic, dynamic>>?> getCitiesList() async {
    // TODO: GET CITIES LIST
    try {} catch (e) {
      rethrow;
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCitiesList(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: accent2),
          );
        } else if (snap.hasData) {
          List<Map<dynamic, dynamic>> cityList = snap.data!;

          return DropdownButton<String>(
            hint: Text(
              'New Delhi',
              style: TextStyle(
                color: accentBG,
              ),
            ),
            value: _city,
            items: cityList.map((city) {
              return DropdownMenuItem<String>(
                value: city['id'],
                child: Text(
                  city['name'],
                  style: TextStyle(color: accent2),
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _city = value;
              });
              //widget.onCitySelected(_city!);
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
          return const Center(child: Text('Something Went Wrong'));
        }
      },
    );
  }
}
