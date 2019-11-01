class Todo {
  final int id;
  String text;
  String status;

  Todo({this.id, this.text, this.status});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'status': status,
    };
  }
}
