import 'package:dpl_ecommerce/app_obsever.dart';
import 'package:dpl_ecommerce/lang_config.dart';
import 'package:dpl_ecommerce/models/user.dart' as userModel;
import 'package:dpl_ecommerce/models/voucher_for_user.dart';
import 'package:dpl_ecommerce/view_model/auth_view_model.dart';
import 'package:dpl_ecommerce/view_model/consumer/cart_view_model.dart';
import 'package:dpl_ecommerce/view_model/consumer/chat_view_model.dart';
import 'package:dpl_ecommerce/view_model/consumer/language_view_model.dart';
import 'package:dpl_ecommerce/view_model/consumer/product_detail_view_model.dart';
import 'package:dpl_ecommerce/view_model/consumer/product_view_model.dart';
import 'package:dpl_ecommerce/view_model/consumer/review_view_model.dart';
import 'package:dpl_ecommerce/view_model/consumer/voucher_for_user_view_model.dart';
import 'package:dpl_ecommerce/view_model/lang_view_model.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:dpl_ecommerce/views/consumer/main_view.dart';
import 'package:dpl_ecommerce/views/consumer/routes/routes.dart';
import 'package:dpl_ecommerce/views/consumer/screens/login_screen.dart';
import 'package:dpl_ecommerce/views/general_views/register_seller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'firebase_options.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
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
    // WidgetsBinding.instance.addObserver(AppLifeCycleObsever());
  }

  @override
  void dispose() {
    // WidgetsBinding.instance.removeObserver(AppLifeCycleObsever());
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      child: Consumer<LocaleProvider>(
        builder: (context, value, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "DPL Ecommerce",
          home: RootWidget(),
          localizationsDelegates: [
            AppLocalizations.delegate, // Add this line
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          locale: value.locale,
        ),
      ),
    );
  }
}

class RootWidget extends StatelessWidget {
  const RootWidget({
    super.key,
  });

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
              create: (context) => AuthViewModel(),
            ),
            ChangeNotifierProvider(
              create: (context) =>
                  UserViewModel(Provider.of<AuthViewModel>(context)),
            )
          ],
          child: FirstPage(),
        );
      },
    );
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  auth.User? user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    super.initState();
    // final authProvider = Provider.of<AuthViewModel>(context);
    auth.FirebaseAuth.instance.authStateChanges().listen((event) {
      setState(() {
        user = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // print("WTH are you doing");
    // final authProvider = Provider.of<AuthViewModel>(context);
    // final auth = FirebaseAuth.instance;
    // return StreamBuilder(
    //   initialData: authProvider.user,
    //   stream: auth.authStateChanges(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.active) {
    //       if (snapshot.data != null) {
    //         return AuthorizatedPage();
    //       } else {
    //         return LoginScreen();
    //       }
    //     } else {
    //       return const Scaffold(
    //         body: Center(
    //           child: CircularProgressIndicator(),
    //         ),
    //       );
    //     }
    //   },
    // );
    return user != null ? AuthorizatedPage() : LoginScreen();
  }
}

class AuthorizatedPage extends StatefulWidget {
  const AuthorizatedPage({super.key});

  @override
  State<AuthorizatedPage> createState() => _AuthorizatedPageState();
}

class _AuthorizatedPageState extends State<AuthorizatedPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(builder: (context, authProvider, child) {
      if (authProvider.userModel != null) {
        return authProvider.userModel!.role == userModel.Role.consumer
            ? const AuthPage()
            : const TestScreen();
      } else {
        return Scaffold(
          body: Center(
            child: Text("Waiting ..."),
          ),
        );
      }
    });
  }
}

class AuthPage extends StatelessWidget {
  const AuthPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthViewModel>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserViewModel(authProvider),
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
          create: (context) => VoucherForUserViewModel(authProvider),
        ),
        ChangeNotifierProvider(
          create: (context) => ChatViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ReviewViewModel(),
        )
      ],
      child: MaterialApp(
        // home: MainView(),
        initialRoute: ConsumerRoutes.mainView,
        routes: ConsumerRoutes.routes,
      ),
    );
  }
}

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text("Data"),
        ),
      ),
    );
  }
}
