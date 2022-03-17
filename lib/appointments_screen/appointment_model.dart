import 'package:flutter/cupertino.dart';

class AppointmentModel {
  final String uid;
  final String imageAvatar;
  final String username;
  final String relationType;
  final String bookingDate;
  final String status;
  final DateTime time;

  AppointmentModel(
      {@required this.bookingDate,
      @required this.imageAvatar,
      @required this.relationType,
      @required this.uid,
      @required this.status,
      @required this.username,
      @required this.time});

  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      AppointmentModel(
          bookingDate: json['relation_type'],
          imageAvatar: json['imageLink'],
          relationType: json['relation_type'],
          uid: json['uid'],
          status: json['status'],
          username: json['username'],
          time: DateTime.parse(json['time']));

  Map<String, dynamic> toJson() => {
        "uid": this.uid,
        "username": this.username,
        "relation_type": this.relationType,
        "imageLink": this.imageAvatar,
        "status": this.status,
        "time": this.time.toString()
      };
}
