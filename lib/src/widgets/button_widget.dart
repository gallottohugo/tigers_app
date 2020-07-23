import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
	final String title;
	final Function onPressedFunction;
	final Color colorStart;
	final Color colorEnd;
	final Color border;
	final Color colorText;
	final Stream stream;
  	const ButtonWidget({
		Key key, 
		this.title, 
		this.onPressedFunction, 
		this.border, 
		this.colorEnd, 
		this.colorStart, 
		this.colorText,
		this.stream}) : super(key: key);

  	@override
  	Widget build(BuildContext context) {	
		/*
    	return GestureDetector(
			child: Container(
				width: MediaQuery.of(context).size.width,
				padding: EdgeInsets.symmetric(vertical: 15),
				alignment: Alignment.center,
				decoration: BoxDecoration(
					borderRadius: BorderRadius.all(Radius.circular(5)),
					gradient: LinearGradient(
						begin: Alignment.centerLeft,
						end: Alignment.centerRight,
						colors: [colorStart, colorEnd]
					)
				),
				child: Text(this.title, style: TextStyle(fontSize: 20, color: this.colorText)),
			),
			onTap: this.onTapFunction
    	);*/

		//formLoginStream

		return StreamBuilder(
		  	stream: stream,
		  	builder: (BuildContext context, AsyncSnapshot snapshot){
				return RaisedButton(
					elevation: 0,
					color: Colors.transparent,
					disabledColor: Colors.transparent,
					child: Container(
						width: MediaQuery.of(context).size.width,
						padding: EdgeInsets.symmetric(vertical: 15),
						alignment: Alignment.center,
						decoration: BoxDecoration(
							borderRadius: BorderRadius.all(Radius.circular(5)),
							gradient: LinearGradient(
								begin: Alignment.centerLeft,
								end: Alignment.centerRight,
								colors: snapshot.hasData ? [colorStart, colorEnd] : [Colors.grey, Colors.grey]
							)
						),
						child: Text(this.title, style: TextStyle(fontSize: 20, color: this.colorText)),
					),
					onPressed: snapshot.hasData ? this.onPressedFunction : null,
				);
		  	},
		);		
	}
}