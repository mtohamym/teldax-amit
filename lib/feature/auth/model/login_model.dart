class LoginModel {
  String? email;
  String? name;
  String? phone;

  LoginModel({
    required this.email,
    required this.name,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
    };
  }

  LoginModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
  }


}