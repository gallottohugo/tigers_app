import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/models/house_model.dart';
import 'package:flutter_login_signup/src/models/user_model.dart';
import 'package:flutter_login_signup/src/pages/houses/houses_create_page.dart';
import 'package:flutter_login_signup/src/providers/houses_provider.dart';
import 'package:flutter_login_signup/src/widgets/app_bar_widget.dart';
import 'package:flutter_login_signup/src/widgets/bezierContainer.dart';
import 'package:flutter_login_signup/src/widgets/button_widget.dart';

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
										ButtonWidget(title: 'Nueva casa', colorEnd: Colors.white, colorText: Colors.black, colorStart: Color(0xfffbb448), onTapFunction: _onTapFunction,),
										SizedBox(height: 30,),
										Text('Listado de casas', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
										SizedBox(height: 20,),
                    					_houses(),
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
						) : Container(),
						Align(
							alignment: Alignment.bottomRight,
							child: Padding(
								padding: EdgeInsets.only(bottom: 40.0, right: 30.0),
								child: FloatingActionButton(
									backgroundColor: Color(0xfff7892b),
									child: Icon(Icons.add),
									onPressed: (){ },
								)
							)
						)
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
			child: AppBarTiger(title: 'Casas por cliente', leading: leading,)
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