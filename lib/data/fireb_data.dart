// import 'package:flutter/material.dart';
// import 'package:unizer/connector.dart';
//
// class UniData {
//   Widget build({
//     BuildContext? context,
//     required String collectionName,
//     required String uid,
//     required String fieldName,
//   }) {
//     return StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection(collectionName)
//             .doc(uid)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return Text("Loading");
//           } else {
//             var userDocument = snapshot.data;
//             return Text(userDocument![fieldName]);
//           }
//         });
//   }
// }
