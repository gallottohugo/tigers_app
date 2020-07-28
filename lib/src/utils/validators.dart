class Validators {

  	static String validateEmail(String value){
		Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
		RegExp regExp = new RegExp(pattern);
		if (regExp.hasMatch(value)) { 
			return null;
		} else {
			return 'Correo electrónico no es válido';
		}
	}

	

  	

	static String validateName(String value){
		if (value.isEmpty){
			return 'Nombre no puede estar vacio';
		} else {
			return null;
		}
	}


	static String validateLastName(String value){
		if (value.isEmpty){
			return 'Apellido no puede estar vacio';
		} else {
			return null;
		}
	}


	static String validatePhone(String value){
		if (value.isEmpty){
			return 'Teléfono no puede estar vacio';
		} else {
			if (_isNumeric(value)){
				return null;
			} else {
				return 'Debe ingresar un número';
			}
		}
	}


    static String validateDate(String value){
        if (value.isEmpty){
			return 'Apellido no puede estar vacio';
		} else {
			return null;
		}
    }


    static String validateStartHour(String value){
		if (value.isEmpty){
			return 'Inicio no puede estar vacio';
		} else {
			final hour = num.tryParse(value);
            if (hour == null){
                return 'Inicio tiene que ser un número.';
            } else {
                if (hour >= 0 && hour < 24) {
                    return null;
                } else {
                    return 'Acepta un valor entre 0 y 23';
                }
            }
		}
	}




	static String validateCustomer(String value){
		return null;
	}


	static bool _isNumeric(String value){
		final n = num.tryParse(value);
		return (n == null) ? false : true;
	}
}