import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'global_bloc/global_bloc.dart';
import 'router/router.gr.dart';
import 'router/router_guard.dart';
import '/utils/size_config.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color.fromARGB(100, 88, 122, 50),
    systemNavigationBarColor: Colors.grey,
  ));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    GlobalBloc.dispose();
    super.dispose();
  }

  final _appRouter = AppRouter(routeGuard: RouteGuard());

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: GlobalBloc.blocProviders,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return OrientationBuilder(builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return ScreenUtilInit(
              designSize: const Size(360, 690),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: () => GlobalLoaderOverlay(
                child: MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  builder: (context, child) {
                    ScreenUtil.setContext(context);
                    return MediaQuery(
                      data:
                          MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                      child: child!,
                    );
                  },
                  routeInformationParser: _appRouter.defaultRouteParser(),
                  routerDelegate: _appRouter.delegate(),
                  theme: ThemeData(
                    appBarTheme: const AppBarTheme().copyWith(
                      backgroundColor: Colors.amber,
                      titleTextStyle: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFB3541E),
                        fontStyle: FontStyle.italic,
                        fontFamily: GoogleFonts.openSans().fontFamily,
                        letterSpacing: 1.0,
                      ),
                    ),
                    iconTheme: const IconThemeData().copyWith(
                      size: 20.h,
                    ),
                    elevatedButtonTheme: elevatedButtonTheme(),
                    textTheme: textTheme(),
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }
}

elevatedButtonTheme() {
  return ElevatedButtonThemeData(
    // style: ButtonStyle(
    //   backgroundColor: MaterialStateProperty.all(const Color(0xFFb1c795)),
    //   foregroundColor: MaterialStateProperty.all(Colors.white),
    //   padding: MaterialStateProperty.all(
    //     EdgeInsets.symmetric(vertical: 14.h),
    //   ),
    // ),
    style: ElevatedButton.styleFrom(
      primary: const Color(0xFFb1c795),
      onPrimary: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 14.h),
    ),
  );
}

textTheme() {
  return GoogleFonts.openSansTextTheme().copyWith(
    headline1: TextStyle(
      fontSize: 90.sp,
      fontFamily: GoogleFonts.openSans().fontFamily,
    ),
    headline2: TextStyle(
      fontSize: 60.sp,
      fontFamily: GoogleFonts.openSans().fontFamily,
    ),
    headline3: TextStyle(
      fontSize: 48.sp,
      fontFamily: GoogleFonts.openSans().fontFamily,
      color: const Color(0xff323232),
    ),
    headline4: TextStyle(
      fontSize: 34.sp,
      fontFamily: GoogleFonts.openSans().fontFamily,
      color: const Color(0xff323232),
    ),
    headline5: TextStyle(
      fontSize: 25.sp,
      fontFamily: GoogleFonts.openSans().fontFamily,
      color: const Color(0xff323232),
    ),
    headline6: TextStyle(
      fontSize: 20.sp,
      fontFamily: GoogleFonts.openSans().fontFamily,
      color: const Color(0xff323232),
    ),
    subtitle1: TextStyle(
      fontSize: 16.sp,
      fontFamily: GoogleFonts.openSans().fontFamily,
      color: const Color(0xff323232),
    ),
    subtitle2: TextStyle(
      fontSize: 14.sp,
      fontFamily: GoogleFonts.openSans().fontFamily,
      color: const Color(0xff323232),
    ),
    bodyText1: TextStyle(
      fontSize: 16.sp,
      fontFamily: GoogleFonts.openSans().fontFamily,
      color: const Color(0xff323232),
    ),
    bodyText2: TextStyle(
      fontSize: 14.sp,
      fontFamily: GoogleFonts.openSans().fontFamily,
      color: const Color(0xff323232),
    ),
    button: TextStyle(
      fontSize: 14.sp,
      fontFamily: GoogleFonts.openSans().fontFamily,
      color: const Color(0xff323232),
    ),
    caption: TextStyle(
      fontSize: 12.sp,
      fontFamily: GoogleFonts.openSans().fontFamily,
      color: const Color(0xff323232),
    ),
    overline: TextStyle(
      fontSize: 10.sp,
      fontFamily: GoogleFonts.openSans().fontFamily,
      color: const Color(0xff323232),
    ),
  );
}
