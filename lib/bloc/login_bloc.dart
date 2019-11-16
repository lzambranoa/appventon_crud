
import 'dart:async';
import 'package:appventon/bloc/validaciones.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validaciones {

  final _emailController      = BehaviorSubject<String>();
  final _passwordController   = BehaviorSubject<String>();

  //Permite recuperar los datos del Stream
  Stream<String> get emailStream    => _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream  => _passwordController.stream.transform(validarPassword);

  Stream<bool> get formValidStream =>
      Observable.combineLatest2(emailStream, passwordStream, (e,p) => true);

  //Inserta los valores al streams

  Function(String) get changeEmail   => _emailController.sink.add;
  Function(String) get changePassword  => _passwordController.sink.add;

  //Obtener el ultimo valor ingresado a los streams
  String get email  => _emailController.value;
  String get password  => _passwordController.value;

  dipose() {
    _emailController?.close();
    _passwordController?.close();
  }

}