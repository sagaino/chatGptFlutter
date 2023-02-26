class ModelModels {
  final String id;
  final int created;
  final String root;

  ModelModels({
    required this.id,
    required this.created,
    required this.root,
  });

  factory ModelModels.fromJson(Map<String, dynamic> json) => ModelModels(
        id: json["id"],
        created: json["created"],
        root: json["root"],
      );
  static List<ModelModels> modelFromSnapshot(List modelSnapshot) {
    return modelSnapshot
        .map(
          (data) => ModelModels.fromJson(data),
        )
        .toList();
  }
}
