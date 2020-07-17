import 'dart:convert';

GuardModel guardModelFromJson(String str) => GuardModel.fromJson(json.decode(str));

class GuardModel {
	int id;
	String date;
    int start;
    int  end;
	int districtId;
	
	GuardModel({
		this.id,
		this.date,
		this.start,
		this.end,
		this.districtId
	});

	factory GuardModel.fromJson(Map<String, dynamic> json) => GuardModel(
		id: json["id"],
    	date: json["name"],
		start: json["start"],
		end: json["end"],
		districtId: json["district_id"]
	);
}