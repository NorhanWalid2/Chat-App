import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/screens/cubit/chat_cubit/chat_cubit.dart';
import 'package:chat_app/widgets/bubble_chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable

class ChatScreen extends StatelessWidget {
  static String id = 'chat';
  List<MessageModel> messageList = [];
  TextEditingController controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String formatTimestamp(Timestamp timestamp) {
    var date = timestamp.toDate();
    return DateFormat('HH:mm').format(date); // Format: 14:30
  }

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments.toString();
    // return StreamBuilder<QuerySnapshot>(

    //   builder: (context, snapshot) {
    //     if (snapshot.hasData) {
    //       List<MessageModel> messageList = [];
    //       for (var doc in snapshot.data!.docs) {
    //         // Use doc.data() to get the map representation
    //         var data = doc.data() as Map<String, dynamic>;
    //         messageList.add(MessageModel.fromJson(data));
    //       }
    //       WidgetsBinding.instance.addPostFrameCallback((_) {
    //         if (_scrollController.hasClients) {
    //           _scrollController.animateTo(
    //             0,
    //             // _scrollController.position.maxScrollExtent,
    //             duration: const Duration(milliseconds: 300),
    //             curve: Curves.easeOut,
    //           );
    //         }
    //       });
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kbackGroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              KLogo,
              height: 45,
              width: 45,
            ),
            const Text('RELAX COFEE'),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                // TODO: implement listener
                if (state is ChatSucess) {
                  messageList = state.messages;
                }
              },
              builder: (context, state) {
                return ListView.builder(
                  reverse: true,
                  controller: _scrollController,
                  itemCount: messageList.length,
                  itemBuilder: (context, index) {
                    String formattedTime = formatTimestamp(
                        messageList[index].timestamp); // Get formatted time
                    return messageList[index].id == email
                        ? BubbleChatSender(
                            message: messageList[index],
                            time: formattedTime,
                          )
                        : BubbleChatReciver(
                            message: messageList[index],
                            time: formattedTime,
                          );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      BlocProvider.of<ChatCubit>(context)
                          .sendMessage(message: data, email: email);
                      controller.clear();
                    },
                    decoration: InputDecoration(
                      suffix: const Icon(
                        Icons.keyboard_voice,
                        color: kbackGroundColor,
                      ),
                      hintText: 'Type your message...',
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                // IconButton(
                //   icon: const Icon(Icons.send),
                //   color: kbackGroundColor,
                //   onPressed: () {
                //     // Send message when icon is clicked
                //     if (controller.text.isNotEmpty) {
                //       controller.clear();
                //     }
                //   },
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
