class InventoryModel {
  int? id;
  String? code;
  String? marca;
  String? model;
  String? imei;
  String? description;
  String? type;

  InventoryModel(
      {this.id, this.code, this.marca, this.model, this.imei, this.description, this.type});

  InventoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    marca = json['marca'];
    model = json['model'];
    imei = json['imei'];
    description = json['description'];
    type = json['typeService'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Code'] = this.code;
    data['Marca'] = this.marca;
    data['Model'] = this.model;
    data['Imei'] = this.imei;
    data['Description'] = this.description;
    data['TypeService'] = this.type;
    return data;
  }
}
