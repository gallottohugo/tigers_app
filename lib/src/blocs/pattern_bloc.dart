import 'dart:async';
import 'package:flutter_login_signup/src/blocs/validators_bloc.dart';
import 'package:rxdart/rxdart.dart';

class PatternBloc with ValidatorsBloc {

  	//final _emailController    = StreamController<String>.broadcast();
  	//final _passwordController = StreamController<String>.broadcast();

	//BehaviorSubject replace stream controllers from rxdart package. This one contains default broadcast
	final _emailController    = BehaviorSubject<String>();
  	final _passwordController = BehaviorSubject<String>();


  	// Get data from Stream
	Stream<String> get emailStream     =>  _emailController.stream.transform(validateEmail); //validateEmail from mixin ValidatorsBloc
  	Stream<String> get passwordStream  =>  _passwordController.stream.transform(validatePassword); //validatePassword from mixin ValidatorsBloc
  	Stream<bool>   get formLoginStream =>  Observable.combineLatest2(emailStream, passwordStream, (e, p) => true );

	  
  	// Insert data to Stream
  	Function(String) get changeEmail    => _emailController.sink.add;
  	Function(String) get changePassword => _passwordController.sink.add;


  	// Get last value entered to streams
  	String get emailLastValue    => _emailController.value;
  	String get passwordLastValue => _passwordController.value;



  	dispose() {
    	_emailController?.close();
    	_passwordController?.close();
  	}

}

