import 'dart:async';



class ValidatorsBloc {

  	final validateEmail = StreamTransformer<String, String>.fromHandlers(
    	handleData: (email, sink) {
      		Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      		RegExp regExp = new RegExp(pattern);
      		if (regExp.hasMatch(email)) { sink.add(email);
      		} else { sink.addError('Correo electrónico no es válido'); }
    	}
  	);


  	final validatePassword = StreamTransformer<String, String>.fromHandlers(
    	handleData: ( password, sink ) {
      		if ( password.length >= 6 ) { 
				sink.add( password );
			} else { 
				sink.addError('Debe tener más de 5 caracteres!'); 
			}
    	}
  	);

	final validateName = StreamTransformer<String, String>.fromHandlers(
    	handleData: ( name, sink ) {
			sink.add(name);
		}
	);


	final validateLastName = StreamTransformer<String, String>.fromHandlers(
    	handleData: ( lastName, sink ) {
			sink.add(lastName);
		}
	);


	final validatePhone = StreamTransformer<String, String>.fromHandlers(
    	handleData: ( phone, sink ) {
			sink.add(phone);
		}
	);


	final validateCustomer = StreamTransformer<String, String>.fromHandlers(
    	handleData: ( customer, sink ) {
			sink.add(customer);
		}
	);
	
}
