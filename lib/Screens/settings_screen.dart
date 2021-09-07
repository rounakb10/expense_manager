import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:theme_provider/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  //String _dropDownValue;
  @override
  Widget build(BuildContext context) {
    String id = ThemeProvider.controllerOf(context).currentThemeId;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '\tSettings',
          style: TextStyle(fontSize: 24),
        ),
        // centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 18),
        children: [
          ListTile(
            leading: Icon(Icons.brightness_4),
            title: Text('Enable Dark Mode'),
            trailing: Switch(
              value: id == 'actual_light' ? false : true,
              onChanged: (value) {
                if (value)
                  ThemeProvider.controllerOf(context).setTheme("actual_dark");
                else
                  ThemeProvider.controllerOf(context).setTheme("actual_light");
              },
            ),
          ),
          // ListTile(
          //   leading: Icon(Icons.attach_money),
          //   title: Text('Change currency'),
          //   trailing: DropdownButton<String>(
          //     items: <String>['\$', '₹', '€', '£', '¥'].map((String value) {
          //       return DropdownMenuItem<String>(
          //         value: value,
          //         child: Text(value),
          //       );
          //     }).toList(),
          //     hint: _dropDownValue == null
          //         ? Text('₹')
          //         : Text(
          //             _dropDownValue,
          //             style: TextStyle(color: Colors.blue),
          //           ),
          //     onChanged: (val) {
          //       setState(() {
          //         _dropDownValue = val;
          //       });
          //     },
          //     iconEnabledColor: Colors.white,
          //   ),
          // ),
          SizedBox(
            height: 56,
          ),
          Divider(),
          ListTile(
            title: Text(' Delete all data'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                return showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Delete all data?'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Text('This action cannot be reversed'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        MaterialButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        MaterialButton(
                          onPressed: () {
                            Hive.box('expense').clear();
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'OK',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
