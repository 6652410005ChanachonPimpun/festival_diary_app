class Autogenerated {
  int festId;
  String festName;
  String festDetail;
  String festSatate;
  int festCost;
  int userId;
  String festImage;

  Autogenerated(
      {this.festId,
      this.festName,
      this.festDetail,
      this.festSatate,
      this.festCost,
      this.userId,
      this.festImage});

  Autogenerated.fromJson(Map<String, dynamic> json) {
    festId = json['festId'];
    festName = json['festName'];
    festDetail = json['festDetail'];
    festSatate = json['festSatate'];
    festCost = json['festCost'];
    userId = json['userId'];
    festImage = json['festImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['festId'] = this.festId;
    data['festName'] = this.festName;
    data['festDetail'] = this.festDetail;
    data['festSatate'] = this.festSatate;
    data['festCost'] = this.festCost;
    data['userId'] = this.userId;
    data['festImage'] = this.festImage;
    return data;
  }
}
