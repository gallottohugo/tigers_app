import 'dart:convert';
import 'dart:io';
import 'package:flutter_login_signup/src/models/house_model.dart';
import 'package:flutter_login_signup/src/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/providers/server_provider.dart';

class HousesProvider {
	Future<Map<String, dynamic>> housesCreate ({@required HouseModel house}) async{
		try{
			final url = '${ ServerProvider.server }/v1/houses';
			Map<String, dynamic> params = {
				'address': house.address,
				'address_number': house.addressNumber.toString(),
				'city': house.city,
				'district_id': house.districtId.toString(),
				'customer_id': house.customerId.toString()
			};
			final response = await http.post(
				url, 
				headers: { HttpHeaders.authorizationHeader: "Bearer ${ UserModel.currentUser.token  }"},
				body: params,
			);
            String body = utf8.decode(response.bodyBytes);
			final decodedData = json.decode(body);
			if (response.statusCode == 201){ return { 'ok': true };} 
			else {  return { 'ok': false, 'message': decodedData["errors"] };  }	
		} catch (exception){ 
			return { 'ok': false, 'message': "exception" }; 
		}
	}
  	
	Future<List<HouseModel>> housesList ({@required int customerId}) async{
		List<HouseModel> houses = List<HouseModel>();

		try{
			final url = '${ ServerProvider.server }/v1/users/$customerId/houses';
			final response = await http.get(url, headers: { HttpHeaders.authorizationHeader: "Bearer ${ UserModel.currentUser.token }"},);
			if (response.statusCode == 200){
				String body = utf8.decode(response.bodyBytes);
				final decodedData = json.decode(body);
				for (var item in decodedData) {
					HouseModel _house = HouseModel.fromJson(item);
					houses.add(_house);
				}
				return houses ;
			} else { 
				return houses; }	
		} catch (exception){ 
			return houses; 
		}
	}
}