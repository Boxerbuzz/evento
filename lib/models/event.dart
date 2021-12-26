import 'package:flutter/material.dart';

class EventModel {
  final String timestamp;
  final String name;
  final String location;
  final String img;
  final String backdrop;
  final Color? color;

  EventModel(
      {this.timestamp = '',
      this.name = '',
      this.location = '',
      this.img = '',
      this.backdrop = '',
      this.color});

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      name: json['name'],
      backdrop: 'assets/images/${json['backdrop']}.png',
      img: 'assets/images/${json['img']}.png',
      location: json['location'],
      timestamp: json['date'],
      color: json['color'],
    );
  }

  @override
  String toString() {
    return 'EventModel{timestamp: $timestamp, name: $name, location: $location, img: $img, backdrop: $backdrop, color: $color}';
  }
}
