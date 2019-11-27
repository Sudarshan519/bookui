import 'dart:io';

import 'package:book/bookui/data/firebase.dart';
import 'package:book/bookui/models/book.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Upload extends StatefulWidget {
  final Book book;

  const Upload({Key key, this.book}) : super(key: key);

  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  File uploadImage;

  Future getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      uploadImage = tempImage;
    });
  }

  bool isLoading = false;
  var a = TextEditingController();
  var b = TextEditingController();
  var c = TextEditingController();
  var d = TextEditingController();
  bool isUpdate = false;
  String id;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.book != null) {
      setState(() {
        id = widget.book.id;

        isUpdate = true;
      });
      a.text = widget.book.name;
      b.text = widget.book.author;
      d.text = widget.book.price;
      c.text = widget.book.des;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'book name',
                      border: UnderlineInputBorder(),
                      filled: true,
                      icon: Icon(Icons.book),
                      prefixText: '+1',
                      ),

                    // onChanged: (a) {
                    //   setState(() {
                    //     name = a;
                    //   });
                    // },
                    controller: a,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'book description',
                      border: UnderlineInputBorder(),
                      filled: true,
                      icon: Icon(Icons.book),
                      prefixText: '+1',
                      ),
                    controller: b,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'book author',
                      border: UnderlineInputBorder(),
                      filled: true,
                      icon: Icon(Icons.book),
                      prefixText: '+1',
                      ),
                    controller: c,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            filled: true,
                            icon: Icon(Icons.attach_money),
                            hintText: 'Where can we reach you?',
                            labelText: 'Phone Number *',
                            prefixText: '+1',
                          ),
                    keyboardType: TextInputType.number,
                    controller: d,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RaisedButton(
                    onPressed: getImage,
                    child: Container(
                      child: Text('Choose your file'),
                    ),
                  ),
                  uploadImage == null ? Text('Select an Image') : enableUpload(),
                  OutlineButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      print(a.text);
                      Book book = Book();
                      book.name = a.text;
                      book.des = b.text;
                      book.author = c.text;
                      book.price = d.text;
                      if (isUpdate) {
                        book.id = id;
                        await firebaseHelper.updateBook(book).then((v) {
                          setState(() {
                            isLoading = false;
                          });
                        });
                      } else
                        await firebaseHelper.saveBook(book).then((v) {
                          setState(() {
                            isLoading = false;
                          });
                        });
                    },
                    child: isLoading
                        ? CircularProgressIndicator(
                            strokeWidth: 2,
                          )
                        : Text('save'),
                  ),

                  // books == null || books.length == 0
                  //     ? CircularProgressIndicator(
                  //         strokeWidth: 2,
                  //       )
                  //     : ListView.builder(
                  //         shrinkWrap: true,
                  //         itemCount: books.length,
                  //         itemBuilder: (BuildContext context, int index) {
                  //           var book = books[index];
                  //           return ListTile(
                  //             title: Text(book.name ?? ""),
                  //             trailing: Text(book.price ?? ""),
                  //             subtitle: Text(book.author ?? ""),
                  //           );
                  //         },
                  //       ),
                ],
              ),
      ),
    );
  }

  Widget enableUpload() {
    return Container(
      child: Column(
        children: <Widget>[
          Image.file(
            uploadImage,
            height: 308,
            width: 308,
          )
        ],
      ),
    );
  }
}
