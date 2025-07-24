import 'package:cloud_firestore/cloud_firestore.dart';

class ApiUrl {
  const ApiUrl._();

  static final users = FirebaseFirestore.instance.collection("users");

}
