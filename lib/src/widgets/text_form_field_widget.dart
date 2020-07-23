import 'package:flutter/material.dart';


class TextFormFieldWidget extends StatefulWidget {
	final String title;
	final String initialValue;
	final bool enabled;
	final Function onSavedFunction;
  	final Function onTapFunction;
	final Function onChangedFunction;
	final TextInputType textInputType;
	final bool obscureText;
	final TextEditingController controller;
	final Stream stream;

  	TextFormFieldWidget({
		Key key, 
		this.enabled, 
		this.initialValue, 
		this.onSavedFunction, 
		this.textInputType, 
		this.title, 
		this.obscureText = false, 
		this.onTapFunction, 
		this.onChangedFunction, 
		this.controller,
		this.stream}) : super(key: key);
  	_TextFormFieldWidgetState createState() => _TextFormFieldWidgetState();
}


class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  	@override
  	Widget build(BuildContext context) {
		return StreamBuilder(
		  	stream: widget.stream ,
		  	builder: (BuildContext context, AsyncSnapshot snapshot){
				  return Container(
					margin: EdgeInsets.symmetric(vertical: 10),
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: <Widget>[
							Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
							SizedBox(height: 10,),
							TextFormField(
								decoration: InputDecoration(
									border: InputBorder.none,
									fillColor: Color(0xfff3f3f4),
									filled: true,
									//counterText: snapshot.data
									errorText: snapshot.error
								),
								keyboardType: widget.textInputType,
								onSaved: widget.onSavedFunction,
								initialValue: widget.initialValue,
								enabled: widget.enabled,
								obscureText: widget.obscureText,
								onTap: widget.onTapFunction,
								onChanged: widget.onChangedFunction,
								controller: widget.controller,
							)
						],
					),
				);
		  	},
		);
  	}
}