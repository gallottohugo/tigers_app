import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/models/house_model.dart';
import 'package:flutter_login_signup/src/models/user_model.dart';
import 'package:flutter_login_signup/src/pages/houses/houses_create_page.dart';
import 'package:flutter_login_signup/src/providers/houses_provider.dart';
import 'package:flutter_login_signup/src/widgets/app_bar_widget.dart';
import 'package:flutter_login_signup/src/widgets/bezierContainer.dart';
import 'package:flutter_login_signup/src/widgets/button_floating_widget.dart';
import 'package:flutter_login_signup/src/widgets/progress_indicator_widget.dart';

class UsersHousesPage extends StatefulWidget {
	static final String routeName = 'houses_new_page';
    UsersHousesPage({Key key}) : super(key: key);
  	_UsersHousesPageState createState() => _UsersHousesPageState();
}

class _UsersHousesPageState extends State<UsersHousesPage> {
	UserModel customer = UserModel();
	bool showLoading = false;
	HousesProvider houseProvider = HousesProvider();

  	@override
  	Widget build(BuildContext context) {
		Map<String, dynamic> mapsArgument = ModalRoute.of(context).settings.arguments;
		customer = mapsArgument['customer'];

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
                    					_houses(),
                    					SizedBox(height: height * .14),
                  					],
                				),
              				),
            			),
						showLoading == true ? ProgressIndicatorWidget() : Container(),
						ButtonFloatingWidget(colorButton: Colors.green, colorIcon: Colors.white, icon: Icons.add, onPressed: _onTapFunction,),  
          			],
        		),
      		),
    	);
  	}


	void _onTapFunction(){
		Navigator.pushNamed(context, HousesCreatePage.routeName, arguments: {'customer': customer });

	}

	Widget _appBarTiger({Widget leading}){
		return PreferredSize(
			preferredSize: Size.fromHeight(60.0), // here the desired height
			child: AppBarTiger(title: 'Propiedades de un cliente', leading: leading,)
		);
	}



	Widget _houses(){
		return FutureBuilder(
		  	future: houseProvider.housesList(customerId: customer.id ),
		  	initialData: null,
		  	builder: (BuildContext context, AsyncSnapshot<List<HouseModel>> snapshot) {
				if (snapshot.hasData){
					return Container(
						child: Column(
							children: new List<Widget>.generate(snapshot.data.length, (int index) {
								return Column(
									children: <Widget>[
										Card(
											shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
											child: Container(
												decoration: BoxDecoration(
													border: Border.all(color: Color(0xfff7892b)),
													borderRadius: BorderRadius.circular(10.0),
												),
											  	child: ListTile(
											  		leading: Icon(Icons.home, color: Color(0xfff7892b), size: 35,),
											  		title: Text('${snapshot.data[index].address} ${snapshot.data[index].addressNumber}'),
											  		subtitle: Text('${snapshot.data[index].city}'),
										  		),
											),
										),
									],
								);
							})
						) 
					); 
				} else {
					return ProgressIndicatorWidget();
				}
		  	},
		);
	}
}