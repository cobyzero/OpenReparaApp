class InventarioModel {
  int? id;
  String? code;
  String? marca;
  String? model;
  String? serial;
  String? imei;
  String? description;
  String? type;

  InventarioModel(
      {this.id,
      this.code,
      this.marca,
      this.model,
      this.serial,
      this.imei,
      this.description,
      this.type});

  InventarioModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    marca = json['marca'];
    model = json['model'];
    serial = json['serial'];
    imei = json['imei'];
    description = json['description'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['marca'] = this.marca;
    data['model'] = this.model;
    data['serial'] = this.serial;
    data['imei'] = this.imei;
    data['description'] = this.description;
    data['type'] = this.type;
    return data;
  }
}
