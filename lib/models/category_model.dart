class CategoryModel {
  final String id;
  final String title;
  final String slugName;

  CategoryModel({
    required this.id,
    required this.title,
    required this.slugName,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json['id'],
        title: json['title'],
        slugName: json['slug_name'],
      );
}
