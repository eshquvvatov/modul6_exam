class CardModel{
 late String cardNumber;
 late String fullName;
 late String month;
 late String cvv;
 late String id;
  CardModel({required this.cardNumber,required this.fullName, required this.month , required this.cvv});

  CardModel.fromJson(Map<String,dynamic>json){
    cardNumber=json["cardNumber"];
    fullName =json["fullName"];
    month=json["month"];
    cvv = json["cvv"];
    id=json["id"];
  }

  Map<String ,String>toJson(){
    return {
      "cardNumber":cardNumber,
      "fullName":fullName,
      "month":month,
      "cvv":cvv,
      "id":id
    };
  }
}