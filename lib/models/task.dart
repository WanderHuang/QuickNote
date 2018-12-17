/// model of task.
/// you should define it based on your database model
class Task {
  int id;
  String content;
  String date;
  int level;
  int marked;
  bool isOpen = false;
  
  Task(this.content, this.level, this.marked, [this.id]) {
    this.date = this.date == null || this.date.length == 0 ? DateTime.now().toString() : this.date;
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      map['content'],
      map['level'],
      map['marked'],
      map['id']
    );
  }

  factory Task.fromTask(Task task) {
    return Task(
      task.content,
      task.level,
      task.marked,
      task.id
    );
  }

  @override
    String toString() {
      return 'Task[id=$id, content=$content, level=$level, marked=$marked, date=$date]';
    }
}