import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_login_signup/src/blocs/provider_bloc.dart';
import 'package:flutter_login_signup/src/models/user_model.dart';
import 'package:flutter_login_signup/src/pages/home/home_page.dart';
import 'package:flutter_login_signup/src/pages/users/users_login_page.dart';
import 'package:flutter_login_signup/src/preferences/preferences.dart';
import 'package:flutter_login_signup/src/routes/routes.dart';
import 'package:google_fonts/google_fonts.dart';


void main() async {
	WidgetsFlutterBinding.ensureInitialized();
	final preferences = new Preferences();
	await preferences.initPreferences();

	bool signin;
	if (preferences.token == '') { 
		signin = false; 
	} else {
		signin = true;
		UserModel.setCurrentUserValues();
	}
	runApp(MyApp(signIn: signin,));
}

class MyApp extends StatelessWidget {
  	final bool signIn;
	MyApp({@required this.signIn});

  	@override
  	Widget build(BuildContext context) {
		  
    	final textTheme = Theme.of(context).textTheme;
		SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Color(0xffe46b10),));

		return ProviderBloc(
			child: MaterialApp(
				title: 'Grupo Tigre',
				theme: ThemeData(
					primarySwatch: Colors.blue,
					textTheme:GoogleFonts.latoTextTheme(textTheme).copyWith(
						bodyText1: GoogleFonts.montserrat(textStyle: textTheme.bodyText1),
					),
				),
				debugShowCheckedModeBanner: false,
				home: this.signIn ? HomePage() : UsersLoginPage(),
				routes: ApplicationRoutes.getApplicationRoutes(),
				localizationsDelegates: [ GlobalMaterialLocalizations.delegate ],
				supportedLocales: [ const Locale('en','US'), const Locale('es','ES'),],
			),
		);
			
	}
}
