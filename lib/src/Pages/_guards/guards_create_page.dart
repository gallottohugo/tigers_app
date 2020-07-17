import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/models/guard_model.dart';
import 'package:flutter_login_signup/src/providers/guards_provider.dart';
import 'package:flutter_login_signup/src/styles/colors.dart';
import 'package:flutter_login_signup/src/widgets/Districts/districts_dropDown_button_widget.dart';
import 'package:flutter_login_signup/src/widgets/alert_widgets.dart';
import 'package:flutter_login_signup/src/widgets/app_bar_widget.dart';
import 'package:flutter_login_signup/src/widgets/bezierContainer.dart';
import 'package:flutter_login_signup/src/widgets/button_widget.dart';
import 'package:flutter_login_signup/src/widgets/progress_indicator_widget.dart';
import 'package:flutter_login_signup/src/widgets/text_form_field_widget.dart';

class GuardsCreatePage extends StatefulWidget {
	static final String routeName = 'guards_create_page';

  	GuardsCreatePage({Key key}) : super(key: key);
  	_GuardsCreatePageState createState() => _GuardsCreatePageState();
}

class _GuardsCreatePageState extends State<GuardsCreatePage> {
  	bool showLoading = false;
	final formKey = GlobalKey<FormState>();
	GuardModel newGuard = GuardModel();
	TextEditingController controllerDate = TextEditingController();

	void handleDistrictDropdownValue(int newValue){
		if (newValue > 0){  newGuard.districtId = newValue; }
	}


  	@override
  	Widget build(BuildContext context) {
    	final height = MediaQuery.of(context).size.height;
		return Scaffold(
			appBar: _appBarTiger(),
      		body: Container(
        		height: height,
        		child: Stack(
          			children: <Widget>[
            			BezierContainer(),
            			Container(
              				padding: EdgeInsets.symmetric(horizontal: 20),
              				child: SingleChildScrollView(
                				child: Column(
                  					crossAxisAlignment: CrossAxisAlignment.center,
                  					mainAxisAlignment: MainAxisAlignment.center,
                  					children: <Widget>[
                    					SizedBox(height: 20,),
                    					_formWidget(),
                  					],
                				),
              				),
            			),
						showLoading == true ? ProgressIndicatorWidget() : Container()
          			],
        		),
      		),
    	);
  	}



	Widget _appBarTiger({Widget leading}){
		return PreferredSize(
			preferredSize: Size.fromHeight(60.0), // here the desired height
			child: AppBarTiger(title: 'Crear Guardia', leading: leading,)
		);
	}	


	void _onTapButton() async {
		setState(() { showLoading = true; });
		formKey.currentState.save();
		GuardsProvider guardsProvider = GuardsProvider();
		Map<String, dynamic> response = await guardsProvider.guardsCreate(guard: newGuard);
		setState(() { showLoading = false; });
		if (response["ok"] == true) {
			Navigator.pop(context);
		} else {
			AlertWidgets.alertOkWidget(context, 'Error', response["message"], Icon(Icons.error));
		}
	}
	

  	Widget _formWidget() {
    	return Form(
			key: formKey,
			child: Column(
				children: <Widget>[
					TextFormFieldWidget(title: 'Fecha', enabled: true, obscureText: false, onSaved: _onSavedDate, textInputType: TextInputType.text, onTap: _onTapDate, controller: controllerDate,),
					SizedBox(height: 20,),
					TextFormFieldWidget(title: 'Hora inicio', enabled: true, initialValue: '', obscureText: false, onSaved: _onSavedStart, textInputType: TextInputType.number,),
					SizedBox(height: 20,),
					TextFormFieldWidget(title: 'Hora fin', enabled: true, initialValue: '', obscureText: false, onSaved: _onSavedEnd, textInputType: TextInputType.number,),
					SizedBox(height: 20,),
					DistrictsDropDownButtonWidget(handleDistrictDropdownValue: handleDistrictDropdownValue,),
					SizedBox(height: 20,),
					Divider(color: TigerColors.orange, thickness: 2,),
					SizedBox(height: 20,),
					Text('Aca van los empleados'),
					SizedBox(height: 20,),
					Divider(color: TigerColors.orange, thickness: 2,),
					SizedBox(height: 20,),
					ButtonWidget(title: 'Crear', border: Colors.white, colorStart: Color(0xfffbb448), colorEnd: Color(0xfff7892b), colorText: Colors.black, onTapFunction: _onTapButton,)
				],
			)
    	);
  	} 


	void _onSavedDate(String value){ newGuard.date = value; }
	void _onSavedStart(String value){ newGuard.start = int.parse(value); }
	void _onSavedEnd(String value){ newGuard.end = int.parse(value); }
	void _onTapDate() async {
		FocusScope.of(context).requestFocus(FocusNode());
		DateTime date = await _datePicker(context);
		controllerDate.text = '${date.year}-${date.month}-${date.day}';

	}
	
	



	Future<DateTime> _datePicker(BuildContext context) async {
		DateTime _now = DateTime.now();
      	final DateTime date = await showDatePicker(
          	context: context,
          	initialDate: DateTime(_now.year, _now.month, _now.day),
          	firstDate: DateTime(_now.year, _now.month, _now.day),
          	lastDate: DateTime(_now.year + 1, _now.month, _now.day),
          	locale: Locale('es', 'ES'),
			  builder: (BuildContext context, Widget child) {
                return Theme(
                    data: ThemeData.light().copyWith(
                        primaryColor: TigerColors.orange,
                        accentColor: TigerColors.orange,
                        colorScheme: ColorScheme.light(primary: TigerColors.orange,),
                        buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
                    ),
                    child: child,
                );
            },
      	);
		return date;
  	}
	
	
}