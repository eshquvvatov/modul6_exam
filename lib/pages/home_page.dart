import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/card_model.dart';
import '../service/hive_service.dart';
import 'add_card_page.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
static const id="/home_page";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<CardModel>list=[];
  String cardNumber="64687";
  String name="jskjf";
  String lastname="jhkjsfv";
  void loaddata(){

    setState(() {
      list.addAll( HiveDB.loadNotes());
    });


  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // loaddata();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Good Morning",style: TextStyle(color: Colors.grey.shade800),),
            Text("Eugene",style: TextStyle(color: Colors.black),)
          ],
        ),
        actions: [

          CircleAvatar(
            radius: 15,
            backgroundColor: Colors.blue,
            //backgroundImage: AssetImage("assest/images/bill.jpg"),
          ),
          SizedBox(width: 5,)
        ],
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 20,right: 20),
        children: [
          SizedBox(height: 20,),
          if(list.isNotEmpty)
          ListView.builder(
            itemCount: list.length,
              itemBuilder: (context, index){
              return buildCard(context,index);
              }),
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.grey,
              borderRadius: BorderRadius.circular(10)
            ),
            alignment: Alignment.center,
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddCardPage()));
                }, icon:Icon(CupertinoIcons.camera_viewfinder,size: 50,)),
                SizedBox(height: 10,),
                Text("Add new card")
              ],
            ) ,
          )
        ],
      ),
    );
  }

  Card buildCard(BuildContext context,index) {
    return Card(color: Colors.red,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),

      ),
      child: Container(
        height: 200,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            ListTile(
              leading: Container(
                height: 40,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10)
                ),

              ),
              trailing: Text("VISA",style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 10,),
            Text(list[index].cardNumber,style: TextStyle(color: Colors.white,fontSize: 20),),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Card wolder",style: TextStyle(color: Colors.white),),
                Text("Expires",style: TextStyle(color: Colors.white),),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(list[index].fullName,style: TextStyle(color: Colors.white,fontSize: 25),),
                Text("03/22",style: TextStyle(color: Colors.white),),

              ],
            ),
            SizedBox(height: 20,)

          ],
        ),
      ),
    );
  }
}
