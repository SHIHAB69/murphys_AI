import 'package:dio/dio.dart';
import '../models/message_model.dart';
import '../models/api_response_model.dart';

class ChatService {
  final Dio _dio = Dio();
  final String _apiUrl = 'https://api.groq.com/openai/v1/chat/completions';
  final String _apiKey = 'Bearer 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';

  Future<ApiResponse> sendMessage(List<Message> messages) async {
    try {
      _dio.options.headers['Authorization'] = _apiKey;
      _dio.options.headers['Content-Type'] = 'application/json';

      final response = await _dio.post(
        _apiUrl,
        data: {
          'messages': messages.map((message) => message.toJson()).toList(),
          'model': 'llama-3.3-70b-versatile',
          'temperature': 1,
          'max_completion_tokens': 1024,
          'top_p': 1,
          'stream': false,
          'stop': null
        },
      );

      if (response.statusCode == 200) {
        final apiResponse = ApiResponse.fromJson(response.data);
        return apiResponse;
      } else {
        throw Exception('Failed to send message: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }
}