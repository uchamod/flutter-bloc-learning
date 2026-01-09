class UserModel {
  final String userId;
  final String username;
  final String email;
  final String userpassword;
  final String address;
  final String discription;

  UserModel({
    required this.userId,
    required this.username,
    required this.userpassword,
    required this.address,
    required this.discription, required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "username": username,
      "userpassword": userpassword,
      "address": address,
      "discription": discription,
      "email": email,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json["userId"],
      username: json["username"],
      userpassword: json["userpassword"],
      address: json["address"],
      discription: json["discription"],
      email:json["email"]
    );
  }
}
