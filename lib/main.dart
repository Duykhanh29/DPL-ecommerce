import 'package:dpl_ecommerce/app_obsever.dart';
import 'package:dpl_ecommerce/models/voucher_for_user.dart';
import 'package:dpl_ecommerce/view_model/consumer/cart_view_model.dart';
import 'package:dpl_ecommerce/view_model/consumer/chat_view_model.dart';
import 'package:dpl_ecommerce/view_model/consumer/language_view_model.dart';
import 'package:dpl_ecommerce/view_model/consumer/product_detail_view_model.dart';
import 'package:dpl_ecommerce/view_model/consumer/product_view_model.dart';
import 'package:dpl_ecommerce/view_model/consumer/voucher_for_user_view_model.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:dpl_ecommerce/views/consumer/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(AppLifeCycleObsever());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(AppLifeCycleObsever());
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => UserViewModel(),
            ),
            ChangeNotifierProvider(
              create: (context) => LanguageViewModel(),
            ),
            ChangeNotifierProvider(
              create: (context) => CartViewModel(),
            ),
            ChangeNotifierProvider(
              create: (context) => ProductDetailViewModel(),
            ),
            ChangeNotifierProvider(
              create: (context) => VoucherForUserViewModel(),
            ),
            ChangeNotifierProvider(
              create: (context) => ChatViewModel(),
            ),
            ChangeNotifierProvider(
              create: (context) => ProductViewModel(),
            )
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "DPL Ecommerce",
            home: MainView(),
          ),
        );
      },
    );
  }
}
