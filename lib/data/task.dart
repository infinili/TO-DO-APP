class Task {
  int id;
  String title;
  bool completed;
  String priority;
  DateTime? date;

  Task({
    required this.id,
    required this.title,
    required this.completed,
    required this.priority,
    this.date,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: int.parse(json["element"]["id"]),
        title: json["element"]["text"],
        priority: json["element"]["importance"],
        date: json["element"]["deadline"] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(json["element"]["deadline"]),
        completed: bool.parse(json["element"]["done"]),
      );

  Map<String, dynamic> toJson() => {
        "status": "ok",
        "element": {
          "id": id.toString(),
          // уникальный идентификатор элемента STRING
          "text": title,
          // STRING
          "importance": priority,
          // importance = low | basic | important STRING
          "deadline":
              date == null ? null : date!.toUtc().millisecondsSinceEpoch,
          // int64, может отсутствовать, тогда нет INT
          "done": completed.toString(),
          // BOOL
          "color": "",
          // может отсутствовать STRING
          "created_at": DateTime.now().toUtc().millisecondsSinceEpoch,
          // INT
          "changed_at": DateTime.now().toUtc().millisecondsSinceEpoch,
          // INT
          "last_updated_by": "iphone",
          // STRING
        },
      };
}
