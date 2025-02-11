import 'dart:ui';

import 'package:common_core/base/base_page_stateful_widget.dart';
import 'package:common_core/helpter/log_utils.dart';
import 'package:common_core/net/dio_utils.dart';
import 'package:common_core/style/theme.dart';
import 'package:common_core/widget/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_commonlib/router/router_config.dart';
import 'package:flutter_commonlib/ui/home_page.dart';
import 'package:flutter_commonlib/ui/msg_page.dart';
import 'package:flutter_commonlib/ui/my_page.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'api/http_api.dart';


void main() {
  ChuckerFlutter.showOnRelease = true;
  ChuckerFlutter.showNotification = true;
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);///一键开启沉浸式状态栏
  SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: isDarkMode()?Brightness.light:Brightness.dark,
  ));
  //限制竖屏
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  MyApp({super.key}) {
    Log.init();
    HttpUtils.init(HttpApi.baseUrl);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('zh', 'CN'),
      theme:appLightThemeData,
      darkTheme: appDarkThemeData,
      themeMode: ThemeMode.system,
      initialRoute: RouterRULConfig.main,
      builder: FlutterSmartDialog.init(),
      // 注册路由观察者
      navigatorObservers: <NavigatorObserver>[routeObserver,ChuckerFlutter.navigatorObserver],
      routingCallback: (routing) {
        currentRouterController.add("${routing?.current}");
      },
      // 定义路由表
      getPages: pages,
    );
  }
}

//////////////////////////////////////////////////////////////////////////////////
class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainPage();
}

class _MainPage extends BasePgaeStatefulWidget with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    initialization();
    WidgetsBinding.instance.addObserver(this);
  }

  void initialization() async {
    FlutterNativeSplash.remove();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget buildPageContent(BuildContext context) => BottomNavigationBarWidget(
    selectedItemColor: Colors.blue,
    unselectedItemColor: Colors.grey,
    bottomNavigationBarItems: const [
      // 导航子项
      BottomNavigationBarItem(
        // 图标
        icon: Icon(Icons.home),
        // 文字内容
        label: '首页',
        backgroundColor: Colors.blue,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.message_rounded),
        label: '消息',
        backgroundColor: Colors.orange,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.people),
        label: '我的',
        backgroundColor: Colors.red,
      ),
    ],
    children: [
      HomePage(),
      MsgPage(),
      MyPage(),
    ],
  );

  @override
  bool showTitleBar() => false;

  @override
  bool showStatusBar() => false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
      // 处理应用恢复到前台的逻辑
        print("didChangeAppLifecycleState  处理应用恢复到前台的逻辑");
        break;
      case AppLifecycleState.inactive:
      // 处理应用即将进入后台的逻辑
        print("didChangeAppLifecycleState  处理应用即将进入后台的逻辑");
        break;
      case AppLifecycleState.paused:
      // 处理应用进入后台的逻辑，如保存数据、暂停定时任务等
        print("didChangeAppLifecycleState 处理应用进入后台的逻辑，如保存数据、暂停定时任务等");
        break;
      case AppLifecycleState.detached:
      // 处理应用终止或关闭的逻辑
        print("didChangeAppLifecycleState 处理应用终止或关闭的逻辑");
        break;
      case AppLifecycleState.hidden:
    }
  }
}
