class SeacrhHistory {
  String? userID;
  List<String>? list;
  SeacrhHistory({this.list, this.userID});
  factory SeacrhHistory.fromJson(Map<String, dynamic> json) {
    return SeacrhHistory(
        list: (json['list'] as List<dynamic>).map((e) => e.toString()).toList(),
        userID: json['userID']);
  }
  Map<String, dynamic> toJson() =>
      {'list': list!.map((e) => e.toString()).toList(), 'userID': userID};
}
