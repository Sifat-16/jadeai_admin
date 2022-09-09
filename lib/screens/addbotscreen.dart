import 'package:flutter/material.dart';
import 'package:jadeai_admin/helper/fbase.dart';
import 'package:jadeai_admin/models/botmodel.dart';

class AddBotScreen extends StatefulWidget {
  const AddBotScreen({Key? key}) : super(key: key);

  @override
  State<AddBotScreen> createState() => _AddBotScreenState();
}

class _AddBotScreenState extends State<AddBotScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController daily_add = TextEditingController();
  TextEditingController active_days = TextEditingController();
  int ac_days=0;
  DateTime today = DateTime.now();
  DateTime expired = DateTime.now();
  FireBase fireBase = FireBase();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        title: Text("Add a Bot"),
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

                final y = await fireBase.createBot(
                    Bot(
                        name: name.text.trim(),
                        price: double.parse(price.text.trim()),
                        daily_add: double.parse(daily_add.text.trim()),
                        active_days: int.parse(active_days.text.trim()),
                        created: today,
                        expired: expired
                    )
                );
                if(y==true){
                  this.setState(() {
                    name.clear();
                    price.clear();
                    daily_add.clear();
                    active_days.clear();
                    today = DateTime.now();
                    expired = DateTime.now();
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Bot Added")));
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Server failed")));
                }

              }, child: Text("Add Bot"))
            ],
          ),
        ),
      ),

    );
  }
}
