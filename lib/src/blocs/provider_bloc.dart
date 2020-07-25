import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/blocs/login_bloc.dart';
export 'package:flutter_login_signup/src/blocs/login_bloc.dart';

class ProviderBloc extends InheritedWidget {

  	static ProviderBloc _providerInstance;

	ProviderBloc._internal({ Key key, Widget child }) : super(key: key, child: child );

  	factory ProviderBloc({ Key key, Widget child }) {
    	if ( _providerInstance == null ) {
      		_providerInstance = new ProviderBloc._internal(key: key, child: child );
    	}
    	return _providerInstance;
  	}

  	
  	final loginBloc = LoginBloc();

 
  	@override
  	bool updateShouldNotify(InheritedWidget oldWidget) => true;
  	

	static LoginBloc of ( BuildContext context ){
   		return context.dependOnInheritedWidgetOfExactType<ProviderBloc>().loginBloc;
	}

}