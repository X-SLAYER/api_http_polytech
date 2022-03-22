class User {
  String? name;
  int? id;
  int? age;

  User({this.name, this.id, this.age});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['age'] = age;
    return data;
  }
}
