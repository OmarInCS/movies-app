import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/constants/app_theme.dart';
import 'package:movies_app/providers/watch_list_provider.dart';
import 'package:movies_app/screens/main_screen.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  String? deviceId = await PlatformDeviceId.getDeviceId;

  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider<WatchListProvider>(create: (context) => WatchListProvider(deviceId ?? "shared"),),
          ],
          child: const MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: darkTheme,
      home: MainScreen(),
    );
  }
}
