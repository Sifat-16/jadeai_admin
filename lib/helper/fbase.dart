import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jadeai_admin/models/botmodel.dart';

import '../models/rechargeModel.dart';
import '../models/withdrawmodel.dart';

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
        event.docs.map((e){
          Bot bot = Bot.fromJson(e.data());
          bot.id=e.id;
          return bot;
        }).toList());
  }

  updateBot(Bot bot)async{
    final x = await store.collection("bot").doc(bot.id).update(bot.toJson()).onError((error, stackTrace) => false);
    return true;
  }
  deleteBot(Bot bot)async{
    final x = await store.collection("bot").doc(bot.id).delete().onError((error, stackTrace) => false);
    return true;
  }


  Stream<List<WithdrawModel>> allwithdraws(){
    return store.collection("withdraws").snapshots().map((event) => event.docs.map((e) => WithdrawModel.fromJson(e.data())).toList());
  }

  allowWithdraw(WithdrawModel withdrawModel)async{
    final x = store.collection("withdraws").where("uid", isEqualTo: withdrawModel.uid).where("amount", isEqualTo: withdrawModel.amount).where("number", isEqualTo: withdrawModel.number).where("granted", isEqualTo: false).get().then((value) async{
      final y = store.collection("withdraws").doc(value.docs.first.id);
      await y.delete();
      /*await y.update({
        "granted":true
      });*/


    });
    final s = await store.collection("profile").doc(withdrawModel.uid).get();
    final z = store.collection("profile").doc(withdrawModel.uid).update(
        {
          "totalMoney":s.data()!["totalMoney"]-withdrawModel.amount
        }).then((value) async{

    });

    /*print(x.docs.first.data());

      x.docs.first.data().update("granted", (value) => true);
      print(x.docs.first.data()["granted"]);*/

  }

  Stream<List<RechargeModel>> allrechargerequest(){
    return store.collection("recharges").snapshots().map((event) => event.docs.map((e) => RechargeModel.fromJson(e.data())).toList());
  }

  acceptRecharge(RechargeModel rechargeModel)async{
    String doc = "";
    final k = await  store.collection("recharges").where("uid", isEqualTo: rechargeModel.uid).get().then((value) {
      doc = value.docs.first.id;
    });
    final s = await store.collection("profile").doc(rechargeModel.uid).get();
    final x = store.collection("profile").doc(rechargeModel.uid).update(
        {
          "totalMoney":s.data()!["totalMoney"]+double.parse(rechargeModel.amount!)
        }).then((value) async{
      final y = await store.collection("recharges").doc(doc).delete();
    });
  }

}