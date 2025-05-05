class Gallerymodel {
  String? tournamentId;
  List<String>? photos;

  Gallerymodel({
    this.tournamentId,
    this.photos,
  });

  Map<String, dynamic> toJson() {
    return {
      "tournamentId": tournamentId,
      "photos": photos,
    };
  }

  factory Gallerymodel.fromJson(Map<String, dynamic> json) {
    return Gallerymodel(
      tournamentId: json['tournamentId'],
      photos: List<String>.from(json['photos'] ?? []),
    );
  }
}