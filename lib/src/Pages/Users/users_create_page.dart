import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/models/user_model.dart';
import 'package:flutter_login_signup/src/providers/users_provider.dart';
import 'package:flutter_login_signup/src/widgets/alert_widgets.dart';
import 'package:flutter_login_signup/src/widgets/app_bar_widget.dart';
import 'package:flutter_login_signup/src/widgets/bezierContainer.dart';

class UsersCreatePage extends StatefulWidget {
	static final String routeName = 'signup_page';
	final String title;
  	UsersCreatePage({Key key, this.title}) : super(key: key);

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
		if (newUser.userType == 'customer'){
			dropdownValue = newUser.userType;
		}


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
			child: AppBarTiger(title: newUser.userType == 'customer' ? 'Crear cliente' : 'Crear usuario', leading: leading,)
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
				child: Text(newUser.userType == 'customer' ? 'Crear cliente' : 'Crear usuario', style: TextStyle(fontSize: 20, color: Colors.white)),
			),
			onTap: () async {
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
				
			},
    	);
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
								newUser.userType = newValue;
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


	void _onSavedName(String value){ newUser.name = value; }
	void _onSavedLastName(String value){ newUser.lastName = value; }
	void _onSavedEmail(String value){ newUser.email = value; }
	void _onSavedPhone(String value){ newUser.phone = value; }

	

  	Widget _formWidget() {
    	return Form(
			key: formKey,
			child: Column(
				children: <Widget>[
					_entryField("Nombre", onSaved: _onSavedName, enabled: true, initialValue: '', textInputType: TextInputType.text),
					SizedBox(height: 10,),
					_entryField("Apellido", onSaved: _onSavedLastName, enabled: true, initialValue: '', textInputType: TextInputType.text),
					SizedBox(height: 10),
					_entryField("Email", onSaved: _onSavedEmail, enabled: true, initialValue: '', textInputType: TextInputType.emailAddress),
					SizedBox(height: 10,),
					_entryField("Teléfono", onSaved: _onSavedPhone, enabled: true, initialValue: '', textInputType: TextInputType.phone),
					SizedBox(height: 10,),
					newUser.userType == 'customer' ? _entryField("Tipo de usuario", enabled: false, initialValue: 'Cliente', textInputType: TextInputType.text) : _dropDownField() ,
				],
			)
    	);
  	} 
}
