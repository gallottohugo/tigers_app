import 'package:flutter/cupertino.dart';
import 'package:flutter_login_signup/src/pages/districts/districts_create_page.dart';
import 'package:flutter_login_signup/src/pages/districts/districts_list_page.dart';
import 'package:flutter_login_signup/src/pages/_guards/guards_create_page.dart';
import 'package:flutter_login_signup/src/pages/home/home_page.dart';
import 'package:flutter_login_signup/src/pages/houses/houses_create_page.dart';
import 'package:flutter_login_signup/src/pages/users/users_customers_list_page.dart';
import 'package:flutter_login_signup/src/pages/users/users_houses_page.dart';
import 'package:flutter_login_signup/src/pages/users/users_list_page.dart';
import 'package:flutter_login_signup/src/pages/users/users_login_page.dart';
import 'package:flutter_login_signup/src/pages/users/users_create_page.dart';

class ApplicationRoutes {
	
	static Map<String, WidgetBuilder> getApplicationRoutes(){
		return <String, WidgetBuilder> {
			//home
			HomePage.routeName   : (BuildContext context)  => HomePage(),

			//users
			UsersLoginPage.routeName  : (BuildContext context)  => UsersLoginPage(),
			UsersCreatePage.routeName : (BuildContext context)  => UsersCreatePage(),
      		UsersHousesPage.routeName : (BuildContext context) => UsersHousesPage(),
			UsersCustomersListPage.routeName : (BuildContext context) => UsersCustomersListPage(),
			UsersListPage.routeName : (BuildContext context) => UsersListPage(),
			
			//districts
			DistrictsCreatePage.routeName : (BuildContext context) => DistrictsCreatePage(),
			DistrictsListPage.routeName : (BuildContext context) => DistrictsListPage(),
			
			
			//houses
			HousesCreatePage.routeName : (BuildContext context) => HousesCreatePage(),

			

			//guards
			GuardsCreatePage.routeName : (BuildContext context) => GuardsCreatePage(),
				

			
		};
	}
}
			