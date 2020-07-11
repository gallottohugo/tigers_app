import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/Providers/users_provider.dart';
import 'package:flutter_login_signup/src/Widget/bezierContainer.dart';


class LoginPage extends StatefulWidget {
	final String title;
	LoginPage({Key key, this.title}) : super(key: key);
  	@override
  	_LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
	final formKey = GlobalKey<FormState>();
	String currentUser = "";
	String currentPassword = "";

  	
  	

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
						colors: [Color(0xfffbb448), Color(0xfff7892b)])
					),
					child: Text('Iniciar sesión', style: TextStyle(fontSize: 20, color: Colors.white),
				),
    	  	),
			onTap: () async {
				formKey.currentState.save();
				UserProvider userProvider = UserProvider();
				var response = userProvider.login(user: currentUser, password: currentPassword);
			},
    	);
  	}

  

  	Widget _emailPasswordWidget() {
		return Form(
			key: formKey,
			child: Column(
      			children: <Widget>[
					Container(
						margin: EdgeInsets.symmetric(vertical: 10),
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.start,
							children: <Widget>[
								Text("Usuario", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
								SizedBox(height: 10,),

								TextFormField(
									obscureText: false,
									decoration: InputDecoration(
										border: InputBorder.none,
										fillColor: Color(0xfff3f3f4),
										filled: true
									),
									onSaved: (String value){
										currentUser= value;
									},
								)
							],
						),
					),
					Container(
						margin: EdgeInsets.symmetric(vertical: 10),
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.start,
							children: <Widget>[
								Text("Contraseña", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
								SizedBox(height: 10,),
								TextFormField(
									obscureText: true,
									decoration: InputDecoration(
										border: InputBorder.none,
										fillColor: Color(0xfff3f3f4),
										filled: true
									),
									onSaved: (String value){
										currentPassword = value;
									},
								)
							],
						),
					),
      			],
			)
    	);
  	}


	void _onSavedUser(String value){ }
	void _onSavedPassword(String value){ currentPassword = value;}


  
  	@override
  	Widget build(BuildContext context) {
    	final height = MediaQuery.of(context).size.height;
		return Scaffold(
        	body: Container(
      			height: height,
      			child: Stack(
        			children: <Widget>[
          				Positioned(
              				top: -height * .15,
              				right: -MediaQuery.of(context).size.width * .4,
              				child: BezierContainer()),
          					Container(
            					padding: EdgeInsets.symmetric(horizontal: 20),
            					child: SingleChildScrollView(
              					child: Column(
                					crossAxisAlignment: CrossAxisAlignment.center,
                					mainAxisAlignment: MainAxisAlignment.center,
                					children: <Widget>[
										SizedBox(height: height * .2),
										SizedBox(height: 50),
										_emailPasswordWidget(),
										SizedBox(height: 20),
										_submitButton(),
										Container(
											padding: EdgeInsets.symmetric(vertical: 10),
											alignment: Alignment.centerRight,
											child: Text('¿Perdió su contraseña?', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
										),
                					],
              					),
							),
          				),
        			],
      			),
    		)
		);
  	}
}
