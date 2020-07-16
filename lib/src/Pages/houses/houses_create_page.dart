import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/models/district_model.dart';
import 'package:flutter_login_signup/src/models/house_model.dart';
import 'package:flutter_login_signup/src/models/user_model.dart';
import 'package:flutter_login_signup/src/providers/districts_provider.dart';
import 'package:flutter_login_signup/src/providers/houses_provider.dart';
import 'package:flutter_login_signup/src/widgets/alert_widgets.dart';
import 'package:flutter_login_signup/src/widgets/app_bar_widget.dart';
import 'package:flutter_login_signup/src/widgets/bezierContainer.dart';

class HousesCreatePage extends StatefulWidget {
	static final String routeName = 'houses_create_page';
	final String title;
  	HousesCreatePage({Key key, this.title}) : super(key: key);

  	@override
  	_HousesCreatePageState createState() => _HousesCreatePageState();
}

class _HousesCreatePageState extends State<HousesCreatePage> {
	final formKey = GlobalKey<FormState>();
	bool showLoading = false;
	HouseModel newHouse = HouseModel();
	UserModel currentCustomer = UserModel();
	DistrictsProvider districtsProvider = DistrictsProvider();
	String dropdownValue = '';
	List<DistrictModel> districtList = List<DistrictModel>();



	@override
  	Widget build(BuildContext context) {
		Map<String, dynamic> mapsArgument = ModalRoute.of(context).settings.arguments;
		currentCustomer = mapsArgument['customer'];
		newHouse.customerId = currentCustomer.id;

    	final height = MediaQuery.of(context).size.height;
		return Scaffold(
			appBar: _appBarTiger(),
      		body: Container(
        		height: height,
        		child: Stack(
          			children: <Widget>[
            			Positioned(
              				top: -MediaQuery.of(context).size.height * .15,
              				right: -MediaQuery.of(context).size.width * .4,
              				child: BezierContainer(),
            			),
            			Container(
              				padding: EdgeInsets.symmetric(horizontal: 20),
              				child: SingleChildScrollView(
                				child: Column(
                  					crossAxisAlignment: CrossAxisAlignment.center,
                  					mainAxisAlignment: MainAxisAlignment.center,
                  					children: <Widget>[
                    					SizedBox(height: 20,),
                    					_formWidget(),
                    					SizedBox(height: 20,),
                    					_submitButton(),
                    					SizedBox(height: height * .14),
                  					],
                				),
              				),
            			),
						showLoading == true ? AbsorbPointer(
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
						) : Container()
          			],
        		),
      		),
    	);
  	}



	Widget _appBarTiger({Widget leading}){
		return PreferredSize(
			preferredSize: Size.fromHeight(60.0), // here the desired height
			child: AppBarTiger(title: 'Nueva casa', leading: leading,)
		);
	}

	  
  

  	Widget _entryField(String title, {@required  String initialValue, @required bool enabled, Function onSaved, @required TextInputType textInputType  }) {
    	return Container(
      		margin: EdgeInsets.symmetric(vertical: 10),
      		child: Column(
        		crossAxisAlignment: CrossAxisAlignment.start,
        		children: <Widget>[
					Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
					SizedBox(height: 10,),
					TextFormField(
						decoration: InputDecoration(
							border: InputBorder.none,
							fillColor: Color(0xfff3f3f4),
							filled: true
						),
						keyboardType: textInputType,
						onSaved: onSaved,
						initialValue: initialValue,
						enabled: enabled,
					)
        		],
      		),
    	);
  	}

  	Widget _submitButton() {
    	return GestureDetector(
			child: Container(
				width: MediaQuery.of(context).size.width,
				padding: EdgeInsets.symmetric(vertical: 15),
				alignment: Alignment.center,
				decoration: BoxDecoration(
					borderRadius: BorderRadius.all(Radius.circular(5)),
					boxShadow: <BoxShadow>[
						BoxShadow(
							color: Colors.grey.shade200,
							offset: Offset(2, 4),
							blurRadius: 5,
							spreadRadius: 2
						)
					],
					gradient: LinearGradient(
						begin: Alignment.centerLeft,
						end: Alignment.centerRight,
						colors: [Color(0xfffbb448), Color(0xfff7892b)]
					)
				),
				child: Text('Crear', style: TextStyle(fontSize: 20, color: Colors.white)),
			),
			onTap: () async {
				setState(() { showLoading = true; });
				formKey.currentState.save();
				HousesProvider housesProvider = HousesProvider();
				Map<String, dynamic> response = await housesProvider.housesCreate(house: newHouse);
				setState(() { showLoading = false; });
				if(response["ok"] == true){
					Navigator.pop(context);
				} else {
					AlertWidgets.alertOkWidget(context, 'Error', response["message"], Icon(Icons.error));
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
								newHouse.districtId = districtList.firstWhere((item) => item.name == dropdownValue).id;
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

	

  	Widget _formWidget() {
    	return Form(
			key: formKey,
			child: Column(
				children: <Widget>[
					_entryField("Dirección", onSaved: _onSavedAddress, enabled: true, initialValue: '', textInputType: TextInputType.text),
					SizedBox(height: 10,),
					_entryField("Número", onSaved: _onSavedAddressNumber, enabled: true, initialValue: '', textInputType: TextInputType.number),
					SizedBox(height: 10,),
					_entryField("Ciudad", onSaved: _onSavedCity, enabled: true, initialValue: '', textInputType: TextInputType.text),    
					SizedBox(height: 10,),
					FutureBuilder(
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
								//return _popupMenuButtonDistricts(snapshot.data);
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
					),
				],
			)
    	);
  	} 

	void _onSavedAddress(String value){ newHouse.address = value; }
	void _onSavedAddressNumber(String value){ newHouse.addressNumber = int.parse(value) ; }
	void _onSavedCity(String value){ newHouse.city = value; }

}




