import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    //_askPermissions();
  }

  // Future<void> _askPermissions() async {
  //   PermissionStatus permissionStatus = await _getContactPermission();
  //   if (permissionStatus != PermissionStatus.granted) {
  //     _handleInvalidPermissions(permissionStatus);
  //   }
  // }
  //
  // Future<PermissionStatus> _getContactPermission() async
  // {
  //   PermissionStatus permission = await PermissionHandler()
  //       .checkPermissionStatus(PermissionGroup.contacts);
  //   if (permission != PermissionStatus.granted &&
  //       permission != PermissionStatus.disabled) {
  //     Map<PermissionGroup, PermissionStatus> permissionStatus =
  //     await PermissionHandler()
  //         .requestPermissions([PermissionGroup.contacts]);
  //     return permissionStatus[PermissionGroup.contacts] ??
  //         PermissionStatus.unknown;
  //   } else {
  //     return permission;
  //   }
  // }
  //
  // void _handleInvalidPermissions(PermissionStatus permissionStatus) {
  //   if (permissionStatus == PermissionStatus.denied) {
  //     throw PlatformException(
  //         code: "PERMISSION_DENIED",
  //         message: "Access to location data denied",
  //         details: null);
  //   } else if (permissionStatus == PermissionStatus.disabled) {
  //     throw PlatformException(
  //         code: "PERMISSION_DISABLED",
  //         message: "Location data is not available on device",
  //         details: null);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contacts Plugin Example')),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            RaisedButton(
              child: const Text('Contacts list'),
              onPressed: () => Navigator.pushNamed(context, '/contactsList'),
            ),
            RaisedButton(
              child: const Text('Native Contacts picker'),
              onPressed: () =>
                  Navigator.pushNamed(context, '/nativeContactPicker'),
            ),
          ],
        ),
      ),
    );
  }
}