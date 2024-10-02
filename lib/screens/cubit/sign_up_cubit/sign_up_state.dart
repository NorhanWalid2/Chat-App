part of 'sign_up_cubit.dart';

@immutable
abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSucess extends SignUpState {}

class SignUpFailure extends SignUpState {
  String errorMessage;
  SignUpFailure({required this.errorMessage});
}
