import 'dart:ui';

import 'package:flutter/material.dart';

class ProgressIndicatorPageWidget extends StatelessWidget {
    const ProgressIndicatorPageWidget({Key key}) : super(key: key);

  	@override
  	Widget build(BuildContext context) {
		return Container(
		  child: AbsorbPointer(
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
		  ),
		);
  	}
}