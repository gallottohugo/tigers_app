import 'package:shared_preferences/shared_preferences.dart';

class Preferences {

	static final Preferences _instance = new Preferences._internal();
	factory Preferences(){ return _instance; }
	Preferences._internal();
	SharedPreferences _prefs;
	initPreferences() async { this._prefs = await SharedPreferences.getInstance(); }

	//settigns token
	get token { return _prefs.getString('token') ?? ''; }
	set token(String value){ _prefs.setString('token', value);}

	//settings currentUser id
	get userId {return _prefs.getInt('userId') ?? 1;}
	set userId(int value){_prefs.setInt('userId', value);}

  //settings admin
	get userAdmin {return _prefs.getBool('userAdmin') ?? false;}
	set userAdmin(bool value){_prefs.setBool('userAdmin', value);}

  //settings userName
	get userName { return _prefs.getString('userName') ?? ''; }
	set userName(String value){ _prefs.setString('userName', value);}

  //settings userLastName
	get userLastName { return _prefs.getString('userLastName') ?? ''; }
	set userLastName(String value){ _prefs.setString('userLastName', value);}

  //settings userEmail
	get userEmail { return _prefs.getString('userEmail') ?? ''; }
	set userEmail(String value){ _prefs.setString('userEmail', value);}

  //settings userType
	get userType { return _prefs.getString('userType') ?? ''; }
	set userType(String value){ _prefs.setString('userType', value);}
  


  	static void clearPreferences(){
    	Preferences preferences = Preferences();
		preferences.token = '';
		preferences.userId = 0;
		preferences.userAdmin = false;
		preferences.userName = '';
		preferences.userLastName = '';
		preferences.userEmail = '';
		preferences.userType = '';
  	}

}