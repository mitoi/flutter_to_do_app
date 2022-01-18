// @dart=2.9
class Todo {
  String title;
  bool isComplet;
  String id;
  String description;
  String parentId;
  List children;
  String priority;
  String userId;
  Todo({
    this.isComplet,
    this.title,
    this.id,
    this.description,
    this.parentId,
    this.children,
    this.priority,
    this.userId,
  });

  factory Todo.fromJson(Map<String, dynamic> map) {
    return Todo(
      id: map["_id"],
      isComplet: map["isComplet"],
      title: map["title"],
      description: map["description"],
      parentId: map["parentId"],
      children: map["children"],
      priority: map["priority"],
      userId: map["userId"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "parentId": parentId,
      "priority": priority,
      "userId": userId,
    };
  }
}
