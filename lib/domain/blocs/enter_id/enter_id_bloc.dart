import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimsmobileapp/domain/blocs/enter_id/enter_id_events.dart';
import 'package:zimsmobileapp/domain/blocs/enter_id/enter_id_states.dart';
import 'package:zimsmobileapp/domain/exceptions/app_exceptions.dart';
import 'package:zimsmobileapp/domain/models/models.dart';
import 'package:zimsmobileapp/domain/navigation/navigation_manager.dart';
import 'package:zimsmobileapp/domain/navigation/routes.dart';
import 'package:zimsmobileapp/domain/repositories/qr_scan_repository.dart';
import 'package:zimsmobileapp/main.dart';

class EnterIdBloc extends Bloc<EnterIdEvent, EnterIdState> {
  static const QR_URL_PREFIX =
      'https://eservices.zambiaimmigration.gov.zm/api/permitinfo/';

  final QrScanRepository qrScanRepository;
  final NavigationManager navigationManager;

  EnterIdBloc(
      {@required this.qrScanRepository, @required this.navigationManager});

  @override
  EnterIdState get initialState => InitialEnterIdState();

  @override
  Stream<EnterIdState> mapEventToState(EnterIdEvent event) async* {
    if (event is ScanQrPressedEvent) {
      yield* _mapScanQrPressedEventToState();
    } else if (event is GetDocumentTypeEvent) {
      yield* _mapGetDocumentTypeEventToState(event);
    } else if (event is FindDocumentPressedEvent) {
      yield* _mapFindDocumentPressedEventToState(event);
    } else if (event is ConfirmLogoutEvent) {
      yield* _mapConfirmLogoutToState(event);
    } else if (event is HistoryOpenEvent) {
      yield* _mapHistoryOpenToState(event);
    } else if (event is ConfirmLockEvent) {
      yield* _mapConfirmLockToState(event);
    }
  }

  Stream<EnterIdState> _mapHistoryOpenToState(
      HistoryOpenEvent event) async* {
    navigationManager.pushRoute(Routes.HISTORY_SCREEN);
  }

  Stream<EnterIdState> _mapFindDocumentPressedEventToState(
      FindDocumentPressedEvent event) async* {
    navigationManager.pushRoute(Routes.PERMIT_DATA, event.documentInfo);
  }

  Stream<EnterIdState> _mapGetDocumentTypeEventToState(
      GetDocumentTypeEvent event) async* {
    final documentType = await navigationManager.pushRoute(
        Routes.CHOOSE_TYPE, event.currentDocumentType);
    yield ReceivedDocumentTypeState(documentType: documentType);
  }

  Stream<EnterIdState> _mapScanQrPressedEventToState() async* {
    try {
      final result = await qrScanRepository.scan();
      String documentNumber = _getDocumentNumber(result);
      final documentInfo = DocumentInfo(
          documentNumber: documentNumber, documentType: DocumentType.PERMIT);

      navigationManager.pushRoute(Routes.PERMIT_DATA, documentInfo).then((_) {
        add(ScanQrPressedEvent());
      });
    } on QrScanCancelledException {} catch (e) {
      yield QrScanErrorState();
    }
  }

  String _getDocumentNumber(String result) {
    try {
      final documentNumber = result.replaceAll(QR_URL_PREFIX, '');

      final lastDelimiter = documentNumber.lastIndexOf('/');

      final preLastDelimiter =
          documentNumber.substring(0, lastDelimiter).lastIndexOf('/');

      return documentNumber.substring(preLastDelimiter + 1);
    } catch (_) {
      return "";
    }
  }

  Stream<EnterIdState> _mapConfirmLogoutToState(
      ConfirmLogoutEvent event) async* {
    if (event.isLogout) {
      attempts = 3;
      pinFlag = false;
      pin = [null, null, null, null];
      pinEnter = [null, null, null, null];
      dots = [false, false, false, false];
      dotNum = 0;
      userName = null;
      navigationManager.pushRouteWithReplacement(Routes.LOGIN);
    }
  }

  Stream<EnterIdState> _mapConfirmLockToState(ConfirmLockEvent event) async* {
    if (event.isLocked) {
      yield InitialEnterIdState();
      pinEnter = [null, null, null, null];
      attempts = 3;
      navigationManager.pushRouteWithReplacement(Routes.PIN_CODE_LOCK);
    }
  }
}
