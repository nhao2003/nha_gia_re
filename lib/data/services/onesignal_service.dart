import 'package:nha_gia_re/core/values/api_values.dart';
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