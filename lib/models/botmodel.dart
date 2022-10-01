import 'package:firebase_auth/firebase_auth.dart';

class Bot{
  String? id;
  String? name;
  double? price;
  double? daily_add;
  int? active_days;
  DateTime? created;
  DateTime? expired;
  List<String> users_uid=[];
  Bot({this.name, this.price, this.daily_add, this.active_days, this.created, this.expired});

  Map<String, dynamic> toJson()=>{
    "name":name,
    "price":price,
    "daily_add":daily_add,
    "active_days":active_days,
    "created":created,
    "expired":expired,
    "users_uid":users_uid,
  };

  Bot.fromJson(Map<String, dynamic> json){
    try{
      name = json["name"];
    }catch(e){

    }
    try{
      price = json["price"];
    }catch(e){

    }
    try{
      daily_add = json["daily_add"];
    }catch(e){

    }
    try{
      active_days = json["active_days"];
    }catch(e){

    }
    try{
      created = DateTime.fromMillisecondsSinceEpoch(json["created"].seconds*1000);
    }catch(e){

    }
    try{
      expired = DateTime.fromMillisecondsSinceEpoch(json["expired"].seconds*1000);
    }catch(e){

    }

    try{

      if(json["users_uid"]!=null){
        users_uid = [];
        json["users_uid"].forEach((e){
          users_uid.add(e);
        });
      }else{
        users_uid = [];
      }

    }catch(e){
      //print(json["teamMember"]);
      print("teamMemberrrrrr");
    }
  }


}