class Message {
  final String content;
  final String role;
  final DateTime timestamp;

  Message({
    required this.content,
    required this.role,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'content': content,
    };
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      role: json['role'],
      content: json['content'],
      timestamp: DateTime.now(),
    );
  }
}