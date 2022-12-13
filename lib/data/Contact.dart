class Contact{
  final int? id;
  final String name;
  final String gmail;
  final int phonenumber;
  final String address;

  Contact({this.id,required this.name,required this.gmail,required this.phonenumber,required this.address});


  factory Contact.fromMap(Map<String, dynamic> json)=>new Contact(
      id: json["id"],
      name:json["name"],
      gmail: json["gmail"],
      phonenumber: json["phonenumber"],
      address: json['address']
  );

  Map<String ,dynamic> tomap(){
    return {
      'id':id,
      'name':name,
      'gmail':gmail,
      'phonenumber':phonenumber,
      'address':address
    };
  }
}