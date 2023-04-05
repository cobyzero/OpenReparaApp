class ClientModel {
  int? id;
  String? code;
  String? name;
  String? email;
  String? number;

  ClientModel({this.id, this.code, this.name, this.email, this.number});

  ClientModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    email = json['email'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = this.id;
    data['Code'] = this.code;
    data['Name'] = this.name;
    data['Email'] = this.email;
    data['Number'] = this.number;
    return data;
  }
}
