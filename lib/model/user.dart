class User {
  int? userId;
  String? emailId;
  String? userName;
  String? password;
  String? nickname;
  String? birth;
  String? phoneNum;
  int? grade;
  int? star;
  int? timeItem;
  int? passItem;
  String? introduction;
  String? platform;
  String? platformId;
  bool? lock;
  String? lockFreeDate; // DateFormate
  int? userType;
  int? characterId;

  User(
      {this.userId,
      this.emailId,
      this.userName,
      this.password,
      this.nickname,
      this.birth,
      this.phoneNum,
      this.grade,
      this.star,
      this.timeItem,
      this.passItem,
      this.introduction,
      this.platform,
      this.platformId,
      this.lock,
      this.lockFreeDate,
      this.userType,
      this.characterId});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      emailId: json['emailId'],
      userName: json['userName'],
      password: json['password'],
      nickname: json['nickname'],
      birth: json['birth'],
      phoneNum: json['phoneNum'],
      grade: json['grade'],
      star: json['star'],
      timeItem: json['timeItem'],
      passItem: json['passItem'],
      introduction: json['introduction'],
      platform: json['platform'],
      platformId: json['platformId'],
      lock: json['lock'],
      lockFreeDate: json['lockFreeDate'],
      userType: json['userType'],
      characterId: json['characterId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['emailId'] = emailId;
    data['userName'] = userName;
    data['password'] = password;
    data['nickname'] = nickname;
    data['birth'] = birth;
    data['phoneNum'] = phoneNum;
    data['grade'] = grade;
    data['star'] = star;
    data['timeItem'] = timeItem;
    data['passItem'] = passItem;
    data['introduction'] = introduction;
    data['platform'] = platform;
    data['platformId'] = platformId;
    data['lock'] = lock;
    data['lockFreeDate'] = lockFreeDate;
    data['userType'] = userType;
    data['characterId'] = characterId;
    return data;
  }
}
