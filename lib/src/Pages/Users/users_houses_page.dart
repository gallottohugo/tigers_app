import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/models/user_model.dart';
import 'package:flutter_login_signup/src/widgets/app_bar_widget.dart';
import 'package:flutter_login_signup/src/widgets/bezierContainer.dart';

class UsersHousesPage extends StatefulWidget {
	static final String routeName = 'houses_new_page';
    UsersHousesPage({Key key}) : super(key: key);
  	_UsersHousesPageState createState() => _UsersHousesPageState();
}

class _UsersHousesPageState extends State<UsersHousesPage> {
	UserModel customer = UserModel();
	bool showLoading = false;
  	@override
  	Widget build(BuildContext context) {
		Map<String, dynamic> mapsArgument = ModalRoute.of(context).settings.arguments;
		customer.userType = mapsArgument['user_type'];

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
                    					//_formWidget(),
                    					SizedBox(height: 20,),
                    					//_submitButton(),
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
			child: AppBarTiger(title: 'Agregar Casa', leading: leading,)
		);
	}
}