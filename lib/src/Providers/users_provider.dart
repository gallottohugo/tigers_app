import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/preferences/preferences.dart';
import 'package:flutter_login_signup/src/providers/server_provider.dart';
import 'package:http/http.dart' as http;

class UserProvider {
	Future<Map<String, dynamic>> login ({@required String user, @required String password}) async{
		try{
			final url = '${ ServerProvider.server }/v1/auth/login';
			Map<String, String> params = {
				"email": "gallottohugo@gmail.com",
				"password": "123456"
			};
			final response = await http.post(url,  body: params);
            String body = utf8.decode(response.bodyBytes);
			final decodedData = json.decode(body);

			if (response.statusCode == 200){
				//save token to preferences
				Preferences preferences = new Preferences();
				preferences.token       = decodedData['token'];
				preferences.userId      = decodedData['username'];
				return { 'ok': true };
			} else { return { 'ok': false }; }	
		} catch (exception){ return { 'ok': false }; }
	}
}


