class OrderModel {
  int? id;
  String? code;
  String? service;
  String? dispositive;
  String? nameClient;
  String? numberClient;
  String? emailClient;
  String? marcaDispositive;
  String? modelDispositive;
  String? imeiDispositive;
  String? passDispositive;
  String? pinDispositive;
  String? failDispositive;
  String? observation;
  double? price;
  int? status;
  String? dateOrder;

  OrderModel(
      {this.id,
      this.code,
      this.service,
      this.dispositive,
      this.nameClient,
      this.numberClient,
      this.emailClient,
      this.marcaDispositive,
      this.modelDispositive,
      this.imeiDispositive,
      this.passDispositive,
      this.pinDispositive,
      this.failDispositive,
      this.observation,
      this.price,
      this.status,
      this.dateOrder});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    service = json['typeService'];
    dispositive = json['dispositive'];
    nameClient = json['nameClient'];
    numberClient = json['numberClient'];
    emailClient = json['emailClient'];
    marcaDispositive = json['marcaDispositive'];
    modelDispositive = json['modelDispositive'];
    imeiDispositive = json['imeiDispositive'];
    passDispositive = json['passDispositive'];
    pinDispositive = json['pinDispositive'];
    failDispositive = json['failDispositive'];
    observation = json['observation'];
    try {
      price = json['price'];
    } catch (e) {
      price = double.tryParse(json['price'].toString());
    }
    status = json['status'];
    dateOrder = json['dateOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Code'] = this.code;
    data['TypeService'] = this.service;
    data['Dispositive'] = this.dispositive;
    data['NameClient'] = this.nameClient;
    data['NumberClient'] = this.numberClient;
    data['EmailClient'] = this.emailClient;
    data['MarcaDispositive'] = this.marcaDispositive;
    data['ModelDispositive'] = this.modelDispositive;
    data['ImeiDispositive'] = this.imeiDispositive;
    data['PassDispositive'] = this.passDispositive;
    data['PinDispositive'] = this.pinDispositive;
    data['FailDispositive'] = this.failDispositive;
    data['Observation'] = this.observation;
    data['Price'] = this.price;
    data['Status'] = this.status;
    data['DateOrder'] = this.dateOrder;
    return data;
  }
}
