import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modul6_exam/service/util_service.dart';
import '../model/card_model.dart';
import '../service/hive_service.dart';
import '../service/http_service.dart';
import 'add_card_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const id = "/home_page";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CardModel> list = [];

  void loaddata() {
    HttpService.GET(HttpService.API_CARDS_LIST, HttpService.paramEmpty())
        .then((value) {
      if (value != null) {
        saveData(value);
      }
    });
  }

  void saveData(String response) {
    setState(() {
      list.addAll(HttpService.parseCards(response));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loaddata();
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
            Text(
              "Good Morning",
              style: TextStyle(color: Colors.grey.shade800),
            ),
            Text(
              "Eugene",
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
        actions:const [
          CircleAvatar(
            radius: 15,
            backgroundColor: Colors.blue,
            //backgroundImage: AssetImage("assest/images/bill.jpg"),
          ),
          SizedBox(width: 5,)
        ],
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 20, right: 20),
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(10)),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddCardPage()));
                    },
                    icon: Icon(
                      CupertinoIcons.camera_viewfinder,
                      size: 50,
                    )),
                SizedBox(
                  height: 10,
                ),
                Text("Add new card")
              ],
            ),
          ),
          if (list.isNotEmpty)
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return buildCard(context, list[index]);
                }),
        ],
      ),
    );
  }

  Dismissible buildCard(BuildContext context, CardModel index) {
    return Dismissible(
        key: const ValueKey(0),
        onDismissed: (DismissDirection direction) async {
          list.remove(index);
          await HttpService.DELETE(
              HttpService.API_DELETE + index.id, HttpService.paramEmpty());

          //DeleteoDialog(index);
        },
        direction: DismissDirection.endToStart,
        child: Card(
          color: Colors.red,
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
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  trailing: const Text("VISA", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
               const SizedBox(height: 10,),
                Text(
                  index.cardNumber, style:const TextStyle(color: Colors.white, fontSize: 20),
                ),
               const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Text(
                      "Card wolder",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "Expires",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      index.fullName,
                      style: TextStyle(color: Colors.white, fontSize: 23),
                    ),
                    Text(
                      "03/22",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ));
  }

// void DeleteoDialog(CardModel card) async {
//   return await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("Delete Confirmation"),
//           content: const Text("Are you sure you want to delete this item?"),
//           actions: <Widget>[
//             TextButton(
//
//               onPressed: ()async {
//                 list.remove(card);
//                 await HttpService.DELETE(HttpService.API_DELETE + card.id, HttpService.paramEmpty());
//               },
//               child: const Text("Delete"),
//             ),
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text("Cancel"),
//             ),
//           ],
//         );
//       });
// }
}
