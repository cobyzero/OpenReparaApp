class ClientesModel {
  int? id;
  String? code;
  String? name;
  String? email;
  String? number;

  ClientesModel({this.id, this.code, this.name, this.email, this.number});

  ClientesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    email = json['email'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Code'] = this.code;
    data['Name'] = this.name;
    data['Email'] = this.email;
    data['Number'] = this.number;
    return data;
  }
}
