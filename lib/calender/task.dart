

class Task{
  int? id;
  String? title;
  String? note;
  int? isComplete;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  int? remind;
  String? repeat;

  Task({
    this.id,
    this.title,
    this.note,
    this.isComplete,
    this.date,
    this.startTime,
    this.endTime,
    this.color,
    this.remind,
    this.repeat,
});
  Task.fromjson(Map<String,dynamic> json){
    id = json['id'];
    title = json['title'];
    note = json['note'];
    isComplete = json['isComplete'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    color = json['color'];
    remind = json['remind'];
    repeat = json['repeat'];
  }
  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = new Map<String,dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['note'] = this.note;
    data['isComplete'] = this.isComplete;
    data['date'] = this.date;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['color'] = this.color;
    data['remind'] = this.remind;
    data['repeat'] = this.repeat;
    return data;


  }
}