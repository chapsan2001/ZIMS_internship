import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:zimsmobileapp/data/translations/global_translations.dart';
import 'package:zimsmobileapp/domain/blocs/blocs.dart';
import 'package:zimsmobileapp/domain/blocs/permit_photo/permit_photo_events.dart';
import 'package:zimsmobileapp/domain/blocs/permit_photo/permit_photo_states.dart';
import 'package:zimsmobileapp/domain/exceptions/app_exceptions.dart';
import 'package:zimsmobileapp/domain/models/models.dart';
import 'package:zimsmobileapp/presentation/styles.dart';
import 'package:zimsmobileapp/presentation/theme_provider_mixin.dart';

class PermitPhotoScreen extends StatefulWidget {
  final DocumentInfo documentInfo;

  PermitPhotoScreen({@required this.documentInfo});

  @override
  State createState() => _PermitPhotoScreenState();
}

class _PermitPhotoScreenState extends State<PermitPhotoScreen>
    with ThemeProviderMixin {
  Color _grayBackground;
  Color _darkGray;

  @override
  void initState() {
    super.initState();

    _grayBackground = getColor(context, CustomColors.GRAY_BACKGROUND_COLOR);
    _darkGray = getColor(context, CustomColors.DARK_GRAY_COLOR);

    BlocProvider.of<PermitPhotoBloc>(context)
        .add(FetchPermitPhotoEvent(documentInfo: widget.documentInfo));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      backgroundColor: _grayBackground,
      appBar: AppBar(
        elevation: 1,
        title: Text(
          allTranslations.text('permit_photo.title'),
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
        backgroundColor: _grayBackground,
        iconTheme: IconThemeData(color: _darkGray),
      ),
      body: BlocListener<PermitPhotoBloc, PermitPhotoState>(
        listener: (context, state) {},
        child: BlocBuilder<PermitPhotoBloc, PermitPhotoState>(
          builder: (context, state) {
            if (state is PermitPhotoLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is PermitPhotoError) {
              return Center(
                child: Text(_getTextError(state)),
              );
            }

            if (state is PermitPhotoNotFound) {
              return Center(
                child: Text(allTranslations.text('messages.not_found')),
              );
            }

            if (state is PermitPhotoLoaded) {
              return Container(
                child: PhotoView(
                    backgroundDecoration: BoxDecoration(color: Colors.white),
                    minScale: 0.5,
                    maxScale: 4.0,
                    imageProvider: MemoryImage(state.permitPhoto.bytes)),
              );
            }

            return Center();
          },
        ),
      ),
    );
  }

  String _getTextError(PermitPhotoError state) {
    if (state.exception is AppException) {
      return (state.exception as AppException).getPrefix();
    } else {
      return state.exception.toString() ?? "";
    }
  }
}
