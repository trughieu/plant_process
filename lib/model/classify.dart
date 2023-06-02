class Classify {
  String title;
  String des;
  String char;
  String id;

  Classify({
    required this.title,
    required this.des,
    required this.char,
    required this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'des': des,
      'char': char,
    };
  }

  factory Classify.fromJson(Map<String, dynamic> item) {
    return Classify(
      title: item['title'],
      des: item['des'],
      char: item['char'],
      id:item['_id']
    );
  }
}
