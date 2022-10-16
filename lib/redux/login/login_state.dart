class LoginState {
  String mobileNumber;
  String password;
  bool loginLoading;

  LoginState({
    required this.mobileNumber,
    required this.password,
    required this.loginLoading,
  });

  factory LoginState.initial() {
    return LoginState(
      mobileNumber: "",
      password: "",
      loginLoading: false,
    );
  }

  LoginState copyWith({
    String? mobileNumber,
    String? password,
    bool? loginLoading,
  }) {
    return LoginState(
      mobileNumber: mobileNumber ?? this.mobileNumber,
      password: password ?? this.password,
      loginLoading: loginLoading ?? this.loginLoading,
    );
  }
}
