import 'dart:convert';
import 'dart:io';
import 'package:flutter_login_signup/src/models/guard_model.dart';
import 'package:flutter_login_signup/src/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/providers/server_provider.dart';

class GuardsProvider {
	Future<Map<String, dynamic>> guardsCreate ({@required GuardModel guard, @required List<UserModel> employees}) async{

		String employeesArr = '';
		for(UserModel item in employees){ employeesArr += item.id.toString() + ","; }

		try{
			final url = '${ ServerProvider.server }/v1/guards';
			Map<String, dynamic> params = {
				'date': guard.date,
				'start': guard.start.toString(),
				'end': guard.end.toString(),
				'district_id': guard.districtId.toString(),
				'employees': employeesArr
			};
			final response = await http.post(
				url, 
				headers: { HttpHeaders.authorizationHeader: "Bearer ${ UserModel.currentUser.token  }"},
				body: params
			);
            String body = utf8.decode(response.bodyBytes);
			final decodedData = json.decode(body);
			if (response.statusCode == 201){ return { 'ok': true };} 
			else {  return { 'ok': false, 'message': decodedData["errors"][0] };  }	
		} catch (exception){ 
			return { 'ok': false, 'message': "exception" }; 
		}
	}
  	
	/*Future<List<DistrictModel>> districtsList () async{
		List<DistrictModel> districts = List<DistrictModel>();
		try{
			final url = '${ ServerProvider.server }/v1/districts';
			final response = await http.get(url, headers: { HttpHeaders.authorizationHeader: "Bearer ${ UserModel.currentUser.token }"},);
			if (response.statusCode == 200){
				String body = utf8.decode(response.bodyBytes);
				final decodedData = json.decode(body);
				for (var item in decodedData) {
					DistrictModel _district = DistrictModel.fromJson(item);
					districts.add(_district);
				}
				return districts ;
			} else { 
				return districts; }	
		} catch (exception){ 
			return districts; 
		}
	}*/
}