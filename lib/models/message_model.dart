import 'package:chat_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/foundation.dart';

class MessageModel {
  final String message;
  final String id;
  final Timestamp timestamp;

  MessageModel(this.message, this.id, this.timestamp);
  factory MessageModel.fromJson(Map jsonData) {
    return MessageModel(
        jsonData[kMessage], jsonData[kIdEmail], jsonData[kTime]);
  }
}
