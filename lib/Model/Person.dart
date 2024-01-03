class Person {
  String? name;
  String? email;
  String? password;
  String? phone;
  String? gender;
  String? bloodType;
  int? age;
  String? lastDonationDate;
  int? donationCount;

  Person({
    this.name,
    this.email,
    this.password,
    this.phone,
    this.gender,
    this.bloodType,
    this.age,
    this.lastDonationDate,
    this.donationCount,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      name: json['fullName'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
      gender: json['gender'],
      bloodType: json['bloodType'],
      age: json['age'],
      lastDonationDate: json['lastDonationDate'],
      donationCount: json['donationCount'],
    );
  }

  Map<String, dynamic> toJson() => {
    'fullName': name,
    'email': email,
    'password': password,
    'phone': phone,
    'gender': gender,
    'bloodType': bloodType,
    'age': age,
    'lastDonationDate': lastDonationDate,
    'donationCount': donationCount,
  };
}
