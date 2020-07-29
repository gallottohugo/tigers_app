import 'dart:ui';

import 'package:flutter/material.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  	const ProgressIndicatorWidget({Key key}) : super(key: key);

  	@override
  	Widget build(BuildContext context) {
		return Container(
			padding: EdgeInsets.only(top: 20, bottom: 20),
			child: Center(
					child: CircularProgressIndicator(
					backgroundColor: Colors.transparent,
					valueColor: new AlwaysStoppedAnimation<Color>(Color(0xffe46b10)),
				)
			)
		);
  	}
}