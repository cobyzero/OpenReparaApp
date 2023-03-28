class UsersModel {
  int? id;
  String? name;
  String? username;
  String? email;
  String? password;
  int? type;

  UsersModel({this.id, this.name, this.username, this.email, this.password, this.type});

  UsersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    data['password'] = this.password;
    data['type'] = this.type;
    return data;
  }
}
