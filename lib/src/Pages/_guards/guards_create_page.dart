import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/models/guard_model.dart';
import 'package:flutter_login_signup/src/models/user_model.dart';
import 'package:flutter_login_signup/src/pages/users/users_list_page.dart';
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
	List<UserModel> employees = List<UserModel>();


	void handleDistrictDropdownValue(int newValue){
		if (newValue > 0){  newGuard.districtId = newValue; }
	}


	void handleAddEmployee(UserModel userModel){
		employees.add(userModel);
	}

	void handleRemoveEmployee(UserModel userModel){
		employees.remove(userModel);
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
		Map<String, dynamic> response = await guardsProvider.guardsCreate(guard: newGuard, employees: employees);
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
					TextFormFieldWidget(title: 'Fecha', enabled: true, obscureText: false, onSavedFunction: _onSavedDate, textInputType: TextInputType.text, onTapFunction: _onTapDate, controller: controllerDate,),
					SizedBox(height: 20,),
					TextFormFieldWidget(title: 'Hora inicio', enabled: true, initialValue: '', obscureText: false, onSavedFunction: _onSavedStart, textInputType: TextInputType.number,),
					SizedBox(height: 20,),
					TextFormFieldWidget(title: 'Hora fin', enabled: true, initialValue: '', obscureText: false, onSavedFunction: _onSavedEnd, textInputType: TextInputType.number,),
					SizedBox(height: 20,),
					DistrictsDropDownButtonWidget(handleDistrictDropdownValue: handleDistrictDropdownValue,),
					SizedBox(height: 20,),
					Divider(color: TigerColors.orange, thickness: 2,),
					SizedBox(height: 20,),
					AddEmployeesWidget(handleAddEmployee: handleAddEmployee, handleRemoveEmployee: handleRemoveEmployee,),
					SizedBox(height: 20,),
					Divider(color: TigerColors.orange, thickness: 2,),
					SizedBox(height: 20,),
					ButtonWidget(title: 'Crear', border: Colors.white, colorStart: Color(0xfffbb448), colorEnd: Color(0xfff7892b), colorText: Colors.black, onPressedFunction: _onTapButton,),
					SizedBox(height: 20,),
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


class AddEmployeesWidget extends StatefulWidget {
	final ValueChanged<UserModel> handleAddEmployee;
	final ValueChanged<UserModel> handleRemoveEmployee;
  	AddEmployeesWidget({Key key, @required this.handleAddEmployee, @required this.handleRemoveEmployee}) : super(key: key);
  	_AddEmployeesWidgetState createState() => _AddEmployeesWidgetState();
}

class _AddEmployeesWidgetState extends State<AddEmployeesWidget> {
	List<UserModel> employees = List<UserModel>();
  	@override
  	Widget build(BuildContext context) {
		return Column(
			children: <Widget>[
				Text('Asignar empleados', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
				Column(
					children: new List<Widget>.generate(employees.length, (int index) {
						return Column(
							children: <Widget>[
								ListTile(
									leading: Icon(Icons.person),
									title: Text('${employees[index].lastName}, ${employees[index].name}'),
									trailing: IconButton(
										icon: Icon(Icons.close),
										onPressed: (){
											widget.handleRemoveEmployee(employees[index]);
											employees.remove(employees[index]);
											setState(() { });
										},
									),
								)
							],
						);
					})
				),
				IconButton(
					iconSize: 35,
					color: Colors.green,
					icon: Icon(Icons.add_circle),
					onPressed: () async {
						var response = await Navigator.pushNamed(context, UsersListPage.routeName, arguments: {'user_type': 'employee', 'from_search_employee': true});
						if (response != null){
							widget.handleAddEmployee(response);
							employees.add(response);
							setState(() { });
						}
					},
				)
			],
		);  
  	}
}