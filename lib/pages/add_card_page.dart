import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/card_model.dart';
import '../service/hive_service.dart';
class AddCardPage extends StatefulWidget {
  const AddCardPage({Key? key}) : super(key: key);
static const id="/add_card_page";
  @override
  _AddCardPageState createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  TextEditingController cardController=TextEditingController();
  TextEditingController fulNameController=TextEditingController();

  void loaddata(){
    List<CardModel>list=[];
    CardModel card=CardModel(cardNumber:cardController.text.trim().toString(),fullName: fulNameController.text.trim().toString() );
   list.addAll( HiveDB.loadNotes());
   list.add(card);
    HiveDB.storeNotes(list);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text("Add your card",style: TextStyle(color: Colors.white,fontSize: 25),),
        actions: [
          Icon(Icons.api,color: Colors.white,),
          SizedBox(width: 20,)
        ],
        centerTitle: false,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Text("Fill in the fields below or use camera phone",style: TextStyle(color: Colors.white,fontSize: 16),),
            SizedBox(height: 20,),
            Text("Your card number",style: TextStyle (color: Colors.white,fontSize: 20),),
            SizedBox(height: 5,),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white
              ),
              child: Row(
                children: [
                  SizedBox(width: 5,),
                 CircleAvatar(radius: 10,backgroundColor: Colors.blue,),
                  SizedBox(width: 5,),
                  Flexible(
                    child: TextField(
                      controller: cardController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Your card number",
                        border: InputBorder.none
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text("Expiry date",style: TextStyle(color: Colors.white),),
                    SizedBox(height: 5,),
                    Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                      ),
                    child: Row(
                      children: [
                        Expanded(child:
                        TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Month",
                            border: InputBorder.none

                          ),

                        )),
                        VerticalDivider(),
                       Flexible(child: TextField(
                         keyboardType: TextInputType.number,
                         decoration: InputDecoration(
                           hintText: "Day",
                             border: InputBorder.none
                         ),
                       ))
                      ],
                    ),
                    ),

                  ],
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text("Expiry date",style: TextStyle(color: Colors.white),),
                    SizedBox(height: 5,),
                    Container(
                      decoration: BoxDecoration(color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      height: 50,
                      width: 150,
                      alignment: AlignmentDirectional.center,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Your CVV2"
                        ),
                      ),
                    ),

                  ],
                ),
              ],
            ),
            SizedBox(height: 20,),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
              ),
              child:  TextField(
                controller: fulNameController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "Your fullname",
                    border: InputBorder.none

                ),

              ),
            ),
            Spacer(),
            MaterialButton(onPressed: (){
              loaddata();
            },
              shape: StadiumBorder(),color: Colors.white,
              child: Text("Save card"),
              height: 50,
              minWidth: MediaQuery.of(context).size.width,
            ),
            SizedBox(height: 50,)
          ],
        ),
      ),
    );
  }
}
