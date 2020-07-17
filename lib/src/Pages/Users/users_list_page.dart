import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/models/user_model.dart';
import 'package:flutter_login_signup/src/pages/users/users_create_page.dart';
import 'package:flutter_login_signup/src/providers/users_provider.dart';
import 'package:flutter_login_signup/src/widgets/Users/colum_user.dart';
import 'package:flutter_login_signup/src/widgets/app_bar_widget.dart';
import 'package:flutter_login_signup/src/widgets/bezierContainer.dart';
import 'package:flutter_login_signup/src/widgets/button_floating_widget.dart';
import 'package:flutter_login_signup/src/widgets/progress_indicator_widget.dart';
import 'package:flutter_login_signup/src/widgets/search_widget.dart';

class UsersListPage extends StatefulWidget {
	static final String routeName = 'users_list_page';
  	UsersListPage({Key key}) : super(key: key);
  	_UsersListPageState createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
	UserProvider userProvider = UserProvider();
	List<UserModel> usersList = List<UserModel>();
	List<UserModel> usersListFiltered = List<UserModel>();
	bool firstTime = true;

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
                  					crossAxisAlignment: CrossAxisAlignment.start,
                  					mainAxisAlignment: MainAxisAlignment.center,
                  					children: <Widget>[
										SizedBox(height: 20,),
										SearchWidget(onChanged: _onChanged),
										SizedBox(height: 30,),
										firstTime ? _users() : ColumnUser(userModelList: usersListFiltered,),
									]
								)
							)
						),
						ButtonFloatingWidget(colorButton: Colors.green, icon: Icons.add, colorIcon: Colors.white, onPressed: _onTapFunction, )
					]
				)
			)
		);
  	}


	void _onChanged(value) async {
		firstTime = false;
		List<UserModel> response = await filter(value);
		setState(() { usersListFiltered = response; });
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
					usersList = snapshot.data;
					return Container(child: ColumnUser(userModelList: usersList)); 
				} else {
					return ProgressIndicatorWidget();
				}
		  	},
		);
	}


	Future<List<UserModel>> filter(String value) async {
		if (value == "") return usersList;
		try {
			List<UserModel> _filter = usersList.where((item) => item.name.toLowerCase().contains(value.toLowerCase()) || item.lastName.toLowerCase().contains(value.toLowerCase())).toList();
			return _filter;
		} catch(e) {  return List<UserModel>();  }
	}



	


	
}