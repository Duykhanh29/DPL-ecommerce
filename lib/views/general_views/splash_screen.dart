import 'package:dpl_ecommerce/app_config.dart';
import 'package:dpl_ecommerce/main.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';
import 'package:dpl_ecommerce/view_model/auth_view_model.dart';
import 'package:dpl_ecommerce/views/consumer/main_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dpl_ecommerce/models/user.dart' as userModel;
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:provider/provider.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
//         overlays: [SystemUiOverlay.bottom]);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     //before going to other screen show statusbar
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
//         overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CustomSplashScreen(
//       //comment this
//       seconds: 30,
//       //comment this
//       // navigateAfterSeconds: access_token.$!.isNotEmpty ? Home() : Login(),
//       //navigateAfterFuture: loadFromFuture(), //uncomment this
//       // version: Text(
//       //   "version " + _packageInfo.version,
//       //   style: TextStyle(
//       //       fontWeight: FontWeight.bold,
//       //       fontSize: 11.0,
//       //       color: MyTheme.app_accent_border),
//       // ),
//       useLoader: false,
//       loadingText: Text(
//         AppConfig.appName,
//         style: const TextStyle(
//           fontWeight: FontWeight.w500,
//           fontSize: 20.0,
//           color: Colors.white,
//         ),
//       ),
//       // image: ImageData.googleLogo,
//       // width: 300,
//       // height: 100,

//       backgroundColor: Colors.cyan.shade100,
//       backgroundPhotoSize: 120.0,
//       photoSize: 55,
//     );
//   }
// }

class SplashScreen extends StatefulWidget {
  /// Seconds to navigate after for time based navigation
  final int? seconds;

  /// App version, shown in the middle of screen in case of no image available
  final Text version;

  /// Page background color
  final Color backgroundColor;

  /// Style for the laodertext
  final TextStyle styleTextUnderTheLoader;

  /// The page where you want to navigate if you have chosen time based navigation
  final dynamic navigateAfterSeconds;

  /// Main image size
  final double? photoSize;

  final double? backgroundPhotoSize;

  /// Triggered if the user clicks the screen
  final dynamic onClick;

  /// Loader color
  final Color? loaderColor;

  /// Main image mainly used for logos and like that
  final Image? image;

  final Image? backgroundImage;

  /// Loading text, default: "Loading"
  final Text loadingText;

  ///  Background image for the entire screen
  final ImageProvider? imageBackground;

  /// Background gradient for the entire screen
  final Gradient? gradientBackground;

  /// Whether to display a loader or not
  final bool useLoader;

  /// Custom page route if you have a custom transition you want to play
  final Route? pageRoute;

  /// RouteSettings name for pushing a route with custom name (if left out in MaterialApp route names) to navigator stack (Contribution by Ramis Mustafa)
  final String? routeName;

  /// expects a function that returns a future, when this future is returned it will navigate
  final Future<dynamic>? navigateAfterFuture;
  final Function? afterSplashScreen;

  /// Use one of the provided factory constructors instead of.
  @protected
  SplashScreen({
    this.loaderColor,
    this.navigateAfterFuture,
    this.seconds,
    this.photoSize,
    this.backgroundPhotoSize,
    this.pageRoute,
    this.onClick,
    this.navigateAfterSeconds,
    this.version = const Text(''),
    this.backgroundColor = Colors.white,
    this.styleTextUnderTheLoader = const TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black),
    this.image,
    this.backgroundImage,
    this.loadingText = const Text(""),
    this.imageBackground,
    this.gradientBackground,
    this.useLoader = true,
    this.routeName,
    this.afterSplashScreen,
  });

  @override
  _CustomSplashScreenState createState() => _CustomSplashScreenState();
}

class _CustomSplashScreenState extends State<SplashScreen> {
  auth.User? user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // super.initState();
    // final authProvider = Provider.of<AuthViewModel>(context);
    // Future.delayed(
    //   Duration.zero,
    //   () {
    //     Provider.of<AuthViewModel>(context,
    //         listen: false); // Chú ý listen: false
    //     auth.FirebaseAuth.instance.authStateChanges().listen((event) {
    //       setState(() {
    //         user = event;
    //       });
    //       Future.delayed(const Duration(seconds: 3)).whenComplete(() {
    //         user != null
    //             ? Navigator.pushReplacement(
    //                 context,
    //                 MaterialPageRoute(
    //                   builder: (context) => AuthorizatedPage(),
    //                 ),
    //               )
    //             : Navigator.of(context, rootNavigator: true).pushReplacement(
    //                 MaterialPageRoute(
    //                   builder: (context) => StartLogin(),
    //                 ),
    //               );
    //       });
    //     });
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Fada(
          //   child: Container(
          //     decoration: BoxDecoration(
          //       image:DecorationImage(
          //               fit: BoxFit.cover,
          //               image: ,
          //             ),
          //       gradient: widget.gradientBackground,
          //       color: widget.backgroundColor,
          //     ),
          //   ),
          // ),
          Center(
            child: Image.asset(
              ImageData.appLogo,
              height: 400.h,
              width: 400.h,
            ),
          ),
          SizedBox(
            height: 300.h,
          ),
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: <Widget>[
          //     Container(
          //         width: double.infinity,
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: <Widget>[
          //             Padding(
          //               padding: const EdgeInsets.all(8.0),
          //               child: widget.image,
          //             ),
          //             Padding(
          //               padding: const EdgeInsets.all(8.0),
          //               child: widget.loadingText,
          //             ),
          //             widget.version,
          //             Padding(
          //               padding: const EdgeInsets.only(top: 10.0),
          //             ),
          //           ],
          //         )),
          //   ],
          // ),
        ],
      ),
    );
  }
}
