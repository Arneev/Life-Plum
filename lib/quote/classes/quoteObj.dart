class QuoteObj {
  String text, author;

  QuoteObj(this.text, this.author);

  factory QuoteObj.fromJson(dynamic json) {
    return QuoteObj(json['text'] as String, json['author'] as String);
  }

  @override
  String toString() {
    return '{ ${this.text}, ${this.author}}';
  }
}
