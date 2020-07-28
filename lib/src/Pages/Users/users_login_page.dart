import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/Providers/users_provider.dart';
import 'package:flutter_login_signup/src/blocs/provider_bloc.dart';
import 'package:flutter_login_signup/src/pages/home/home_page.dart';
import 'package:flutter_login_signup/src/widgets/alert_widgets.dart';
import 'package:flutter_login_signup/src/widgets/app_bar_widget.dart';
import 'package:flutter_login_signup/src/widgets/bezierContainer.dart';
import 'package:flutter_login_signup/src/widgets/button_bloc_widget.dart';
import 'package:flutter_login_signup/src/widgets/progress_indicator_widget.dart';
import 'package:flutter_login_signup/src/widgets/text_form_field_bloc_widget.dart';


class UsersLoginPage extends StatefulWidget {
	static final String routeName = 'login_page';
	UsersLoginPage({Key key}) : super(key: key);
  	@override
  	_UsersLoginPageState createState() => _UsersLoginPageState();
}

class _UsersLoginPageState extends State<UsersLoginPage> {
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
									child: _loginForm(height)
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


	Widget _loginForm(double height){
		final providerBloc = ProviderBloc.of(context);
		return Column(
			crossAxisAlignment: CrossAxisAlignment.center,
			mainAxisAlignment: MainAxisAlignment.center,
			children: <Widget>[
				SizedBox(height: height * .2),
				SizedBox(height: 80),
				TextFormFieldBlocWidget(title: 'Correo electrónico', enabled: true, initialValue: '', obscureText: false, textInputType: TextInputType.emailAddress, stream: providerBloc.emailStream, onChangedFunction: providerBloc.changeEmail,),
				SizedBox(height: 20),
				TextFormFieldBlocWidget(title: 'Contraseña', enabled: true, obscureText: true,  textInputType: TextInputType.text, stream: providerBloc.passwordStream, onChangedFunction: providerBloc.changePassword,),
				SizedBox(height: 20),
				ButtonBlocWidget(border: Colors.white, title: 'Iniciar sesión', colorStart: Color(0xfffbb448), colorEnd: Color(0xfff7892b),  colorText: Colors.white,  onPressedFunction: ()=> _onPressedLogin(providerBloc), stream: providerBloc.formLoginStream,),
				SizedBox(height: 20),
				Container(alignment: Alignment.centerRight,child: Text('¿Perdió su contraseña?', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500))),
			],
		);
	}

	
	void _onPressedLogin(LoginBloc loginBloc) async {
		try {
			setState(() { showLoading = true; });
			UserProvider userProvider = UserProvider();
			Map<String, dynamic> response = await userProvider.usersLogin(user: loginBloc.emailLastValue, password: loginBloc.passwordLastValue);
			setState(() { showLoading = false; });
			if (response["ok"] == true){
				Navigator.pushReplacementNamed(context, HomePage.routeName);
			} else {
				AlertWidgets.alertOkWidget(context, 'Error', 'Ocurrió un error, vuelva a intentarlo!', Icon(Icons.error));
			}		
		} catch(exc){
			setState(() { showLoading = false; });
		}
	}


  	
}
