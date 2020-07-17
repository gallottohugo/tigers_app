import 'package:flutter/material.dart';

class ButtonFloatingWidget extends StatelessWidget {
	final Color colorIcon;
	final Color colorButton;
	final IconData icon;
	final Function onPressed;
  	const ButtonFloatingWidget({Key key, this.colorButton, this.colorIcon, this.icon, this.onPressed}) : super(key: key);

  	@override
  	Widget build(BuildContext context) {
    	return Align(
			alignment: Alignment.bottomRight,
			child: Padding(
				padding: EdgeInsets.only(bottom: 40.0, right: 30.0),
				child: FloatingActionButton(
					backgroundColor: this.colorButton ,
					child: Icon(this.icon, color: colorIcon,),
					onPressed: this.onPressed
				)
			)
		);
  	}
}