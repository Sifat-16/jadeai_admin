import 'package:flutter/material.dart';
import 'package:jadeai_admin/helper/fbase.dart';
import 'package:jadeai_admin/models/rechargeModel.dart';

class AllRechargeScreen extends StatefulWidget {
  const AllRechargeScreen({Key? key}) : super(key: key);

  @override
  State<AllRechargeScreen> createState() => _AllRechargeScreenState();
}

class _AllRechargeScreenState extends State<AllRechargeScreen> {
  FireBase fireBase = FireBase();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Recharges"),
      ),
      body: StreamBuilder<List<RechargeModel>>(
          stream: fireBase.allrechargerequest(),
          builder: (context, s){
            return s.hasData?ListView.builder(
                itemCount: s.data?.length,
                itemBuilder: (context, index){
                  return ListTile(
                    title: Text("${s.data![index].transactionId}"),
                    subtitle: Text("${s.data![index].amount}"),
                    /*trailing: !s.data![index].granted? IconButton(onPressed: ()async{

                      await fireBase.allowWithdraw(s.data![index].uid!);

                    }, icon: Icon(Icons.add)):SizedBox.shrink()*/
                    trailing: TextButton(onPressed: ()async{
                      await fireBase.acceptRecharge(s.data![index]);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Recharge Accepted")));

                    }, child: Text("Accept")),


                  );
                }
            ):CircularProgressIndicator();
          }
      ),
    );
  }
}
