import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/blocs/login_bloc.dart';

class ProviderBloc extends InheritedWidget {

  	static ProviderBloc _instancia;

  	factory ProviderBloc({ Key key, Widget child }) {
    	if ( _instancia == null ) {
      		_instancia = new ProviderBloc._internal(key: key, child: child );
    	}
    	return _instancia;
  	}

  	ProviderBloc._internal({ Key key, Widget child }) : super(key: key, child: child );


  	final loginBloc = LoginBloc();


 
  	@override
  	bool updateShouldNotify(InheritedWidget oldWidget) => true;

  	static LoginBloc of ( BuildContext context ) {
    	return ( context.inheritFromWidgetOfExactType(ProviderBloc) as ProviderBloc ).loginBloc;
		//return ( context.dependOnInheritedWidgetOfExactType(Provider) as Provider ).loginBloc;
  	}

}