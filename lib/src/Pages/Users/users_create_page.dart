import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/blocs/provider_bloc.dart';
import 'package:flutter_login_signup/src/models/user_model.dart';
import 'package:flutter_login_signup/src/providers/users_provider.dart';
import 'package:flutter_login_signup/src/widgets/alert_widgets.dart';
import 'package:flutter_login_signup/src/widgets/app_bar_widget.dart';
import 'package:flutter_login_signup/src/widgets/bezierContainer.dart';
import 'package:flutter_login_signup/src/widgets/button_widget.dart';
import 'package:flutter_login_signup/src/widgets/progress_indicator_widget.dart';
import 'package:flutter_login_signup/src/widgets/text_form_field_widget.dart';

class UsersCreatePage extends StatefulWidget {
	static final String routeName = 'signup_page';
  	UsersCreatePage({Key key}) : super(key: key);

  	@override
  	_UsersCreatePageState createState() => _UsersCreatePageState();
}

class _UsersCreatePageState extends State<UsersCreatePage> {
	String dropdownValue = "Administrador";
	final formKey = GlobalKey<FormState>();
	bool showLoading = false;
	UserModel newUser = UserModel();

	@override
  	Widget build(BuildContext context) {
		Map<String, dynamic> mapsArgument = ModalRoute.of(context).settings.arguments;
		newUser.userType = mapsArgument['user_type'];
		if (newUser.userType == 'customer'){ dropdownValue = 'Cliente'; }

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
			child: AppBarTiger(title: newUser.userType == 'customer' ? 'Crear cliente' : 'Crear usuario', leading: leading,)
		);
	}

	  


  	Widget _formWidget() {
		final providerBloc = ProviderBloc.of(context);

    	return Form(
			key: formKey,
			child: Column(
				children: <Widget>[
					TextFormFieldWidget(
						title: "Nombre", 
						onSavedFunction: _onSavedName, 
						enabled: true, 
						textInputType: TextInputType.text
										
					),
					SizedBox(height: 10,),
					TextFormFieldWidget(title: "Apellido", onSavedFunction: _onSavedLastName, enabled: true, initialValue: '', textInputType: TextInputType.text),
					SizedBox(height: 10),
					TextFormFieldWidget(title: "Email", onSavedFunction: _onSavedEmail, enabled: true, initialValue: '', textInputType: TextInputType.emailAddress),
					SizedBox(height: 10,),
					TextFormFieldWidget(title: "Teléfono", onSavedFunction: _onSavedPhone, enabled: true, initialValue: '', textInputType: TextInputType.phone),
					SizedBox(height: 10,),
					newUser.userType == 'customer' ? TextFormFieldWidget(title: "Tipo de usuario", enabled: false, initialValue: 'Cliente', textInputType: TextInputType.text) : _dropDownField() ,
					SizedBox(height: 20,),
					ButtonWidget(title: 'Crear',  border: Colors.white, colorStart: Color(0xfffbb448), colorEnd: Color(0xfff7892b), colorText: Colors.white, onPressedFunction: _onTapButton, )
				],
			)
    	);
  	} 


	void _onSavedName(String value){ newUser.name = value; }
	void _onSavedLastName(String value){ newUser.lastName = value; }
	void _onSavedEmail(String value){ newUser.email = value; }
	void _onSavedPhone(String value){ newUser.phone = value; }


	void _onTapButton() async {
		setState(() { showLoading = true; });
		formKey.currentState.save();
		UserProvider userProvider = UserProvider();
		newUser.userType = dropdownValue;
		Map<String, dynamic> response = await userProvider.usersSignup(user: newUser);
		setState(() { showLoading = false; });
		if (response["ok"] == true) {
			if (newUser.userType == 'customer'){
				Navigator.pop(context);
			} else {
				await AlertWidgets.alertOkWidget(context, 'Usuario creado', 'El usuario se creó correctamente', Icon(Icons.check_circle));
				Navigator.pop(context);
			}
		} else {
			AlertWidgets.alertOkWidget(context, 'Error', response["message"], Icon(Icons.error));
		}
	}


	Widget _dropDownField() {
		return Container(
      		margin: EdgeInsets.symmetric(vertical: 10),
      		child: Column(
        		crossAxisAlignment: CrossAxisAlignment.start,
        		children: <Widget>[
					Text('Tipo de usuario', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
					SizedBox(height: 10,),
					DropdownButton<String>(
						isExpanded: true,
						value: dropdownValue,
						underline: Container(),
						elevation: 16,
						onChanged: (String newValue) { 
							setState(() { 
								dropdownValue = newValue;
							}); 
						},
						items: <String>['Administrador', 'Coordinador', 'Empleado'].map<DropdownMenuItem<String>>((String value) {
							return DropdownMenuItem<String>(
								value: value,
								child: Text(value),
							);
						}).toList(),
					)
        		],
      		),
    	);
	}
}
