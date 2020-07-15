import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/models/user_model.dart';
import 'package:flutter_login_signup/src/pages/users/users_create_page.dart';
import 'package:flutter_login_signup/src/providers/users_provider.dart';
import 'package:flutter_login_signup/src/widgets/app_bar_widget.dart';
import 'package:flutter_login_signup/src/widgets/bezierContainer.dart';
import 'package:flutter_login_signup/src/widgets/button_widget.dart';

class UsersListPage extends StatefulWidget {
	static final String routeName = 'users_list_page';
  	UsersListPage({Key key}) : super(key: key);
  	_UsersListPageState createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
	UserProvider userProvider = UserProvider();
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
                  					crossAxisAlignment: CrossAxisAlignment.start,
                  					mainAxisAlignment: MainAxisAlignment.center,
                  					children: <Widget>[
										SizedBox(height: 20,),
										ButtonWidget(title: 'Nuevo usuario', colorEnd: Colors.white, colorText: Colors.black, colorStart: Color(0xfffbb448), onTapFunction: _onTapFunction,),
										SizedBox(height: 30,),
										Text('Listado de usuarios', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
										_users()
									]
								)
							)
						)
					]
				)
			)
		);
  	}


	void _onTapFunction(){
		Navigator.pushNamed(context, UsersCreatePage.routeName, arguments: {'user_type': ''});
	}

	Widget _appBarTiger({Widget leading}){
		return PreferredSize(
			preferredSize: Size.fromHeight(60.0), // here the desired height
			child: AppBarTiger(title: 'Usuarios', leading: leading,)
		);
	}



	Widget _users(){
		return FutureBuilder(
		  	future: userProvider.usersList(filter: 'users'),
		  	initialData: null,
		  	builder: (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
				if (snapshot.hasData){
					return Container(
						child: Column(
							children: new List<Widget>.generate(snapshot.data.length, (int index) {
								return Column(
									children: <Widget>[
										GestureDetector(
											child: Card(
												shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
												child: Container(
													decoration: BoxDecoration(
														border: Border.all(color: Color(0xfff7892b)),
														borderRadius: BorderRadius.circular(10.0),
													),
												  	child: ListTile(
												  		leading: Icon(Icons.account_circle, color: Color(0xfff7892b), size: 35,),
												  		title: Text('${snapshot.data[index].lastName}, ${snapshot.data[index].name}.'),
												  		subtitle: Column(
															crossAxisAlignment: CrossAxisAlignment.start,
															children: <Widget>[
																Text('${snapshot.data[index].email}'),
																SizedBox(height: 5),
																Text('${snapshot.data[index].userTypeES()}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
															],
														),
												  		trailing: Icon(Icons.navigate_next),
											  		),
												),
											)
										),
									],
								);
							})
						) 
					); 
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
		);
	}
}