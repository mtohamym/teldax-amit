class TransactionModel {
  String ? locationName;
  String ? amount;
  String ? date;
  String ? description;
  String ? id;
  String ? email;

  TransactionModel({this.locationName, this.amount, this.date, this.description, required this.email});
  // read
  TransactionModel.fromJson(Map<String, dynamic> json , String transactionId) {
    locationName = json['locationName'];
    amount = json['amount'];
    date = json['date'];
    description = json['description'];
    id = transactionId;


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['locationName'] = locationName;
    data['amount'] = amount;
    data['date'] = date;
    data['description'] = description;
    data['email'] = email;
    return data;
  }

}