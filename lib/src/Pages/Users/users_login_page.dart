import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/Providers/users_provider.dart';
import 'package:flutter_login_signup/src/pages/home/home_page.dart';
import 'package:flutter_login_signup/src/widgets/alert_widgets.dart';
import 'package:flutter_login_signup/src/widgets/app_bar_widget.dart';
import 'package:flutter_login_signup/src/widgets/bezierContainer.dart';
import 'package:flutter_login_signup/src/widgets/button_widget.dart';
import 'package:flutter_login_signup/src/widgets/progress_indicator_widget.dart';
import 'package:flutter_login_signup/src/widgets/text_form_field_widget.dart';


class UsersLoginPage extends StatefulWidget {
	static final String routeName = 'login_page';
	UsersLoginPage({Key key}) : super(key: key);
  	@override
  	_UsersLoginPageState createState() => _UsersLoginPageState();
}

class _UsersLoginPageState extends State<UsersLoginPage> {
	final formKey = GlobalKey<FormState>();
	String currentUser = "";
	String currentPassword = "";
	bool showLoading = false;


  	@override
  	Widget build(BuildContext context) {
    	final height = MediaQuery.of(context).size.height;
		return WillPopScope(
    		onWillPop: () async => false,
    		child: Scaffold(
				appBar: _appBarTiger(),
				body: Container(
					height: height,
					child: Stack(
						children: <Widget>[
							BezierContainer(),
							Container(
								padding: EdgeInsets.symmetric(horizontal: 20),
								child: SingleChildScrollView(
									child: Form(
										key: formKey,
										child: Column(
											crossAxisAlignment: CrossAxisAlignment.center,
											mainAxisAlignment: MainAxisAlignment.center,
											children: <Widget>[
												SizedBox(height: height * .2),
												SizedBox(height: 80),
												TextFormFieldWidget(title: 'Correo electrónico', enabled: true, initialValue: '', obscureText: false, onSaved: _onSavedUser, textInputType: TextInputType.emailAddress,),
												SizedBox(height: 10),
												TextFormFieldWidget(title: 'Contraseña', enabled: true, initialValue: '', obscureText: true, onSaved: _onSavedPassword, textInputType: TextInputType.text,),
												SizedBox(height: 20),
												ButtonWidget(border: Colors.white, title: 'Iniciar sesión', colorStart: Color(0xfffbb448), colorEnd: Color(0xfff7892b), colorText: Colors.white, onTapFunction: _onTapButton,),
												Container(
													padding: EdgeInsets.symmetric(vertical: 10),
													alignment: Alignment.centerRight,
													child: Text('¿Perdió su contraseña?', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
												),
											],
									  	),
									),
								),
							),
							showLoading == true ? ProgressIndicatorWidget() : Container()
						],
					),
				)
			)
		);
	}

	Widget _appBarTiger(){
		return PreferredSize(
			preferredSize: Size.fromHeight(60.0), // here the desired height
			child: AppBarTiger(title: 'Grupo Tigre', leading: Container(),)
		);
	}

	void _onSavedUser(String value){ currentUser = value; }
	void _onSavedPassword(String value){ currentPassword = value; }

	void _onTapButton() async {
		try{
			setState(() { showLoading = true; });
			formKey.currentState.save();
			UserProvider userProvider = UserProvider();
			Map<String, dynamic> response = await userProvider.usersLogin(user: currentUser, password: currentPassword);
			setState(() { showLoading = false; });
			if (response["ok"] == true){
				Navigator.pushNamed(context, HomePage.routeName);
			} else {
				AlertWidgets.alertOkWidget(context, 'Error', 'Ocurrió un error, vuelva a intentarlo!', Icon(Icons.error));
			}		
		} catch(exc){
			setState(() { showLoading = false; });
		}
	}


  	
}
