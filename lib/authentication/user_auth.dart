/*




import 'package:cloud_firestore/cloud_firestore.dart';

import 'response.dart';

final FirebaseFirestore _firestoreDB = FirebaseFirestore.instance;
final CollectionReference _usersCollection = _firestoreDB.collection('users');


class UserAuth{

  static Future<FirebaseResponse> createUser({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String mobileNumber,
    required String type,
  }) async {

    FirebaseResponse response =  FirebaseResponse();
    DocumentReference documentReferencer =
    _usersCollection.doc();

    Map<String, dynamic> users = <String, dynamic>{
      "email": email,
      "password": password,
      "firsName" : firstName,
      "lastName" : lastName,
      "number" : mobileNumber,
      "type": type,
    };

    var result = await documentReferencer
        .set(users)
        .whenComplete(() {
      response.code = 200;
      response.message = "Successfully added to the database";
    })
        .catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

}*/


import 'package:shared_preferences/shared_preferences.dart';

class UserAuth {
  static String? teacherEmail, teacherLastName, teacherFirstName, teacherMobileNumber;

  static Future<void>saveTeacherProfileData([String? email, String? lastName,
  String? firstName, String? mobileNumber])async{

    final sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString("email", email ?? "");
    sharedPreferences.setString("lastName", lastName ?? "");
    sharedPreferences.setString("firstName", firstName ?? "");
    sharedPreferences.setString("mobileNumber", mobileNumber ?? "");

    teacherEmail = email;
    teacherFirstName=firstName;
    teacherLastName = lastName;
    teacherMobileNumber = mobileNumber;

  }

  static Future<void> getTeacherProfileData() async {
    final prefs = await SharedPreferences.getInstance();

    teacherEmail = prefs.getString("email");
    teacherFirstName = prefs.getString("firstName");
    teacherLastName = prefs.getString("lastName");
    teacherMobileNumber = prefs.getString("mobileNumber");
  }
}
