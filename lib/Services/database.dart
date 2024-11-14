import 'package:brew_crew/Models/Brew.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/DataOfUser.dart';

class DatabaseService {
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection("Brews");
  final String uid;

  DatabaseService(this.uid);

  Future updateUserData(String sugar, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      "sugar": sugar,
      "name": name, // Use currentName or data?.name
      "strength": strength,
    });
  }

  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(BrewListFromSnapshot);
  }

  List<Brew> BrewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(
        name: doc.get('name') ?? '',
        sugar: doc.get('sugar') ?? '',
        strength: doc.get('strength') ?? 100, // Convert to int
      );
    }).toList();
  }

  UData userDatafromSnapshot(DocumentSnapshot snapshot, String uid) {
    return UData(
      uid: uid,
      name: snapshot.get('name') ?? '',
      // Access using key and provide default
      sugar: snapshot.get('sugar') ?? '',
      // Access using key and provide default
      strength:
          snapshot.get('strength') ?? 100, // Access using key and provide default
    );
  }

  Stream<UData> get DataOfUser {
    return brewCollection.doc(uid).snapshots().map((snapshot) =>
            userDatafromSnapshot(snapshot, uid) // Call with correct arguments
        );
  }
}
