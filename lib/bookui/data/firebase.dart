import 'package:book/bookui/models/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseHelper {
  Firestore firestore = Firestore.instance;

  saveBook(Book book) async {
    var ref = firestore.collection("book").document();
    book.id=ref.documentID;
    await ref.setData(book.toJson());
  }

  updateBook(Book book) async {
    print(book.id);
    await firestore.collection("book").document(book.id).updateData(book.toJson());
  }
  delBook(Book book) async {
    var ref = firestore.collection("book").document(book.id);

    await ref.delete();
  }

  Future<List<Book>> getBooks() async {
    var data = await firestore.collection('book').getDocuments();
    return data.documents.map<Book>((da) => Book.fromJson(da.data)).toList();
  }
}

final FirebaseHelper firebaseHelper = FirebaseHelper();
