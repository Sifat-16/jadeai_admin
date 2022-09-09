import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jadeai_admin/models/botmodel.dart';

class FireBase{
  final store = FirebaseFirestore.instance;

  createBot(Bot bot)async {
    final x = await store.collection("bot").doc().set(bot.toJson()).onError((
        error, stackTrace) => false)
    .then((value) {
      print("added");
    });
    return true;
  }

  Stream<List<Bot>> allthebots(){
    return store
        .collection("bot")
        .snapshots()
        .map((event) =>
        event.docs.map((e) => Bot.fromJson(e.data())).toList());
  }

}