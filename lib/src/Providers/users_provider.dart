import 'package:flutter/material.dart';

class UserProvider {
	Future<Map<String, dynamic>> login ({@required String user, @required String password}) async{
		
		
			//final url = '${ PaymunProvider.server }/api/auth/token/';
			//final response = await http.post(url,  body: params);
            //String body = utf8.decode(response.bodyBytes);
			//final decodedData = json.decode(body);

			//if (response.statusCode == 200){
				//save token to preferences
				//Preferences preferences = new Preferences();
				//preferences.token       = decodedData['token'];
				//preferences.userId      = decodedData['id'];
				//preferences.name        = decodedData['name'];
				//preferences.username    = decodedData['username'];
				//preferences.phoneNumber = decodedData['phone_number'];
				//return { 'ok': true };
			//} else {
				//final message = decodedData['non_field_errors'];
				//return { 'ok': false, 'message': message[0]};
			//}	
		//} catch (exception){ 
			//return { 'ok': false, 'message': exception.toString() }; 
		//}
		return { "ok": true };
	}
}


