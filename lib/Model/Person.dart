class Person {
  String? name;
  String? surname;

  Person({this.name, this.surname});

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      name: json['fullName'],
      surname: json['surname'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'surname': surname,
  };
}