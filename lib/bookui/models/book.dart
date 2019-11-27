class Book {
  String name;
  String price;
  String des;
  String author,id;


  Book({
    this.name,
    this.price,
    this.des,
    this.author,
    this.id,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        name: json["name"],
        price: json["price"],
        des: json["des"],
        author: json["author"],
        id:json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "des": des,
        "author": author,
        "id":id,
      };
}
