class PostModel {
  String? id;
  String? name;
  String? category;
  String? satuan;
  String? quantity;
  String? total;

  PostModel(
      {required this.id,
      required this.name,
      required this.category,
      required this.satuan,
      required this.quantity,
      required this.total});

  PostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category = json['category'];
    satuan = json['satuan'];
    quantity = json['quantity'];
    total = json['total'];
  }
}
