import 'package:cp77_gpm_ui/util/CurrentRouteProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Settings'),
          RaisedButton(
            child: Text('Exit'),
            onPressed: () {
              Navigator.pop(context);
              context.read<CurrentRouteProvider>().route = '';
            },
          ),
        ],
      ),
    );
  }
}
