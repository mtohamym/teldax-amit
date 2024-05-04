class RegisterModel {
  String? email;
  String? password;
  String? confirmPassword;
  String? name;
  String? phone;

  RegisterModel({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.name,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'name': name,
      'phone': phone,
    };

  }
}
