import 'package:book/bookui/data/firebase.dart';
import 'package:book/bookui/models/book.dart';
import 'package:book/bookui/screens/upload.dart';
import 'package:flutter/material.dart';

class ListData extends StatefulWidget {
  @override
  _ListDataState createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {
  List<Book> books;
  @override
  void initState() {
    super.initState();
    firebaseHelper.getBooks().then((v) {
      setState(() {
        books = v;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: books.length,
      itemBuilder: (BuildContext context, int index) {
        var book = books[index];
        return ListTile(
          leading: CircleAvatar(
            
          ),
          title: Text(book.name ?? ""),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              firebaseHelper.delBook(book);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => Upload(book: book)),
              // );
            },
          ),
          subtitle: Text(book.id ?? ""),
        );
      },
    );
  }
}
