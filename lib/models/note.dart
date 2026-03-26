class Note {
  final String title;
  final String content;
  final String date;

  Note({
    required this.title,
    required this.content,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'date': date,
    };
  }

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      title: json['title'],
      content: json['content'],
      date: json['date'],
    );
  }
}