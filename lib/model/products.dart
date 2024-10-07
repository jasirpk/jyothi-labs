class AllProductsModel {
  final String image;
  final String name;

  AllProductsModel({
    required this.image,
    required this.name,
  });
  factory AllProductsModel.formjson(Map<String, dynamic> json) {
    return AllProductsModel(
      image: json['url'] ?? "",
      name: json['name'] ?? "",
    );
  }
}
