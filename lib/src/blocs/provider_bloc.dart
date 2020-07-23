import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/blocs/pattern_bloc.dart';
export 'package:flutter_login_signup/src/blocs/pattern_bloc.dart';

class ProviderBloc extends InheritedWidget {

  	static ProviderBloc _instancia;

	ProviderBloc._internal({ Key key, Widget child }) : super(key: key, child: child );

  	factory ProviderBloc({ Key key, Widget child }) {
    	if ( _instancia == null ) {
      		_instancia = new ProviderBloc._internal(key: key, child: child );
    	}
    	return _instancia;
  	}

  	


  	final loginBloc = PatternBloc();


 
  	@override
  	bool updateShouldNotify(InheritedWidget oldWidget) => true;

  	

	static PatternBloc of ( BuildContext context ){
   		return context.dependOnInheritedWidgetOfExactType<ProviderBloc>().loginBloc;
	}

}