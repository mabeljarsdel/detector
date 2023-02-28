class AIDetector {
  String? label;
  num? score;

  AIDetector({this.label, this.score});

  AIDetector.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    score = json['score'];
  }
}
