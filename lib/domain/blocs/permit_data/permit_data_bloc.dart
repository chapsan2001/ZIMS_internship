import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimsmobileapp/domain/blocs/permit_data/permit_data_events.dart';
import 'package:zimsmobileapp/domain/blocs/permit_data/permit_data_states.dart';
import 'package:zimsmobileapp/domain/exceptions/app_exceptions.dart';
import 'package:zimsmobileapp/domain/models/models.dart';
import 'package:zimsmobileapp/domain/navigation/navigation_manager.dart';
import 'package:zimsmobileapp/domain/navigation/routes.dart';
import 'package:zimsmobileapp/domain/repositories/permit_repository.dart';
import 'package:zimsmobileapp/main.dart';

class PermitDataBloc extends Bloc<PermitDataEvent, PermitDataState> {
  final PermitRepository permitRepository;
  final NavigationManager navigationManager;

  PermitDataBloc(
      {@required this.permitRepository, @required this.navigationManager});

  @override
  PermitDataState get initialState => PermitDataEmpty();

  @override
  Stream<PermitDataState> mapEventToState(PermitDataEvent event) async* {
    if (event is FetchPermitDataEvent) {
      yield* _mapFetchPermitDataEventToState(event);
    } else if (event is OpenPhotoEvent) {
      yield* _mapOpenPhotoEventToState(event);
    }
  }

  Stream<PermitDataState> _mapFetchPermitDataEventToState(
      FetchPermitDataEvent event) async* {
    yield PermitDataLoading();

    try {
      final permitData = await permitRepository.getPermitData(
          event.documentInfo.documentType, event.documentInfo.documentNumber);

      yield PermitDataLoaded(permitData: permitData);
    } on NotFoundException {
      yield PermitDataNotFound();
    } on UnauthorizedException {
      navigationManager.pushRouteWithReplacement(Routes.LOGIN);
      userName = null;
      attempts = 3;
      pinFlag = false;
      pin = [null, null, null, null];
      pinEnter = [null, null, null, null];
      dots = [false, false, false, false];
      dotNum = 0;
    } catch (e) {
      yield PermitDataError(exception: e);
    }
  }

  Stream<PermitDataState> _mapOpenPhotoEventToState(
      OpenPhotoEvent event) async* {
    if (event.documentInfo.documentType == DocumentType.PERMIT) {
      navigationManager.pushRoute(Routes.PERMIT_PHOTO, event.documentInfo);
    }
  }
}
