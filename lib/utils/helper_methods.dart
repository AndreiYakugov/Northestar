import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:northstar_app/utils/app_colors.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

Future<void> launchMyUrl(Uri url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

void popNavigate(BuildContext context, Widget? screen) {
  if (screen != null) {
    Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(builder: (c) => screen));
  }
}

String formatDate(DateTime dateTime) {
  return DateFormat('MM-dd HH:mm').format(dateTime);
}
void showToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      fontSize: 16.0
  );
}
void showLoadingDialog(BuildContext context){
  AlertDialog alert = AlertDialog(
    content: new Row(
      children: [
        CircularProgressIndicator(valueColor:AlwaysStoppedAnimation<Color>(AppColors.primaryColor)),
        Container(
            margin: EdgeInsets.only(left: 5),
            child:Text("   Loading ...   ")
        ),
      ],
    ),
  );
  showDialog(barrierDismissible: false,
    context:context,
    builder:(BuildContext context) {
      return alert;
    },
  );
}
bool isValidPassword(String password) {
  const passwordPattern = r'^(?=.*[0-9])(?=.*[A-Z])(?=.*[@#$%^&+=!])(?=\S+$).{4,}$';
  final regex = RegExp(passwordPattern);
  return regex.hasMatch(password);
}
String getFormatedDate(String _date) {
  var tmpdate = DateTime.parse(_date);
  String yearShort = tmpdate.year.toString().substring(tmpdate.year.toString().length-2);
  return "${tmpdate.month}/${tmpdate.day}/$yearShort";
}
String earningsStatus(int status) {
  if (status == 1) {
    return "Pending";
  } else if (status == 2) {
    return "Paid";
  } else {
    return "Rejected";
  }
}
String contactStatus(int status) {
  if (status == 1) {
    return "Inactive";
  } else {
    return "Active";
  }
}
String getPhoneModel() {
  if(defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS) {
    return "no";
  }
  else {
    return "yes";
  }
}

String getDeviceName() {
  return "device_name";
}

String getDeviceModel() {
  return "device_model";
}

String? getDeviceToken() {
  return OneSignal.User.pushSubscription.token;
}
String? getSerialNumber() {
  String? serialNumber;

  try {
    var c = Process.runSync('getprop', ['gsm.sn1']);
    serialNumber = c.stdout.toString().trim();
    if (serialNumber.isEmpty) {
      c = Process.runSync('getprop', ['ril.serialnumber']);
      serialNumber = c.stdout.toString().trim();
    }
    if (serialNumber.isEmpty) {
      c = Process.runSync('getprop', ['ro.serialno']);
      serialNumber = c.stdout.toString().trim();
    }
    if (serialNumber.isEmpty) {
      c = Process.runSync('getprop', ['sys.serialnumber']);
      serialNumber = c.stdout.toString().trim();
    }
    if (serialNumber.isEmpty) {
      serialNumber = 'unknown';
    }

    if (serialNumber.isEmpty) {
      serialNumber = null;
    }
  } catch (e) {
    print(e);
    serialNumber = null;
  }
  return serialNumber;
}