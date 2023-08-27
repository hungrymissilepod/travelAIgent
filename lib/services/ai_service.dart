import 'package:dart_openai/dart_openai.dart';
import 'package:logger/logger.dart';
import 'package:travel_aigent/app/app.logger.dart';

class AiService {
  final Logger _logger = getLogger('AiService');

  Future<String> request(
    String prompt,
    int maxTokens, {
    List<OpenAIFunctionModel>? functions,
    FunctionCall functionCall = FunctionCall.none,
  }) async {
    try {
      OpenAIChatCompletionModel chatCompletion = await OpenAI.instance.chat.create(
        /// TODO: check if this is the most optimal model to use, based on price, speed, and quality of results
        model: "gpt-3.5-turbo-0613",
        messages: [
          OpenAIChatCompletionChoiceMessageModel(
            content: prompt,

            /// TODO: check this role arguement. What is the best?
            role: OpenAIChatMessageRole.user,
          ),
        ],
        n: 1,
        maxTokens: maxTokens,
      );
      _logger.i(
          'message: ${chatCompletion.choices.first.message.content} - completionTokens: ${chatCompletion.usage.completionTokens} - finishReason: ${chatCompletion.choices.first.finishReason}');
      return chatCompletion.choices.first.message.content;
    } catch (e) {
      throw Exception('OpenAI request failed: ${e.runtimeType}');
    }
  }
}
