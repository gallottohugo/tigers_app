import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/models/district_model.dart';
import 'package:flutter_login_signup/src/providers/districts_provider.dart';
import 'package:flutter_login_signup/src/utils/validators.dart';
import 'package:flutter_login_signup/src/widgets/alert_widgets.dart';
import 'package:flutter_login_signup/src/widgets/app_bar_widget.dart';
import 'package:flutter_login_signup/src/widgets/bezierContainer.dart';
import 'package:flutter_login_signup/src/widgets/button_widget.dart';
import 'package:flutter_login_signup/src/widgets/progress_indicator_page_widget.dart';
import 'package:flutter_login_signup/src/widgets/text_form_field_widget.dart';

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
                  					],
                				),
              				),
            			),
						showLoading == true ? ProgressIndicatorPageWidget() : Container()
          			],
        		),
      		),
    	);
  	}



	Widget _appBarTiger({Widget leading}){
		return PreferredSize(
			preferredSize: Size.fromHeight(60.0), 
			child: AppBarTiger(title: 'Nueva consignas', leading: leading,)
		);
	}
	void _onSavedName(String value){ newDistrict.name = value; }


	void _onTapButton() async {
		if (!formKey.currentState.validate()) return null;

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
	}
	

  	Widget _formWidget() {
    	return Form(
			key: formKey,
			child: Column(
				children: <Widget>[
					TextFormFieldWidget(title: 'Nombre', enabled: true, initialValue: '', obscureText: false, onSavedFunction: _onSavedName, textInputType: TextInputType.text, validator: Validators.validateName),
					SizedBox(height: 20,),
					ButtonWidget(title: 'Crear', border: Colors.white, colorStart: Color(0xfffbb448), colorEnd: Color(0xfff7892b), colorText: Colors.black, onPressedFunction: _onTapButton,)
				],
			)
    	);
  	}
}
