import 'package:flutter/material.dart';
import 'package:jadeai_admin/helper/fbase.dart';
import 'package:jadeai_admin/models/withdrawmodel.dart';

class AllTheWithdraw extends StatefulWidget {
  const AllTheWithdraw({Key? key}) : super(key: key);

  @override
  State<AllTheWithdraw> createState() => _AllTheWithdrawState();
}

class _AllTheWithdrawState extends State<AllTheWithdraw> {
  FireBase fireBase = FireBase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Withdraws"),
      ),
      body: StreamBuilder<List<WithdrawModel>>(
          stream: fireBase.allwithdraws(),
          builder: (context, s){
            return s.hasData?ListView.builder(
                itemCount: s.data?.length,
                itemBuilder: (context, index){
                  return ListTile(
                    title: Text("${s.data![index].number}"),
                    subtitle: Text("${s.data![index].amount}"),
                    /*trailing: !s.data![index].granted? IconButton(onPressed: ()async{

                      await fireBase.allowWithdraw(s.data![index].uid!);

                    }, icon: Icon(Icons.add)):SizedBox.shrink()*/
                    /*trailing: TextButton(onPressed: ()async{
                      await fireBase.acceptRecharge(s.data![index]);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Recharge Accepted")));

                    }, child: Text("Accept")),*/
                    trailing: TextButton(onPressed: ()async{
                      await fireBase.allowWithdraw(s.data![index]);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Withdraw accepted")));
                    }, child: Text("Accept")),


                  );
                }
            ):CircularProgressIndicator();
          }
      ),

    );
  }
}
