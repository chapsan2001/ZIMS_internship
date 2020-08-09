import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimsmobileapp/domain/blocs/permit_photo/permit_photo_events.dart';
import 'package:zimsmobileapp/domain/blocs/permit_photo/permit_photo_states.dart';
import 'package:zimsmobileapp/domain/exceptions/app_exceptions.dart';
import 'package:zimsmobileapp/domain/navigation/navigation_manager.dart';
import 'package:zimsmobileapp/domain/navigation/routes.dart';
import 'package:zimsmobileapp/domain/repositories/permit_repository.dart';
import 'package:zimsmobileapp/main.dart';

class PermitPhotoBloc extends Bloc<PermitPhotoEvent, PermitPhotoState> {
  final PermitRepository permitRepository;
  final NavigationManager navigationManager;

  PermitPhotoBloc(
      {@required this.permitRepository, @required this.navigationManager});

  @override
  PermitPhotoState get initialState => PermitPhotoEmpty();

  @override
  Stream<PermitPhotoState> mapEventToState(PermitPhotoEvent event) async* {
    if (event is FetchPermitPhotoEvent) {
      yield* _mapFetchPermitPhotoEventToState(event);
    }
  }

  Stream<PermitPhotoState> _mapFetchPermitPhotoEventToState(
      FetchPermitPhotoEvent event) async* {
    yield PermitPhotoLoading();

    try {
      final permitPhoto = await permitRepository.getPermitPhoto(
          event.documentInfo.documentType, event.documentInfo.documentNumber);

      yield PermitPhotoLoaded(permitPhoto: permitPhoto);
    } on NotFoundException {
      yield PermitPhotoNotFound();
    } on UnauthorizedException {
      navigationManager.pushRouteWithReplacement(Routes.LOGIN);
      attempts = 3;
      pinFlag = false;
      pin = [null, null, null, null];
      pinEnter = [null, null, null, null];
      dots = [false, false, false, false];
      dotNum = 0;
      userName = null;
    } catch (e) {
      yield PermitPhotoError(exception: e);
    }
  }
}
