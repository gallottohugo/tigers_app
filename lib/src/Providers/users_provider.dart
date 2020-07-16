import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/models/user_model.dart';
import 'package:flutter_login_signup/src/preferences/preferences.dart';
import 'package:flutter_login_signup/src/providers/server_provider.dart';
import 'package:http/http.dart' as http;

class UserProvider {
	Future<Map<String, dynamic>> usersLogin ({@required String user, @required String password}) async{
		try{
			final url = '${ ServerProvider.server }/v1/auth/login';
			Map<String, String> params = {
				"email": user,
				"password": password
			};
			final response = await http.post(url,  body: params);
            String body = utf8.decode(response.bodyBytes);
			final decodedData = json.decode(body);

			if (response.statusCode == 200){
				Preferences preferences = new Preferences();
				preferences.token = decodedData['token'];
				preferences.userId = decodedData['username'];
				preferences.userAdmin = decodedData['admin'];
				preferences.userName = decodedData['name'];
				preferences.userLastName = decodedData['last_name'];
				preferences.userEmail = decodedData['email'];
				preferences.userType = decodedData['user_type'];

				UserModel.setCurrentUserValues();
				return { 'ok': true };
			} else { return { 'ok': false }; }	
		} catch (exception){ return { 'ok': false }; }
	}


	Future<Map<String, dynamic>> usersSignup ({@required UserModel user}) async{
		try{
			String admin = "false";
			if (user.userType == 'Administrador'){ admin = "true"; }
			final url = '${ ServerProvider.server }/v1/users';
			Map<String, dynamic> params = {
				'name': user.name,
				'last_name': user.lastName,
				'email': user.email,
				'admin': admin,
				'phone1': user.phone,
				'user_type': user.userTypeEN(),
				"password": '123456',
				"password_confirmation": '123456',
			};
			final response = await http.post(url, body: params);
            String body = utf8.decode(response.bodyBytes);
			final decodedData = json.decode(body);

			if (response.statusCode == 201){
				return { 'ok': true };
			} else { 
				return { 'ok': false, 'message': decodedData["errors"][0] }; 
			}	
		} catch (exception){ 
			print(exception);
			return { 'ok': false, 'message': "exception" }; 
		}
	}



	Future<List<UserModel>> usersList ({@required String filter}) async{
		List<UserModel> customers = List<UserModel>();

		String params = '';
		if (filter != null){ params = "?filter=$filter"; }
		try{
			final url = '${ ServerProvider.server }/v1/users$params';
			final response = await http.get(url, headers: { HttpHeaders.authorizationHeader: "Bearer ${ UserModel.currentUser.token }"},);
			if (response.statusCode == 200){
				String body = utf8.decode(response.bodyBytes);
				final decodedData = json.decode(body);
				for (var item in decodedData) {
					UserModel _customer = UserModel.fromJson(item);
					customers.add(_customer);
				}
				return customers ;
			} else { 
				return customers; }	
		} catch (exception){ 
			
			return customers; 
		}
	}
}


