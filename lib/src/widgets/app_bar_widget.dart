import 'package:flutter/material.dart';

class AppBarTiger extends StatefulWidget {
	final String title;
	final Widget leading;
    AppBarTiger({Key key, this.leading, @required this.title}) : super(key: key);
  	_AppBarTigerState createState() => _AppBarTigerState();
}

class _AppBarTigerState extends State<AppBarTiger> {
    @override
  	Widget build(BuildContext context) {
    	return AppBar(
			title: Text(widget.title, style: TextStyle(fontSize: 20.0)),
			backgroundColor: Color(0xfff7892b),
			centerTitle: false,
			leading:  widget.leading,
		);
  	}
}