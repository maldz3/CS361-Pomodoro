class Task {
  int id;
  String name;
  int durationWork;
  int durationBreak;
  int totalTime;
  int goalTime;
  int categoryID;

  Task(String name, int durationWork, int durationBreak, int totalTime,
      int goalTime) {
    this.name = name;
    this.durationWork = durationWork;
    this.durationBreak = durationBreak;
    this.totalTime = totalTime;
    this.goalTime = goalTime;
  }

  void addTime(int newTime) {
    totalTime += newTime;
  }
}
