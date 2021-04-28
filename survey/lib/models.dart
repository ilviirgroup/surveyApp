class Questions {
  final String question;
  final int id;
  Questions(this.question, this.id);
  factory Questions.fromMap(Map<String, dynamic> json) {
    return Questions(
      json['question'],
      json['pk'],
    );
  }
}

class Answer {
  final int id;
  final String result;
  final String question;
  Answer(this.id, this.result, this.question);
  factory Answer.fromMap(Map<String, dynamic> json) {
    return Answer(
      json['pk'],
      json['results'],
      json['question'],
    );
  }
}
