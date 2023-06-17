
class CreateUserModel {
  final String? id;
  final String email;
  final String password;
  final String fistName;
  final String lastName;
  final String number;
  final String? userType;

  const CreateUserModel(
      {this.id,
      required this.email,
      required this.password,
      required this.fistName,
      required this.lastName,
      required this.number,
      this.userType});

  /*toJson(){
    return{
      "email" : email,
      "password" : password,
      "fistName" : fistName,
      "lastName" : lastName,
      "number" : number,
      "type" : userType,
    };
  }*/
}