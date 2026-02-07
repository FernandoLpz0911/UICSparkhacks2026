import 'package:google_generative_ai/google_generative_ai.dart';
import '../env/env.dart';

/// 
/// class for gemini where we have the model and then can send prompts and get a response.
/// Literally just using the regular model
class Gemini {
  final _model = GenerativeModel(model: "gemini-2.5-flash-lite", apiKey: Env.apiKey);

  /// 
  /// Sends a message to the ai model with prompt as a string, and gets the
  /// response back and returns it from the ai model
  Future<String> sendMessage(String prompt) async {
    try {
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);

      return response.text ?? "Gemini failed to return a text.";
    } catch (e) {
      return "Error: $e";
    }
  }
}