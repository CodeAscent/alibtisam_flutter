class CategoryModel {
  final String id;
  final String name;

  CategoryModel(this.id, this.name);

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      json['_id'],
      json['name'],
    );
  }
}
