class Todo {
  String title;
  bool isComplet;
  String id;
  String description;
  String parentId;
  List children;
  Todo(
      {this.isComplet,
      this.title,
      this.id,
      this.description,
      this.parentId,
      this.children});

  factory Todo.fromJson(Map<String, dynamic> map) {
    return Todo(
      id: map["_id"],
      isComplet: map["isComplet"],
      title: map["title"],
      description: map["description"],
      parentId: map["parentId"],
      children: map["children"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "parentId": parentId,
    };
  }
}
