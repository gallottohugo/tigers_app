import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/models/user_model.dart';
import 'package:flutter_login_signup/src/pages/districts/districts_list_page.dart';
import 'package:flutter_login_signup/src/pages/_guards/guards_create_page.dart';
import 'package:flutter_login_signup/src/pages/users/users_customers_list_page.dart';
import 'package:flutter_login_signup/src/pages/users/users_list_page.dart';
import 'package:flutter_login_signup/src/pages/users/users_login_page.dart';
import 'package:flutter_login_signup/src/preferences/preferences.dart';

class DrawerWidget extends StatefulWidget {
  	DrawerWidget({Key key}) : super(key: key);
  	_DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  	@override
  	Widget build(BuildContext context) {
    	return Drawer( 
			child: Container(
				child: ListView(
					children: <Widget>[
						Container(
							color: Color(0xfff7892b),
							height: 150,
							child: Row(
								children: <Widget>[
									Container(
										padding: EdgeInsets.all(10),
										child: CircleAvatar(maxRadius: 35,),
									),
									Container(
										child: Column(
											mainAxisAlignment: MainAxisAlignment.center,
											crossAxisAlignment: CrossAxisAlignment.start,
											children: <Widget>[
												Text(UserModel.currentUser.userTypeES()),
												Text('${UserModel.currentUser.lastName}, ${UserModel.currentUser.name}'),
												Text('${UserModel.currentUser.email}'),
											],
										),
									)
								],
							),
						),
						UserModel.currentUser.admin == true ? ListTile(
							leading: Container(width: 50.0, child: Icon(Icons.account_circle, color: Color(0xfff7892b),)),
							trailing: Icon(Icons.navigate_next, color: Color(0xfff7892b),),
							title: Text('Usuarios'),
							onTap: (){ Navigator.pushNamed(context, UsersListPage.routeName); },
						) : Container(),
						UserModel.currentUser.admin == true ? Divider(color: Color(0xfff7892b),) : Container(),
						
						UserModel.currentUser.coordinator() == true ? ListTile(
							leading: Container(width: 50.0, child: Icon(Icons.face, color: Color(0xfff7892b),)),
							trailing: Icon(Icons.navigate_next, color: Color(0xfff7892b),),
							title: Text('Clientes'),
							onTap: (){	
								Navigator.pushNamed(context, UsersCustomersListPage.routeName);
							},
						) : Container(),
						UserModel.currentUser.coordinator() == true ? Divider(color: Color(0xfff7892b),) : Container(),

						UserModel.currentUser.coordinator() == true ? ListTile(
							leading: Container(width: 50.0, child: Icon(Icons.place, color: Color(0xfff7892b),)),
							trailing: Icon(Icons.navigate_next, color: Color(0xfff7892b),),
							title: Text('Consignas'),
							onTap: (){	
								Navigator.pushNamed(context, DistrictsListPage.routeName);
							},
						) : Container(),
						UserModel.currentUser.coordinator() == true ? Divider(color: Color(0xfff7892b),) : Container(),

						ListTile(
							leading: Container(width: 50.0, child: Icon(Icons.work, color: Color(0xfff7892b),)),
							trailing: Icon(Icons.navigate_next, color: Color(0xfff7892b)),
							title: Text('Guardias'),
							onTap: (){ 
								Navigator.pushNamed(context, GuardsCreatePage.routeName);
							},
						),
						Divider(color: Color(0xfff7892b)),
						
						ListTile(
							leading: Container(width: 50.0, child: Icon(Icons.close, color: Color(0xfff7892b),)),
							trailing: Icon(Icons.navigate_next, color: Color(0xfff7892b)),
							title: Text('Cerrar sesión'),
							onTap: (){
								Preferences.clearPreferences();
								Navigator.pushNamed(context, UsersLoginPage.routeName);
							},
						),
						Divider(color: Color(0xfff7892b))
					]
				),
			)	
		);
  	}
}