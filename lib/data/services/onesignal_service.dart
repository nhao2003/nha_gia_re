import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/core/values/api_values.dart';
import 'package:nha_gia_re/routers/app_routes.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalService {
  static void init()
  {
    //Remove this method to stop OneSignal Debugging 
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.setAppId(ONESIGNAL_APP_ID);

    // The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
        print("Accepted permission: $accepted");
    });

    

    OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {
    // Retrieve the notification payload
    OSNotification notification = result.notification;

    debugPrint("testing ");
    // Extract notification data
    Map<String, dynamic>? additionalData = notification.additionalData;
    if (additionalData != null) {
      // Access the notification data fields
      String uid = additionalData['uid'];
      Get.toNamed(AppRoutes.chat, arguments: uid);
      debugPrint("testing " + uid);
      // ...
      
      // Perform actions based on the notification data
      // ...
    }

    // Additional handling logic when a notification is opened
    // ...
  });

  }
  static void addExternalId(String externalUserId)
  {
    // Setting External User Id with Callback Available in SDK Version 3.9.3+
    OneSignal.shared.setExternalUserId(externalUserId).then((results) {
      print(results.toString());
    }).catchError((error) {
      print(error.toString());
    });
  }
  static void removeExternalId()
  {
    OneSignal.shared.removeExternalUserId();
  }
}