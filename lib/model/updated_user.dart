class UpdatedUser {
  String? username;
  String? email;
  String? name;
  String? phoneNumber;
  String? roleType;
  String? imgUrl;

  UpdatedUser({
    this.username,
    this.email,
    this.name,
    this.phoneNumber,
    this.roleType,
    this.imgUrl,
  });

  Map<String,dynamic> toJson() {
    Map<String,dynamic> map = {
      'username': username,
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'roleType': roleType,
      'imgUrl': imgUrl,
    }; 
    return map;
  }
}