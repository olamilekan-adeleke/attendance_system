import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  final List<String> dropDownList;
  final ValueNotifier<String> dropDownValue;
  final String title;

  const CustomDropDown({this.dropDownList, this.dropDownValue, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: ValueListenableBuilder<String>(
        valueListenable: dropDownValue,
        builder: (_, String val, child) {
          return DropdownButton<String>(
            value: val,
            hint: Text('Please Select $title'),
            isExpanded: true,
            items: dropDownList.toList().map((String value) {
              return DropdownMenuItem(
                value: value,
                child: Text('$value'),
              );
            }).toList(),
            onChanged: (val) => dropDownValue.value = val,
          );
        },
      ),
    );
  }
}
