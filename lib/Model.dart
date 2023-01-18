
class Model{
  final int? id;
  final String name;
  final String number;
  final String? email;
  final String? imgPath;

  Model({this.id, required this.name,required this.number, this.email,this.imgPath,});

  factory Model.fromMap(Map<String,dynamic>json)=> Model(
    id:json['id'],
    name:json['name'],
    number:json['number'],
    email:json['email'],
    imgPath:json['imgPath'],
  );

  Map<String,dynamic> toMap(){
    return{
      'id':id,
      'name':name,
      'number':number,
      'email':email,
      'imgPath':imgPath,

    };
  }
}