class Room {
  int? roomId;
  String? roomName;
  int? kind;
  int? participantsNum;
  bool? secretMode;
  Null? password;
  String? subject;
  int? userId;
  int? grade;

  Room(
      {this.roomId,
        this.roomName,
        this.kind,
        this.participantsNum,
        this.secretMode,
        this.password,
        this.subject,
        this.userId,
        this.grade});

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
        roomId: json['roomId'],
        roomName: json['roomName'],
        kind: json['kind'],
        participantsNum: json['participantsNum'],
        secretMode: json['secretMode'],
        password: json['password'],
        subject: json['subject'],
        userId: json['userId'],
        grade: json['grade']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roomId'] = this.roomId;
    data['roomName'] = this.roomName;
    data['kind'] = this.kind;
    data['participantsNum'] = this.participantsNum;
    data['secretMode'] = this.secretMode;
    data['password'] = this.password;
    data['subject'] = this.subject;
    data['userId'] = this.userId;
    data['grade'] = this.grade;
    return data;
  }
}