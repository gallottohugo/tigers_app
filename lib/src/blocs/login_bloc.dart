import 'dart:async';
import 'package:flutter_login_signup/src/blocs/validators_bloc.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with ValidatorsBloc {

  	final _emailController    = BehaviorSubject<String>();
  	final _passwordController = BehaviorSubject<String>();

  	// Get data from Stream
  	Stream<String> get emailStream    => _emailController.stream.transform( validarEmail );
  	Stream<String> get passwordStream => _passwordController.stream.transform( validarPassword );
  	Stream<bool> get formValidStream  =>  Observable.combineLatest2(emailStream, passwordStream, (e, p) => true );

  	// Insert data to Stream
  	Function(String) get changeEmail    => _emailController.sink.add;
  	Function(String) get changePassword => _passwordController.sink.add;


  	// Get last value entered to streams
  	String get email    => _emailController.value;
  	String get password => _passwordController.value;

  	dispose() {
    	_emailController?.close();
    	_passwordController?.close();
  	}

}

