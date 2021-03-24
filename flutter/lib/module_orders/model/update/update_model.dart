class UpdateModel {
  int id;
  String title;
  String content;

  UpdateModel({
    this.id,
    this.title,
    this.content,
  });

  UpdateModel.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return;
    }
    id = json['id'];
    title = json['title'];
    content = json['content'];
  }
}
