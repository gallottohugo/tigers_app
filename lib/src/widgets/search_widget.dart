import 'package:flutter/material.dart';


class SearchWidget extends StatelessWidget {
	final Function onChanged;
  	const SearchWidget({Key key, @required this.onChanged}) : super(key: key);

  	@override
  	Widget build(BuildContext context) {
    	return Container(
			padding: EdgeInsets.symmetric(horizontal: 20),
			child: TextFormField(
				cursorColor: Color(0xfffbb448),
				decoration: InputDecoration(
					fillColor: Colors.white,
					prefixIcon: Icon(Icons.search, color: Color(0xfffbb448),),
					hintText: 'Buscar',
				),
				onChanged: onChanged,
			)
		);
  	}
}