import 'dart:convert';
import 'dart:io';
import 'package:flutter_login_signup/src/models/district_model.dart';
import 'package:flutter_login_signup/src/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/providers/server_provider.dart';

class DistrictsProvider {
	Future<Map<String, dynamic>> districtsCreate ({@required DistrictModel district}) async{
		try{
			final url = '${ ServerProvider.server }/v1/districts';
			Map<String, dynamic> params = {
				'name': district.name,
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
  	
	Future<List<DistrictModel>> districtsList () async{
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
	}
}