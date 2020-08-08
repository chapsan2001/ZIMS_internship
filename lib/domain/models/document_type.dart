enum DocumentType { VISA, PERMIT, PASSPORT, RECEIPT }

mixin DocumentTypeValue {
  int getDocumentTypeValue(DocumentType documentType) {
    switch (documentType) {
      case DocumentType.VISA:
        return 1;
      case DocumentType.PERMIT:
        return 2;
      case DocumentType.PASSPORT:
        return 3;
      case DocumentType.RECEIPT:
        return 4;
      default:
        throw UnimplementedError("Provide int value of document type!");
    }
  }
}
