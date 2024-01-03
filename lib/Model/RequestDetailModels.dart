import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BloodRequest {
  final int id;
  final User user;
  final Hospital hospital;
  final String bloodType;
  final String status;
  final List<int> dateRequested;
  final String title;
  final String description;

  BloodRequest({
    required this.id,
    required this.user,
    required this.hospital,
    required this.bloodType,
    required this.status,
    required this.dateRequested,
    required this.title,
    required this.description,
  });

  factory BloodRequest.fromJson(Map<String, dynamic> json) {
    return BloodRequest(
      id: json['id'],
      user: User.fromJson(json['user']),
      hospital: Hospital.fromJson(json['hospital']),
      bloodType: json['bloodType'],
      status: json['status'],
      dateRequested: List<int>.from(json['dateRequested']),
      title: json['title'],
      description: json['description'],
    );
  }
}

class User {
  final int id;
  final String fullName;
  final String email;
  final String password;
  final String phone;
  final String gender;
  final String bloodType;
  final String tcNo;
  final int age;
  final List<int> lastDonationDate;
  final int donationCount;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.password,
    required this.phone,
    required this.gender,
    required this.bloodType,
    required this.tcNo,
    required this.age,
    required this.lastDonationDate,
    required this.donationCount,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
      gender: json['gender'],
      bloodType: json['bloodType'],
      tcNo: json['tcNo'],
      age: json['age'],
      lastDonationDate: List<int>.from(json['lastDonationDate']),
      donationCount: json['donationCount'],
    );
  }
}

class Hospital {
  final int id;
  final Location location;
  final String name;
  final String phone;

  Hospital({
    required this.id,
    required this.location,
    required this.name,
    required this.phone,
  });

  factory Hospital.fromJson(Map<String, dynamic> json) {
    return Hospital(
      id: json['id'],
      location: Location.fromJson(json['location']),
      name: json['name'],
      phone: json['phone'],
    );
  }
}

class Location {
  final int id;
  final String city;
  final String district;
  final String mahalle;

  Location({
    required this.id,
    required this.city,
    required this.district,
    required this.mahalle,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      city: json['city'],
      district: json['district'],
      mahalle: json['mahalle'],
    );
  }
}



