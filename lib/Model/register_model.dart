// To parse this JSON data, do
//
//     final registerModel = registerModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

RegisterModel registerModelFromMap(String str) => RegisterModel.fromMap(json.decode(str));

String registerModelToMap(RegisterModel data) => json.encode(data.toMap());

class RegisterModel {
  String message;

  RegisterModel({
    required this.message,
  });

  factory RegisterModel.fromMap(Map<String, dynamic> json) => RegisterModel(
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "message": message,
  };
}
