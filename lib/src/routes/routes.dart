import 'package:flutter/cupertino.dart';
import 'package:flutter_login_signup/src/pages/home/home_page.dart';
import 'package:flutter_login_signup/src/pages/users/login_page.dart';
import 'package:flutter_login_signup/src/pages/users/signup_page.dart';

class ApplicationRoutes {
	
	static Map<String, WidgetBuilder> getApplicationRoutes(){
		return <String, WidgetBuilder> {
			//#home
			//PaymunPageInit.routeName         : (BuildContext context) => PaymunPageInit(),
			HomePage.routeName   : (BuildContext context)  => HomePage(),
			LoginPage.routeName  : (BuildContext context)  => LoginPage(),
			SignUpPage.routeName : (BuildContext context) => SignUpPage(),
		};
	}
}
			