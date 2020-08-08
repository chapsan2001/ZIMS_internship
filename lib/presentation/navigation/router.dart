import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimsmobileapp/di/locator.dart';
import 'package:zimsmobileapp/domain/blocs/blocs.dart';
import 'package:zimsmobileapp/domain/navigation/routes.dart';
import 'package:zimsmobileapp/presentation/screens/choose_type/choose_type_screen.dart';
import 'package:zimsmobileapp/presentation/screens/enter_id/enter_id_screen.dart';
import 'package:zimsmobileapp/presentation/screens/login/login_screen.dart';
import 'package:zimsmobileapp/presentation/screens/permit_data/permit_data_screen.dart';
import 'package:zimsmobileapp/presentation/screens/permit_photo/permit_photo_screen.dart';
import 'package:zimsmobileapp/presentation/screens/history/history_screen.dart';
import 'package:zimsmobileapp/presentation/screens/pin_code/pin_code_init_screen.dart';
import 'package:zimsmobileapp/presentation/screens/pin_code/pin_code_lock_screen.dart';

class Router {
  Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    final route = routeSettings.name;
    final args = routeSettings.arguments;

    switch (route) {
      case Routes.LOGIN:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => locator<LoginBloc>(),
            child: LoginScreen(),
          ),
          settings: routeSettings,
        );
        break;
      case Routes.ENTER_ID:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => locator<EnterIdBloc>(),
            child: EnterIdScreen(),
          ),
          settings: routeSettings,
        );
        break;
      case Routes.CHOOSE_TYPE:
        return MaterialPageRoute(
            builder: (context) => ChooseTypeScreen(
                  documentType: args,
                ),
            settings: routeSettings);
        break;
      case Routes.PERMIT_DATA:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => locator<PermitDataBloc>(),
                  child: PermitDataScreen(
                    documentInfo: args,
                  ),
                ),
            settings: routeSettings);
        break;
      case Routes.PERMIT_PHOTO:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => locator<PermitPhotoBloc>(),
                  child: PermitPhotoScreen(
                    documentInfo: args,
                  ),
                ),
            settings: routeSettings);
        break;
      case Routes.HISTORY_SCREEN:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => locator<HistoryBloc>(),
              child: HistoryScreen()
            ),
            settings: routeSettings);
        break;
      case Routes.PIN_CODE_INIT:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                create: (context) => locator<PinCodeInitBloc>(),
                child: PinCodeInitScreen()
            ),
            settings: routeSettings);
        break;
      case Routes.PIN_CODE_LOCK:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                create: (context) => locator<PinCodeLockBloc>(),
                child: PinCodeLockScreen()
            ),
            settings: routeSettings);
        break;
      default:
        throw UnimplementedError("Route with name $route not found");
        break;
    }
  }
}

Router router = Router();
