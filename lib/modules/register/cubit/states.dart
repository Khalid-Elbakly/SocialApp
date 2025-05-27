abstract class RegisterStates{}

class RegisterIntialState extends RegisterStates{}

class RegisterLoadingState extends RegisterStates{}

class RegisterSuccessState extends RegisterStates{}

class RegisterErrorState extends RegisterStates{
  final error;

  RegisterErrorState(this.error);
}

class UserCreateSuccessState extends RegisterStates{}

class UserCreateErrorState extends RegisterStates{
  final error;

  UserCreateErrorState(this.error);
}

class RegisterPasswordVisibaltiy extends RegisterStates{}
