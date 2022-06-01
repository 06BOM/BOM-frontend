class Character {
  int? characterId;
  String? characterName;
  int? star;
  String? imageUrl;
  String? silhouetteUrl;
  String? introduction;
  String? explanation;
  int? brain;
  int? speed;
  int? power;
  int? teq;
  int? strength;
  int? height;
  int? weight;
  String? mbti;

  Character({this.characterId,
    this.characterName,
    this.star,
    this.imageUrl,
    this.silhouetteUrl,
    this.introduction,
    this.explanation,
    this.brain,
    this.speed,
    this.power,
    this.teq,
    this.strength,
    this.height,
    this.weight,
    this.mbti});


  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
        characterId: json['characterId'],
        characterName: json['characterName'],
        star: json['star'],
        imageUrl: json['imageUrl'],
        silhouetteUrl: json['silhouetteUrl'],
        introduction: json['introduction'],
        explanation: json['explanation'],
        brain: json['brain'],
        speed: json['speed'],
        power: json['power'],
        teq: json['teq'],
        strength: json['strength'],
        height: json['height'],
    weight: json['weight'],
    mbti: json['mbti']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['characterId'] = characterId;
    data['characterName'] = characterName;
    data['star'] = star;
    data['imageUrl'] = imageUrl;
    data['silhouetteUrl'] = silhouetteUrl;
    data['introduction'] = introduction;
    data['explanation'] = explanation;
    data['brain'] = brain;
    data['speed'] = speed;
    data['power'] = power;
    data['teq'] = teq;
    data['strength'] = strength;
    data['height'] = height;
    data['weight'] = weight;
    data['mbti'] = mbti;
    return data;
  }
}
