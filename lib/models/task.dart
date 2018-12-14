/// model of task.
/// you should define it based on your database model
class Task {
  int id;
  String title;
  String detail;
  String date;
  
  Task(this.title, this.detail, [this.id]) {
    this.date = this.date == null || this.date.length == 0 ? DateTime.now().toString() : this.date;
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      map['title'],
      map['detail'],
      map['id']
    );
  }

  @override
    String toString() {
      return 'Task[id=$id, title=$title, detail=$detail]';
    }
}