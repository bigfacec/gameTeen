import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:gamewallpaper/widgets/download.dart';
import 'package:gamewallpaper/widgets/splash.dart';
import 'package:gamewallpaper/widgets/wallpaper.dart';
import 'package:oktoast/oktoast.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: true);

  runApp(MyApp());
  SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
//    statusBarBrightness: Brightness.dark
  );
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();

}

class _MyAppState extends State<MyApp>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return OKToast(
      child: FlutterEasyLoading(
        child: MaterialApp(
          title: 'Wallpaper',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: SplashPage(),
        ),
      ),
    );
  }
}


