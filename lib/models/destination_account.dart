class DestinationAccountData {
  final String agency;
  final String number;
  final String holderName;
  final String holderDoc;
  final String type;
  final int id;

  DestinationAccountData(
      {required this.agency,
      required this.number,
      required this.holderName,
      required this.holderDoc,
      required this.type,
      required this.id});

  void setAccount(String? agency, String? number) {}
}
