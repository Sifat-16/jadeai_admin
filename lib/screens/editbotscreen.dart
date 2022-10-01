import 'package:flutter/material.dart';

import '../helper/fbase.dart';
import '../models/botmodel.dart';

class EditBotScreen extends StatefulWidget {
  EditBotScreen({Key? key, required this.bot}) : super(key: key);
  Bot bot;
  @override
  State<EditBotScreen> createState() => _EditBotScreenState();
}

class _EditBotScreenState extends State<EditBotScreen> {

  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController daily_add = TextEditingController();
  TextEditingController active_days = TextEditingController();
  int ac_days=0;
  DateTime today = DateTime.now();
  DateTime expired = DateTime.now();
  FireBase fireBase = FireBase();

  @override
  void initState() {
    // TODO: implement initState
    name.text = widget.bot.name!;
    price.text = widget.bot.price.toString();
    daily_add.text = widget.bot.daily_add.toString();
    active_days.text = widget.bot.active_days.toString();
    today = widget.bot.created!;
    expired = widget.bot.expired!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        title: Text("Edit a Bot"),
      ),

      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height-kToolbarHeight,
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: name,
                decoration: InputDecoration(
                    hintText: "Name of the Bot",
                    border: OutlineInputBorder(

                    )
                ),
              ),
              TextField(
                controller: price,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "Price of the Bot",
                    border: OutlineInputBorder(

                    )
                ),
              ),
              TextField(
                controller: daily_add,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "Daily add of the Bot",
                    border: OutlineInputBorder(

                    )
                ),
              ),
              TextField(
                controller: active_days,
                onChanged: (s){
                  int days = int.parse(s);
                  this.setState(() {
                    expired = DateTime(today.year, today.month, today.day+days);
                  });

                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "Active days of the Bot",
                    border: OutlineInputBorder(

                    )
                ),
              ),
              Text("Created at: ${today.year}-${today.month}-${today.day}", style: TextStyle(
                  fontWeight: FontWeight.bold
              ),),
              Text("Expired at: ${expired.year}-${expired.month}-${expired.day}", style: TextStyle(
                  fontWeight: FontWeight.bold
              ),),
              TextButton(onPressed: ()async{
                Bot bot = Bot(
                    name: name.text.trim(),
                    price: double.parse(price.text.trim()),
                    daily_add: double.parse(daily_add.text.trim()),
                    active_days: int.parse(active_days.text.trim()),
                    created: today,
                    expired: expired
                );
                bot.id = widget.bot.id;
                bot.users_uid=widget.bot.users_uid;

                final y = await fireBase.updateBot(
                  bot
                );
                if(y==true){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Bot updated")));
                  Navigator.pop(context);
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Server failed")));
                }

              }, child: Text("Update Bot"))
            ],
          ),
        ),
      ),

    );
  }
}
