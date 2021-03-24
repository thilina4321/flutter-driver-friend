import 'package:flutter/material.dart';

class AppointmentModel {
  String id;
  String userId;
  DateTime date;
  TimeOfDay time;
  String userName;

  AppointmentModel({this.id, this.userId, this.date, this.time, this.userName});
}
