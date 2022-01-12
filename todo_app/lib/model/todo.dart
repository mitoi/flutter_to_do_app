class Todo {
  String title;
  bool isComplet;
  String id;
  String description;
  String parentId;
  List children;
  String priority;
  Todo(
      {this.isComplet,
      this.title,
      this.id,
      this.description,
      this.parentId,
      this.children,
      this.priority});

  factory Todo.fromJson(Map<String, dynamic> map) {
    return Todo(
      id: map["_id"],
      isComplet: map["isComplet"],
      title: map["title"],
      description: map["description"],
      parentId: map["parentId"],
      children: map["children"],
      priority: map["priority"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "parentId": parentId,
      "priority": priority,
    };
  }
}
