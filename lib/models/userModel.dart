class UserModel {
  int? id;
  String? name;
  String? username;
  String? email;
  String? password;
  int? type;

  UserModel({this.id, this.name, this.username, this.email, this.password, this.type});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    type = json['authority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['Username'] = this.username;
    data['Email'] = this.email;
    data['Password'] = this.password;
    data['Authority'] = this.type;
    return data;
  }
}
