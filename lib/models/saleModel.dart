class SaleModel {
  int? id;
  String? code;
  String? client;
  String? fecha;
  String? type;
  int? price;

  SaleModel({this.id, this.code, this.client, this.fecha, this.type, this.price});

  SaleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    client = json['clientName'];
    fecha = json['dateService'];
    type = json['typeService'];
    price = json['priceService'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Code'] = this.code;
    data['ClientName'] = this.client;
    data['DateService'] = this.fecha;
    data['TypeService'] = this.type;
    data['PriceService'] = this.price;
    return data;
  }
}
