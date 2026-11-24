sealed class SignUpStates {}

final class SignUpInitialState extends SignUpStates {}

final class SignUpLoadingState extends SignUpStates {}

final class SignUpSuccessState extends SignUpStates {}

final class SignUpFailureState extends SignUpStates {
  String errorMsg;
  SignUpFailureState(this.errorMsg);
}
