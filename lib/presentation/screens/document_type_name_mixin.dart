import 'package:zimsmobileapp/data/translations/global_translations.dart';
import 'package:zimsmobileapp/domain/models/document_type.dart';

mixin DocumentTypeNameMixin {
  String getDocumentTypeName(DocumentType documentType) {
    switch (documentType) {
      case DocumentType.PERMIT:
        return allTranslations.text("document_type.permit");
      case DocumentType.VISA:
        return allTranslations.text("document_type.visa");
      case DocumentType.PASSPORT:
        return allTranslations.text("document_type.passport");
      case DocumentType.RECEIPT:
        return allTranslations.text("document_type.receipt");
      default:
        throw UnimplementedError("Provide text value of document type!");
    }
  }
}
