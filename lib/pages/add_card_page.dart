import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../model/card_model.dart';
import '../service/hive_service.dart';
import '../service/http_service.dart';
import '../service/util_service.dart';
import 'home_page.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({Key? key}) : super(key: key);
  static const id = "/add_card_page";

  @override
  _AddCardPageState createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  TextEditingController cardController = TextEditingController();
  TextEditingController fulNameController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  String cardNumber="";
  void loaddata() async {
    if (cardController.text.isEmpty ||
        fulNameController.text.isEmpty ||
        monthController.text.isEmpty ||
        yearController.text.isEmpty ||
        cvvController.text.isEmpty) {
      Utils.fireSnackBar("All fields must be filled", context);
      return;
    }
    //  List<CardModel>list=[];
    //  CardModel card=CardModel(cardNumber:cardController.text.trim().toString(),fullName: fulNameController.text.trim().toString(),month: monthController.text.trim().toString(),cvv: cvvController.text.trim().toString() );
    // list.addAll( HiveDB.loadNotes());
    // list.add(card);
    //  HiveDB.storeNotes(list);

    await HttpService.POST(
        HttpService.API_CREATE_CARD,
        HttpService.PostBody(CardModel(
            cardNumber: cardController.text.trim().toString(),
            fullName: fulNameController.text.trim().toString(),
            month: monthController.text.trim().toString(),
            cvv: cvvController.text.trim().toString())));
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text(
          "Add your card",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        actions: [
          Icon(
            Icons.api,
            color: Colors.white,
          ),
          SizedBox(
            width: 20,
          )
        ],
        centerTitle: false,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Fill in the fields below or use camera phone",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Your card number",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Row(
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  Transform.translate(
                    offset: Offset(10, 0),
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.blueAccent,
                    ),
                  ),
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.blue.withOpacity(0.8),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    child: TextField(
                      // maxLength: 19,maxLines: 1,maxLengthEnforcement:MaxLengthEnforcement.none ,
                      maxLength: 16,textAlign: TextAlign.start,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      
                      onChanged: (text) {
                       if(cardController.text.length==15){
                         Scaffold(
                             body:Center(child: Text("jnfkjznkjn"),)
                         );
                       }

                      },
                      controller: cardController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(contentPadding: EdgeInsets.only(top: 5,bottom: 5,right: 5),
                          hintText: "xxxx xxxx xxxx xxxx",
                          counterStyle: TextStyle(color: Colors.black,fontSize: 15),
                          border: InputBorder.none),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Expiry date",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 50,
                      width: 140,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Expanded(
                              child: TextField(
                            controller: monthController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 10),
                                hintText: "Month",
                                border: InputBorder.none),
                          )),
                          VerticalDivider(),
                          Flexible(
                              child: TextField(
                            controller: yearController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 10),
                                hintText: "Year",
                                border: InputBorder.none),
                          ))
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "CVV",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      height: 50,
                      width: 140,
                      alignment: AlignmentDirectional.center,
                      child: TextField(
                        controller: cvvController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10),
                            border: InputBorder.none,
                            hintText: "Your CVV2"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Card name",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: TextField(
                maxLength: 20,
                controller: fulNameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  counterText: "",
                    contentPadding: EdgeInsets.only(left: 10),
                    // hintText: "Inter card name",
                    border: InputBorder.none),
              ),
            ),
            Spacer(),
            MaterialButton(
              onPressed: () {
                loaddata();
              },
              shape: StadiumBorder(),
              color: Colors.white,
              child: Text("Save card"),
              height: 50,
              minWidth: MediaQuery.of(context).size.width,
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
