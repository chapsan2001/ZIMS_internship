import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimsmobileapp/domain/blocs/login/login_events.dart';
import 'package:zimsmobileapp/domain/blocs/login/login_states.dart';
import 'package:zimsmobileapp/domain/navigation/navigation_manager.dart';
import 'package:zimsmobileapp/domain/navigation/routes.dart';
import 'package:zimsmobileapp/domain/repositories/auth_repository.dart';
import 'package:zimsmobileapp/main.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  final NavigationManager navigationManager;

  LoginBloc({@required this.authRepository, @required this.navigationManager});

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final user = await authRepository.login(event.userName, event.password);
        userName = event.userName;
        navigationManager.pushRouteWithReplacement(Routes.PIN_CODE_INIT);
        yield LoginInitial();
      } catch (e) {
        yield LoginFailure(exception: e, error: e.toString());
      }
    } else if (event is LoginLoadPreviousUserName) {
      yield LoginLoading();

      try {
        String userName = await authRepository.getLastUserName();
        yield LoginInitial(userName: userName);
      } catch (e) {
        yield LoginInitial();
      }
    }
  }
}
