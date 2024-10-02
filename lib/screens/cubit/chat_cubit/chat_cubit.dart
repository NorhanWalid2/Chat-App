import 'package:bloc/bloc.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kmessageDataBase);
  void sendMessage({required String message, required String email}) {
    messages.add({
      kMessage: message,
      kTime: DateTime.now(),
      kIdEmail: email,
    });
  }

  void recieveMessage() {
    messages.orderBy('timestamp', descending: true).snapshots().listen((event) {
      List<MessageModel> messageList = [];
      messageList.clear();
      for (var doc in event.docs) {
        messageList
            .add(MessageModel.fromJson(doc.data() as Map<String, dynamic>));
      }
      emit(ChatSucess(messages: messageList));
    });
  }
}
