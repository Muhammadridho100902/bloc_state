class KeepModel {
  final String username;
  final String univeristy;

  KeepModel({required this.username, required this.univeristy});

  factory KeepModel.fromJson(Map<String, dynamic> json) {
    return KeepModel(
      username: json['username'],
      univeristy: json['univeristy'],
    );
  }
}
