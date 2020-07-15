import 'dart:convert';

import 'package:flutter_login_signup/src/preferences/preferences.dart';


UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));


class UserModel {
    static UserModel currentUser = UserModel();

    int id;
    String token;
	bool admin;
	String name;
	String lastName;
	String email;
	String userType;
	String phone;


	UserModel({
		this.id,
		this.token,
		this.admin,
		this.name,
		this.lastName,
		this.email,
		this.userType,
		this.phone,
	});

	String userTypeES(){
		switch (this.userType) {
		  	case 'admin': return 'Administrador'; break;
			case 'coordinator': return 'Coordinador'; break;
			case 'employee': return 'Empleado'; break;
			case 'customer': return 'Ciente'; break;
		  	default: return '';
		}
	}

	String userTypeEN(){
		switch (this.userType) {
		  	case 'Administrador': return 'admin'; break;
			case 'Coordinador': return 'coordinator'; break;
			case 'Empleado': return 'employee'; break;
			case 'Cliente': return 'customer'; break;
		  	default: return '';
		}
	}

	static void setCurrentUserValues(){
		Preferences preferences = Preferences();
		UserModel.currentUser.id = preferences.userId;
		UserModel.currentUser.token = preferences.token;
		UserModel.currentUser.admin = preferences.userAdmin;
		UserModel.currentUser.name = preferences.userName;
		UserModel.currentUser.lastName = preferences.userLastName;
		UserModel.currentUser.email = preferences.userEmail;
		UserModel.currentUser.userType = preferences.userType;
	}


	bool coordinator(){
		if (this.userType == 'admin' || this.userType == 'coordinator' ){
			return true;
		} else {
			return false;
		}
	}

	bool employee(){
		if (this.userType == 'admin' || this.userType == 'coordinator' || this.userType == 'employee'){
			return true;
		} else {
			return false;
		}
	}



	factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
		id: json["id"],
    	token: json["token"],
		admin: json["admin"],
		name: json["name"],
		lastName: json["last_name"],
		email: json["email"],
		userType: json["user_type"],
		phone: json["phone1"],
	);
}