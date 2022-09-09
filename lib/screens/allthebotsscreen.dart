import 'package:flutter/material.dart';
import 'package:jadeai_admin/helper/fbase.dart';
import 'package:jadeai_admin/models/botmodel.dart';

class AllTheBotsScreen extends StatefulWidget {
  const AllTheBotsScreen({Key? key}) : super(key: key);

  @override
  State<AllTheBotsScreen> createState() => _AllTheBotsScreenState();
}

class _AllTheBotsScreenState extends State<AllTheBotsScreen> {
  FireBase fireBase = FireBase();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("All the bots"),
      ),
      body: StreamBuilder<List<Bot>>(
        stream: fireBase.allthebots(),
          builder: (context, snapshot){
          if(snapshot.hasData){
            print(snapshot.data?.length);
          }
            return snapshot.hasData?ListView.builder(
              itemCount: snapshot.data?.length,
                itemBuilder: (context, index){
                  return Card(
                    child: Column(
                      children: [
                        Text("${snapshot.data![index].name}"),
                        Text("${snapshot.data![index].price}"),
                        Text("${snapshot.data![index].expired}"),
                        Text("${snapshot.data![index].daily_add}--"),


                      ],
                    ),
                  );
                }
            ):Center(child: CircularProgressIndicator(),);
          }
      ),
    );
  }
}
