import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/models/user_model.dart';
import 'package:flutter_login_signup/src/pages/users/users_houses_page.dart';

class UserCard extends StatelessWidget {
	final UserModel userModel;
  	const UserCard({Key key, @required this.userModel}) : super(key: key);

  	@override
  	Widget build(BuildContext context) {
    	return GestureDetector(
			child: Card(
				shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
				child: Container(
					decoration: BoxDecoration(
						border: Border.all(color: Color(0xfff7892b)),
						borderRadius: BorderRadius.circular(10.0),
					),
					child: userModel.userType == 'customer' ? ListTileCustomer(customer: userModel,) : ListTileUser(userModel: userModel,)
				),
			),
			onTap: (){
				if (userModel.userType == 'customer'){
					Navigator.pushNamed(context, UsersHousesPage.routeName, arguments: {'customer': userModel});
				}
			},
		);
  	}
}



class ListTileUser extends StatelessWidget {
	final UserModel userModel;
  	const ListTileUser({Key key, @required this.userModel}) : super(key: key);

  	@override
  	Widget build(BuildContext context) {
		return ListTile(
			leading: Icon(Icons.account_circle, color: Color(0xfff7892b), size: 35,),
			title: Text('${userModel.lastName}, ${userModel.name}.'),
			subtitle: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: <Widget>[
					Text('${userModel.email}'),
					SizedBox(height: 5),
					Text('${userModel.userTypeES()}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
				],
			),
			trailing: Icon(Icons.navigate_next),
		);
  	}
}

class ListTileCustomer extends StatelessWidget {
	final UserModel customer;
  	const ListTileCustomer({Key key, @required this.customer}) : super(key: key);

  	@override
  	Widget build(BuildContext context) {
		return ListTile(
			leading: Icon(Icons.account_circle, color: Color(0xfff7892b), size: 35,),
			title: Text('${customer.lastName}, ${customer.name}.'),
			subtitle: Text('${customer.email}'),
			trailing: Icon(Icons.navigate_next),
		);
  	}
}