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

class NoInternetConnection extends StatelessWidget {
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
  NoInternetConnection({
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Center(
            child: Image.asset(
              ImageData.noInternet,
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
