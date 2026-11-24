sealed class LogInStates {}

final class LogInInitialState extends LogInStates {}

final class LogInLoadingState extends LogInStates {}

final class LogInSuccessState extends LogInStates {}

final class LogInFailureState extends LogInStates {
  String errMsg;
  LogInFailureState(this.errMsg);
}
