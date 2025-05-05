class TournamentAddModel {
  String? tournamentId;
  String? name;
  String? description;
  String? imageUrl;
  String? organizer;
  String? venue;
  double? prizePool;
  List<String>? rules;
  Map<String, String>? timelines;
  String? startDate;
  String? endDate;
  String? location;
  String? email;
  String? phone;
  String? website;
  String? status;
  String? instagram;
  String? twitter;
  String? facebook;
  String? type;

  TournamentAddModel({
    this.name,
    this.description,
    this.imageUrl,
    this.organizer,
    this.venue,
    this.prizePool,
    this.rules,
    this.timelines,
    this.startDate,
    this.endDate,
    this.location,
    this.email,
    this.phone,
    this.website,
    this.status,
    this.type,
  });


  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "imageUrl": imageUrl,
      "organizer": organizer,
      "venue": venue,
      "prizePool": prizePool,
      "rules": rules,
      "timelines": timelines,
      "startDate": startDate,
      "endDate": endDate,
      "location": location,
      "email": email,
      "phone": phone,
      "website": website,
      "status": status,
      "type": type,
    };
}

  factory TournamentAddModel.fromJson(Map<String, dynamic> json) {
    return TournamentAddModel(
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      organizer: json['organizer'],
      venue: json['venue'],
      prizePool: json['prizePool']?.toDouble(),
      rules: List<String>.from(json['rules'] ?? []),
      timelines: Map<String, String>.from(json['timelines'] ?? {}),
      startDate: json['startDate'],
      endDate: json['endDate'],
      location: json['location'],
      email: json['email'],
      phone: json['phone'],
      website: json['website'],
      status: json['status'],
      type: json['type'],
    );
  }
}