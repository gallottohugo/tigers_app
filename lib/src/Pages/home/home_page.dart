import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/widgets/app_bar_widget.dart';
import 'package:flutter_login_signup/src/widgets/bezierContainer.dart';
import 'package:flutter_login_signup/src/widgets/drawer_widget.dart';

class HomePage extends StatefulWidget {
	static final String routeName = 'home_page';
    HomePage({Key key}) : super(key: key);
    _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  	@override
  	Widget build(BuildContext context) {
    	final height = MediaQuery.of(context).size.height;
		return Scaffold(
			drawer: DrawerWidget(),
			appBar: _appBarTiger(),
        	body: Container(
      			height: height,
      			child: Stack(
        			children: <Widget>[
          				BezierContainer()
					]
				)
			)
		);
  	}



	Widget _appBarTiger({Widget leading}){
		return PreferredSize(
			preferredSize: Size.fromHeight(60.0), // here the desired height
			child: AppBarTiger(title: 'Grupo Tigre', leading: leading,)
		);
	}

}