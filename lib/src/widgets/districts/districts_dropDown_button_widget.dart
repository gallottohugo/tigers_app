import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/models/district_model.dart';
import 'package:flutter_login_signup/src/providers/districts_provider.dart';

class DistrictsDropDownButtonWidget extends StatefulWidget {
	final ValueChanged<int> handleDistrictDropdownValue;
    DistrictsDropDownButtonWidget({Key key, @required this.handleDistrictDropdownValue}) : super(key: key);
  	_DistrictsDropDownButtonWidgetState createState() => _DistrictsDropDownButtonWidgetState();
}

class _DistrictsDropDownButtonWidgetState extends State<DistrictsDropDownButtonWidget> {

	DistrictsProvider districtsProvider = DistrictsProvider();
	String dropdownValue = '';
	List<DistrictModel> districtList = List<DistrictModel>();
	
  	@override
  	Widget build(BuildContext context) {
		return FutureBuilder(
			future: districtsProvider.districtsList(),
			initialData: null,
			builder: (BuildContext context, AsyncSnapshot<List<DistrictModel>> snapshot) {
				if (snapshot.hasData){
					if (snapshot.data.first.name != ''){
						DistrictModel districtModel = DistrictModel();
						districtModel.id = 0;
						districtModel.name= '';
						snapshot.data.insert(0, districtModel);
					}
					districtList = snapshot.data;
					return _dropDownField(districtList);
				} else {
					return AbsorbPointer(
						child: BackdropFilter(
							filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
							child: Container(
								padding: EdgeInsets.only(top: 20),
								child: Center(
										child: CircularProgressIndicator(
										backgroundColor: Colors.transparent,
										valueColor: new AlwaysStoppedAnimation<Color>(Color(0xffe46b10)),
									)
								)
							)
						)
					);
				}
			},
		);
  	}

	Widget _dropDownField(List<DistrictModel> districts) {
		return Container(
      		margin: EdgeInsets.symmetric(vertical: 10),
      		child: Column(
        		crossAxisAlignment: CrossAxisAlignment.start,
        		children: <Widget>[
					Text('Consigna', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
					SizedBox(height: 10,),
					DropdownButton<String>(
						isExpanded: true,
						value: dropdownValue,
						underline: Container(),
						elevation: 16,
						onChanged: (String newValue) { 
							setState(() {  
								dropdownValue = newValue;
								int id = districtList.firstWhere((item) => item.name == dropdownValue).id;
								widget.handleDistrictDropdownValue(id);
							}); 
						},
						
						
						items: districts.map<DropdownMenuItem<String>>((value) {
							return DropdownMenuItem<String>(
								value: value.name,
								child: Text(value.name),
							);
						}).toList(),
					)
        		],
      		),
    	);
	}
}