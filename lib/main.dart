import 'package:dhanva_mobile_app/components/bottom_navigation_bar.dart';
import 'package:dhanva_mobile_app/global/providers/authentication_provider.dart';
import 'package:dhanva_mobile_app/global/services/shared_preference_service.dart';
import 'package:dhanva_mobile_app/offline_consultation_screen/offline_consultation_screen_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:dhanva_mobile_app/splash_screen/splash_screen_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'flutter_flow/internationalization.dart';
import 'home_screen/home_screen_widget.dart';
import 'hospital_screen/hospital_screen_widget.dart';
import 'profile_screen/profile_screen_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AuthenticationProvider.instance; // initiallize AuthProvider
  await SharedPreferenceService.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  ThemeMode _themeMode = ThemeMode.system;

  void setLocale(Locale value) => setState(() => _locale = value);
  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
      });

  @override
  void initState() {
    super.initState();
    _getFCMToken();
  }

  Future<void> _getFCMToken() async {
    await Firebase.initializeApp();
    String fcmToken = await FirebaseMessaging.instance.getToken();
    print("started FCM ${fcmToken}");
    SharedPreferenceService.saveString(key: FcmTokenKey, value: fcmToken);
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'DhanvaMobileApp',
        localizationsDelegates: [
          FFLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: _locale,
        debugShowCheckedModeBanner: false,
        supportedLocales: const [Locale('en', '')],
        theme: ThemeData(brightness: Brightness.light),
        themeMode: _themeMode,
        home: SplashScreenWidget(),
      ),
    );
  }
}

class NavBarPage extends StatefulWidget {
  NavBarPage({Key key, this.initialPage}) : super(key: key);

  final String initialPage;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  // page image icons
  final Image _homeActiveImage = Image.asset('assets/images/home_active.png');
  final Image _homeInactiveImage =
      Image.asset('assets/images/home_inactive.png');
  final Image _onlineActiveImage =
      Image.asset('assets/images/online_active_icon.png');
  final Image _onlineInactiveImage =
      Image.asset('assets/images/online_inactive_icon.png');
  final Image _offlineActiveImage =
      Image.asset('assets/images/offline_active.png');
  final Image _offlineInactiveImage =
      Image.asset('assets/images/offline_inactive.png');
  final Image _profileActiveImage = Image.asset(
      'assets/images/4781820_avatar_male_man_people_person_icon_active.png');
  final Image _profileInactiveImage =
      Image.asset('assets/images/profile_inactive.png');

  int _currentPageIndex;

  @override
  void initState() {
    super.initState();
    // _currentPage = widget.initialPage ?? _currentPage;
    _currentPageIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    // final tabs = {
    //   'HomeScreen': HomeScreenWidget(),
    //   'HospitalScreen': HospitalScreenWidget(),
    //   'ProfileScreen': ProfileScreenWidget(),
    // };

    List<Widget> _navigationPages = [
      HomeScreenWidget(),
      HospitalScreenWidget(),
      OfflineConsultationScreen(),
      ProfileScreenWidget(),
    ];

    // final currentIndex = tabs.keys.toList().indexOf(_currentPage);
    return Scaffold(
      body: IndexedStack(
        children: _navigationPages,
        index: _currentPageIndex,
      ),
      bottomNavigationBar: CurvedBottomNavBar(
        currentIndex: _currentPageIndex,
        ontap: (int index) {
          setState(() => {_currentPageIndex = index});
        },
        items: [
          CurvedBottomNavBarItem(
              title: "Home",
              activeImage: _homeActiveImage,
              inactiveImage: _homeInactiveImage),
          CurvedBottomNavBarItem(
              title: "Online",
              activeImage: _onlineActiveImage,
              inactiveImage: _onlineInactiveImage),
          CurvedBottomNavBarItem(
              title: 'Offline',
              activeImage: _offlineActiveImage,
              inactiveImage: _offlineInactiveImage),
          CurvedBottomNavBarItem(
              title: "Profile",
              activeImage: _profileActiveImage,
              inactiveImage: _profileInactiveImage)
        ],
      ),
    );
  }
}
