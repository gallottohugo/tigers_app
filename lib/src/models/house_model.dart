import 'dart:convert';


HouseModel houseModelFromJson(String str) => HouseModel.fromJson(json.decode(str));


class HouseModel {
    
    int id;
    String address;
	int addressNumber;
	String city;
	int districtId;
	int customerId;
	

	HouseModel({
		this.id,
		this.address,
		this.addressNumber,
		this.city,
		this.districtId,
		this.customerId,
	});



	factory HouseModel.fromJson(Map<String, dynamic> json) => HouseModel(
		id: json["id"],
    	address: json["address"],
		addressNumber: json["address_number"],
		city: json["city"],
		districtId: json["district_id"],
		customerId: json["customer_id"],
	);
}