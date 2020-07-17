import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/models/user_model.dart';
import 'package:flutter_login_signup/src/widgets/Users/user_card.dart';

class ColumnUser extends StatelessWidget {
 	final List<UserModel> userModelList;
  	const ColumnUser({Key key, @required this.userModelList}) : super(key: key);

  	@override
  	Widget build(BuildContext context) {
		return Column(
			children: new List<Widget>.generate(userModelList.length, (int index) {
				return Column(
					children: <Widget>[
						UserCard(userModel:userModelList[index])
					],
				);
			})
		);
	} 
}