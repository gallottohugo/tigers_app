import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/models/district_model.dart';
import 'package:flutter_login_signup/src/pages/districts/districts_create_page.dart';
import 'package:flutter_login_signup/src/providers/districts_provider.dart';
import 'package:flutter_login_signup/src/widgets/app_bar_widget.dart';
import 'package:flutter_login_signup/src/widgets/bezierContainer.dart';
import 'package:flutter_login_signup/src/widgets/button_floating_widget.dart';
import 'package:flutter_login_signup/src/widgets/progress_indicator_widget.dart';

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
            			BezierContainer(),
						Container(
              				padding: EdgeInsets.symmetric(horizontal: 20),
              				child: SingleChildScrollView(
                				child: Column(
                  					crossAxisAlignment: CrossAxisAlignment.start,
                  					mainAxisAlignment: MainAxisAlignment.center,
                  					children: <Widget>[
										SizedBox(height: 20,),
										_consignas()
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


	void _onTapFunction(){
		Navigator.pushNamed(context, DistrictsCreatePage.routeName);
	}

	Widget _appBarTiger({Widget leading}){
		return PreferredSize(
			preferredSize: Size.fromHeight(60.0), // here the desired height
			child: AppBarTiger(title: 'Consignas', leading: leading,)
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
					return ProgressIndicatorWidget();
				}
		  	},
		);
	}
}