import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';

class BubbleChatSender extends StatelessWidget {
  const BubbleChatSender(
      {super.key, required this.message, required this.time});
  final MessageModel message;
  final String time;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        // width: 250,
        //height: 50,
        padding:
            const EdgeInsets.only(left: 16, top: 16, bottom: 10, right: 16),
        margin: const EdgeInsets.only(left: 16, bottom: 10, top: 10),
        // constraints: BoxConstraints(
        //   maxWidth:
        //       MediaQuery.of(context).size.width * 0.70, // 75% of screen width
        // ),
        decoration: const BoxDecoration(
            color: kbackGroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
              topRight: Radius.circular(30),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end, // Align time to the left
          children: [
            Text(
              message.message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 5), // Add space between message and time
            Text(
              time, // Display the time
              style: const TextStyle(
                color: Colors.white70, // Light color for time
                fontSize: 12, // Smaller font size for time
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BubbleChatReciver extends StatelessWidget {
  const BubbleChatReciver(
      {super.key, required this.message, required this.time});
  final MessageModel message;
  final String time;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        // width: 250,
        //height: 50,
        padding:
            const EdgeInsets.only(left: 16, top: 16, bottom: 10, right: 16),
        margin: const EdgeInsets.only(right: 16, bottom: 10, top: 10),
        // constraints: BoxConstraints(
        //   maxWidth:
        //       MediaQuery.of(context).size.width * 0.70, // 75% of screen width
        // ),
        decoration: const BoxDecoration(
            color: Color.fromARGB(209, 61, 46, 43),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end, // Align time to the right
          children: [
            Text(
              message.message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 5), // Add space between message and time
            Text(
              time, // Display the time
              style: const TextStyle(
                color: Colors.white70, // Light color for time
                fontSize: 12, // Smaller font size for time
              ),
            ),
          ],
        ),
      ),
    );
  }
}
