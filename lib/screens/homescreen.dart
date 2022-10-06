import 'package:flutter/material.dart';
import 'package:jadeai_admin/screens/addbotscreen.dart';
import 'package:jadeai_admin/screens/all_recharge_screen.dart';
import 'package:jadeai_admin/screens/allthebotsscreen.dart';

import 'all_the_withdraw.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("Jade Ai Admin"),
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddBotScreen()));

              },
              child: Container(
                width: MediaQuery.of(context).size.width*.5,
                height: MediaQuery.of(context).size.width*.25,
                decoration: BoxDecoration(
                  color: Colors.deepOrangeAccent,
                  borderRadius: BorderRadius.circular(10)

                ),
                child: Center(child: Text("Add Bot", style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width*.06
                ),)),
              ),
            ),

            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AllTheBotsScreen()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width*.5,
                height: MediaQuery.of(context).size.width*.25,
                decoration: BoxDecoration(
                    color: Colors.deepOrangeAccent,
                    borderRadius: BorderRadius.circular(10)

                ),
                child: Center(child: Text("All Bots Details", style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width*.06
                ),)),
              ),
            ),

            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AllRechargeScreen()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width*.5,
                height: MediaQuery.of(context).size.width*.25,
                decoration: BoxDecoration(
                    color: Colors.deepOrangeAccent,
                    borderRadius: BorderRadius.circular(10)

                ),
                child: Center(child: Text("All Recharge Request", style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width*.06
                ),)),
              ),
            ),

            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AllTheWithdraw()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width*.5,
                height: MediaQuery.of(context).size.width*.25,
                decoration: BoxDecoration(
                    color: Colors.deepOrangeAccent,
                    borderRadius: BorderRadius.circular(10)

                ),
                child: Center(child: Text("All withdraw Request", style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width*.06
                ),)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
