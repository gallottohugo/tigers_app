import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/models/house_model.dart';
import 'package:flutter_login_signup/src/models/user_model.dart';
import 'package:flutter_login_signup/src/providers/houses_provider.dart';
import 'package:flutter_login_signup/src/widgets/Districts/districts_dropDown_button_widget.dart';
import 'package:flutter_login_signup/src/widgets/alert_widgets.dart';
import 'package:flutter_login_signup/src/widgets/app_bar_widget.dart';
import 'package:flutter_login_signup/src/widgets/bezierContainer.dart';
import 'package:flutter_login_signup/src/widgets/button_widget.dart';
import 'package:flutter_login_signup/src/widgets/progress_indicator_widget.dart';
import 'package:flutter_login_signup/src/widgets/text_form_field_widget.dart';

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
	void handleDistrictDropdownValue(int newValue){
		if (newValue > 0){ 
			newHouse.districtId = newValue;
		}
	}
	

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
            			BezierContainer(),
            			Container(
              				padding: EdgeInsets.symmetric(horizontal: 20),
              				child: SingleChildScrollView(
                				child: Column(
                  					crossAxisAlignment: CrossAxisAlignment.center,
                  					mainAxisAlignment: MainAxisAlignment.center,
                  					children: <Widget>[
                    					SizedBox(height: 20,),
                    					_formWidget(),
                    					SizedBox(height: height * .14),
                  					],
                				),
              				),
            			),
						showLoading == true ? ProgressIndicatorWidget() : Container()
          			],
        		),
      		),
    	);
  	}



	Widget _appBarTiger({Widget leading}){
		return PreferredSize(
			preferredSize: Size.fromHeight(60.0), // here the desired height
			child: AppBarTiger(title: 'Nueva propiedad', leading: leading,)
		);
	}


  	Widget _formWidget() {
    	return Form(
			key: formKey,
			child: Column(
				children: <Widget>[
					TextFormFieldWidget(title: 'Dirección', enabled: true, initialValue: newHouse.address, obscureText: false, onSavedFunction: _onSavedAddress, textInputType: TextInputType.text, validator: _validatorAddress,),
					SizedBox(height: 10,),
					TextFormFieldWidget(title: 'Número', enabled: true, initialValue: newHouse.addressNumber.toString(), obscureText: false, onSavedFunction: _onSavedAddressNumber, textInputType: TextInputType.number, validator: _validatorAddressNumber,),
					SizedBox(height: 10,),
					TextFormFieldWidget(title: 'Ciudad', enabled: true, initialValue: newHouse.city, obscureText: false, onSavedFunction: _onSavedCity, textInputType: TextInputType.text, validator: _validatorCity,),
					SizedBox(height: 10,),
					DistrictsDropDownButtonWidget(handleDistrictDropdownValue: handleDistrictDropdownValue,),
					SizedBox(height: 20,),
					ButtonWidget(title: 'Crear', border: Colors.white, colorStart: Color(0xfffbb448), colorEnd: Color(0xfff7892b), colorText: Colors.white, onPressedFunction: _onPressedButton,)
				],
			)
    	);
  	} 

	void _onSavedAddress(String value){ newHouse.address = value; }
	void _onSavedAddressNumber(String value){ newHouse.addressNumber = int.parse(value) ; }
	void _onSavedCity(String value){ newHouse.city = value; }


	String _validatorAddress(String value){ return null; }
	String _validatorCity(String value){ return null;}
	String _validatorAddressNumber(String value){
		if (value.isEmpty){ 
			return 'Debe ingresar un número';
		} else { 
			if ( num.tryParse(value) == null || num.tryParse(value) == 0 ){ 
				return 'Debe ingresar un número';
			} else {
				return null;  
			}
		}
	}

	
	void _onPressedButton() async {
		if (!formKey.currentState.validate()) return null;
			
		setState(() { showLoading = true; });
		formKey.currentState.save();
		HousesProvider housesProvider = HousesProvider();
		Map<String, dynamic> response = await housesProvider.housesCreate(house: newHouse);
		setState(() { showLoading = false; });
		if(response["ok"] == true){ Navigator.pop(context);} 
		else { AlertWidgets.alertOkWidget(context, 'Error', response["message"], Icon(Icons.error)); }
		
	}
}




