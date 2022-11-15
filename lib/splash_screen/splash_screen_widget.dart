import 'package:dhanva_mobile_app/global/providers/authentication_provider.dart';
import 'package:dhanva_mobile_app/help_screen/help_screen.dart';
import 'package:dhanva_mobile_app/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../login_screen/login_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

ChangeNotifierProvider<AuthenticationProvider> _authProvider =
    ChangeNotifierProvider((ref) => AuthenticationProvider.instance);

class SplashScreenWidget extends ConsumerStatefulWidget {
  const SplashScreenWidget({Key key}) : super(key: key);

  @override
  ConsumerState<SplashScreenWidget> createState() => _SplashScreenWidgetState();
}

class _SplashScreenWidgetState extends ConsumerState<SplashScreenWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String _token;

  @override
  void initState() {
    super.initState();
    // On page load action.

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 3000));
      print('AuthToken : ${ref.read(_authProvider).authToken}');
      _token = ref.read(_authProvider).authToken;
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => HelpScreenWidget(),
      //   ),
      // );
      await Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
          type: PageTransitionType.leftToRight,
          duration: Duration(milliseconds: 300),
          reverseDuration: Duration(milliseconds: 300),
          child: _token != null && _token.isNotEmpty
              ? NavBarPage()
              : LoginScreenWidget(),
        ),
        (r) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF5F5F5),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Image.asset(
          'assets/images/Splash.png',
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
