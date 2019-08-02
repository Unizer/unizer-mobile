import 'package:Unizer/connector.dart';

class UniData {
  Widget build(
      {BuildContext context,
      String collectionName,
      String uid,
      String fieldName}) {
    return StreamBuilder(
        stream: Firestore.instance
            .collection(collectionName)
            .document(uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text("Loading");
          }
          var userDocument = snapshot.data;
          return Text(userDocument[fieldName]);
        });
  }
}
