import 'package:flutter/cupertino.dart';
import 'package:flutter_login_signup/src/pages/home/home_page.dart';
import 'package:flutter_login_signup/src/pages/users/users_customers_list.dart';
import 'package:flutter_login_signup/src/pages/users/users_houses_page.dart';
import 'package:flutter_login_signup/src/pages/users/users_list_page.dart';
import 'package:flutter_login_signup/src/pages/users/users_login_page.dart';
import 'package:flutter_login_signup/src/pages/users/users_create_page.dart';

class ApplicationRoutes {
	
	static Map<String, WidgetBuilder> getApplicationRoutes(){
		return <String, WidgetBuilder> {
			HomePage.routeName   : (BuildContext context)  => HomePage(),
			UsersLoginPage.routeName  : (BuildContext context)  => UsersLoginPage(),
			UsersCreatePage.routeName : (BuildContext context)  => UsersCreatePage(),
      		UsersHousesPage.routeName : (BuildContext context) => UsersHousesPage(),
			UsersCustomersListPage.routeName : (BuildContext context) => UsersCustomersListPage(),
			UsersListPage.routeName : (BuildContext context) => UsersListPage(),
		};
	}
}
			