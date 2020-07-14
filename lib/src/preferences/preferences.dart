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

}