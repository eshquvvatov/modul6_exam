class CardModel{
 late String cardNumber;
 late String fullName;

  CardModel({required this.cardNumber,required this.fullName});

  CardModel.fromJson(Map<String,dynamic>json){
    cardNumber=json["cardNumber"];
    fullName =json["fullName"];
  }

  Map<String ,String>toJson(){
    return {
      "cardNumber":cardNumber,
      "fullName":fullName
    };
  }
}