class SeacrhHistory {
  int? id;
  String? userID;
  String? searchKey;
  SeacrhHistory({this.searchKey, this.userID, this.id});
  factory SeacrhHistory.fromJson(Map<String, dynamic> json) {
    return SeacrhHistory(
        searchKey: (json['searchKey']), userID: json['userID'], id: json['id']);
  }
  Map<String, dynamic> toJson() =>
      {'searchKey': searchKey, 'userID': userID, 'id': id};
}
