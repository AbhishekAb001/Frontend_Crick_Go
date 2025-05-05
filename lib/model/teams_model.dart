class TeamsModel {
  String? tournamentId;
  String? name;
  String? logo;
  String? captain;
  List<String>? members;
  String? description;
  String? status;
  String? email;
  String? phone;

  TeamsModel({
    this.tournamentId,
    this.name,
    this.logo,
    this.captain,
    this.members,
    this.description,
    this.status = "PENDING",
    this.email,
    this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      "tournamentId": tournamentId,
      "teamName": name,
      "teamLogo": logo,
      "teamCaptain": captain,
      "teamMemberIds": members,
      "teamDescription": description,
      "teamStatus": status,
      "teamEmail": email,
      "teamPhone": phone,
    };
  }

  factory TeamsModel.fromJson(Map<String, dynamic> json) {
    return TeamsModel(
      tournamentId: json['tournamentId'],
      name: json['name'],
      logo: json['logo'],
      captain: json['captain'],
      members: List<String>.from(json['members'] ?? []),
      description: json['description'],
      status: json['status'],
      email: json['email'],
      phone: json['phone'],
    );
  }
}
