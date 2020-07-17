import 'package:flutter/material.dart';


class TextFormFieldWidget extends StatefulWidget {
	final String title;
	final String initialValue;
	final bool enabled;
	final Function onSaved;
  	final Function onTap;
	final Function onChanged;
	final TextInputType textInputType;
	final bool obscureText;
	final TextEditingController controller;

  	TextFormFieldWidget({Key key, this.enabled, this.initialValue, this.onSaved, this.textInputType, this.title, this.obscureText = true, this.onTap, this.onChanged, this.controller}) : super(key: key);
  	_TextFormFieldWidgetState createState() => _TextFormFieldWidgetState();
}


class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  	@override
  	Widget build(BuildContext context) {
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
							filled: true
						),
						keyboardType: widget.textInputType,
						onSaved: widget.onSaved,
						initialValue: widget.initialValue,
						enabled: widget.enabled,
						obscureText: widget.obscureText,
						onTap: widget.onTap,
						onChanged: widget.onChanged,
						controller: widget.controller,
					)
        		],
      		),
    	);
  	
  }
}