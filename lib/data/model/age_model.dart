class AgeEstimateModel {
  final int count;
  final String name;
  final int age;

  AgeEstimateModel({
    required this.count,
    required this.name,
    required this.age,
  });

  factory AgeEstimateModel.fromJson(Map<String, dynamic> json) {
    return AgeEstimateModel(
      count: json['count'],
      name: json['name'],
      age: json['age'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'name': name,
      'age': age,
    };
  }
}
