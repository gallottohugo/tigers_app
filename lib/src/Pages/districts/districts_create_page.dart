import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/models/district_model.dart';
import 'package:flutter_login_signup/src/providers/districts_provider.dart';
import 'package:flutter_login_signup/src/widgets/alert_widgets.dart';
import 'package:flutter_login_signup/src/widgets/bezierContainer.dart';

class DistrictsCreatePage extends StatefulWidget {
	static final String routeName = 'district_create_page';
    DistrictsCreatePage({Key key}) : super(key: key);
  	_DistrictsCreatePageState createState() => _DistrictsCreatePageState();
}

class _DistrictsCreatePageState extends State<DistrictsCreatePage> {
	bool showLoading = false;
	final formKey = GlobalKey<FormState>();
	DistrictModel newDistrict = DistrictModel();


  	@override
  	Widget build(BuildContext context) {
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
			child: _appBarTiger(leading: leading,)
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
					boxShadow: <BoxShadow>[BoxShadow(color: Colors.grey.shade200,offset: Offset(2, 4),blurRadius: 5,spreadRadius: 2)],
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
				DistrictsProvider districtsProvider = DistrictsProvider();
				Map<String, dynamic> response = await districtsProvider.districtsCreate(district: newDistrict);
				setState(() { showLoading = false; });
				if (response["ok"] == true) {
					Navigator.pop(context);
				} else {
					AlertWidgets.alertOkWidget(context, 'Error', response["message"], Icon(Icons.error));
				}
				
			},
    	);
	}

	


	void _onSavedName(String value){ newDistrict.name = value; }
	

  	Widget _formWidget() {
    	return Form(
			key: formKey,
			child: Column(
				children: <Widget>[
					_entryField("Nombre", onSaved: _onSavedName, enabled: true, initialValue: '', textInputType: TextInputType.text),
				],
			)
    	);
  	} 
}