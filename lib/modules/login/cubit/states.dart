
abstract class loginStates{}

class loginIntialState extends loginStates{}

class loginLoadingState extends loginStates{}

class loginSuccessState extends loginStates{
  final String uid;
  loginSuccessState(this.uid);
}

class loginErrorState extends loginStates{
  final error;

  loginErrorState(this.error);
}

class loginPasswordVisibaltiy extends loginStates{}
