import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/models/district_model.dart';
import 'package:flutter_login_signup/src/pages/districts/districts_create_page.dart';
import 'package:flutter_login_signup/src/providers/districts_provider.dart';
import 'package:flutter_login_signup/src/widgets/app_bar_widget.dart';
import 'package:flutter_login_signup/src/widgets/bezierContainer.dart';
import 'package:flutter_login_signup/src/widgets/button_widget.dart';

class DistrictsListPage extends StatefulWidget {
	static final String routeName = 'district_list_page';
  	DistrictsListPage({Key key}) : super(key: key);
  	_DistrictsListPageState createState() => _DistrictsListPageState();
}

class _DistrictsListPageState extends State<DistrictsListPage> {
  	DistrictsProvider districtProvider = DistrictsProvider();
  	
	  
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
										ButtonWidget(title: 'Nueva consigna', colorEnd: Colors.white, colorText: Colors.black, colorStart: Color(0xfffbb448), onTapFunction: _onTapFunction,),
										SizedBox(height: 30,),
										Text('Listado de consignas', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
										_consignas()
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
		Navigator.pushNamed(context, DistrictsCreatePage.routeName);
	}

	Widget _appBarTiger({Widget leading}){
		return PreferredSize(
			preferredSize: Size.fromHeight(60.0), // here the desired height
			child: AppBarTiger(title: 'Usuarios', leading: leading,)
		);
	}



	Widget _consignas(){
		return FutureBuilder(
		  	future: districtProvider.districtsList(),
		  	initialData: null,
		  	builder: (BuildContext context, AsyncSnapshot<List<DistrictModel>> snapshot) {
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
											  		leading: Icon(Icons.place, color: Color(0xfff7892b), size: 35,),
											  		title: Text('${snapshot.data[index].name}'),
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