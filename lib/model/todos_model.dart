import '../utils.dart';

class TodoField {
  static const createdTime = 'createdTime';
}

//?The ToDos objects
class Todo {
  int? id;
  String title;
  String description;
  DateTime? createdTime;
  bool isDone;

  Todo({
    this.id, //!nullable
    required this.createdTime,
    required this.title,
    this.description = '',
    this.isDone = false,
  });

  static Todo fromJson(Map<String, dynamic> json) => Todo(
        createdTime: Utils.toDateTime(json['createdTime']),
        title: json['title'],
        description: json['description'],
        id: json['id'],
        isDone: json['isDone'],
      );
  Map<String, dynamic> toJson() => {
        'createdTime': Utils.fromDateTimeToJson(createdTime!),
        'title': title,
        'description': description,
        'id': id,
        'isDone': isDone,
      };
}
