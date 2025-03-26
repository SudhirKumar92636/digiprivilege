import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:membership/screens/auth/google_auth/google_auth_screen.dart';
import 'package:membership/screens/auth/phoneauth/phone_auth_screen.dart';
import 'package:membership/screens/razorypay/razory_pay.dart';
import 'package:membership/screens/splash_screen.dart';
import 'package:membership/utils/theme/appTheme.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'notificationservice/local_notification_service.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "urlife-6b1cc",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);

  //LocalNotificationService.initialize();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context , orientation , SizerUtil) {
          return  GetMaterialApp(
            debugShowCheckedModeBanner: false,
              home: const GoogleAuthScreens(),
           // home: const RazorpayScreen(),
           //home: GogleAuthScreens(),
            theme: appTheme(),
          );
        }
    );
  }
}