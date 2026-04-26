class FaqModel {
  final bool success;
  final List<FaqData> data;

  FaqModel({
    required this.success,
    required this.data,
  });

  factory FaqModel.fromJson(Map<String, dynamic> json) {
    return FaqModel(
      success: json['success'],
      data: List<FaqData>.from(
        json['data'].map((x) => FaqData.fromJson(x)),
      ),
    );
  }
}

class FaqData {
  final String id;
  final String question;
  final String answer;

  FaqData({
    required this.id,
    required this.question,
    required this.answer,
  });

  factory FaqData.fromJson(Map<String, dynamic> json) {
    return FaqData(
      id: json['_id'],
      question: json['question'],
      answer: json['answer'],
    );
  }
}