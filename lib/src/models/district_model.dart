import 'dart:convert';


DistrictModel districtModelFromJson(String str) => DistrictModel.fromJson(json.decode(str));

class DistrictModel {
    
    int id;
    String name;
	
	DistrictModel({
		this.id,
		this.name,
	});

	factory DistrictModel.fromJson(Map<String, dynamic> json) => DistrictModel(
		id: json["id"],
    	name: json["name"],

	);
}