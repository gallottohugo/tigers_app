import 'package:flutter/material.dart';

class AlertWidgets {
  	static Future<void> alertOkWidget(BuildContext context, String title, String description, Icon icon){
		return showDialog(
			context: context,
			barrierDismissible: true,
			builder: (context){
				return AlertDialog(
					title: Text(title),
					content: Column(
						mainAxisSize: MainAxisSize.min,
						children: <Widget>[ListTile(leading: icon, title: Text(description))],
					),
					actions: <Widget>[
						FlatButton(
							child: Text('ok'),
							onPressed: ()=> Navigator.of(context).pop(),
						)
					],
				);
			}	 
		);
	}
}