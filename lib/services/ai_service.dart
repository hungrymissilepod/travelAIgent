import 'package:dart_openai/dart_openai.dart';
import 'package:logger/logger.dart';
import 'package:travel_aigent/app/app.logger.dart';

class AiService {
  final Logger _logger = getLogger('StartupViewModel');

  /// Get list of available models
  // List<OpenAIModelModel> models = await OpenAI.instance.model.list();
  // for (OpenAIModelModel model in models) {
  //   print(model.id);
  // }

  /// Test prompt to get holiday plan
  // String prompt = '''
  //   Write a travel itinerary for someone meeting these criteria:

  //   Likes city breaks.
  //   Wants to fly from London Heathrow airport.
  //   Does not want to fly longer than 6 hours.
  //   Likes history and art.
  //   They will only travel to one city.

  //   Please also add images of each attraction that you mention.

  //   Please write your response in json minified.
  // ''';

  /// Use GPT3.5 to get travel plan
  // OpenAIChatCompletionModel chatCompletion = await OpenAI.instance.chat.create(
  //   model: "gpt-3.5-turbo",
  //   messages: [
  //     OpenAIChatCompletionChoiceMessageModel(
  //       content: prompt,
  //       role: OpenAIChatMessageRole.user,
  //     ),
  //   ],
  //   n: 1,
  //   maxTokens: 100,
  // );

  // print('useage tokens: ${chatCompletion.usage.completionTokens}');
  // print(' ${chatCompletion.choices.first.message}');
  // print('${chatCompletion.choices.first.finishReason}');

  /// Prompt to get only a name of a city and country
  // String firstPrompt = '''
  //   Tell me one city in asia that I can fly to from London Heathrow within 20 hours. Respond as a string in this format:'city, country'.
  //   ''';

  // String location = await request(firstPrompt, 10);

  /// ask for another city. can be used in future to generate a new plan
  // await request('''Try again but tell me a different city. Respond as a string in this format:'city, country' ''');

  // await request(
  //     '''Give me a list of 3 attractions and a 1 sentence description and a 1 word category and an image for each one in ${location}. Respond as a minified json with keys 'attractions', 'category', 'description', 'image' ''',
  //     1000,
  //     functions: [
  //       OpenAIFunctionModel(
  //         name: 'get_image_url',
  //         parametersSchema: {
  //           'type': 'object',
  //           'properties': {
  //             'url': {
  //               'type': 'string',
  //               'description': 'url of real image',
  //             }
  //           }
  //         },
  //       ),
  //     ],
  //     functionCall: FunctionCall.auto);

  Future<String> request(String prompt, int maxTokens,
      {List<OpenAIFunctionModel>? functions,
      FunctionCall functionCall = FunctionCall.none}) async {
    OpenAIChatCompletionModel chatCompletion =
        await OpenAI.instance.chat.create(
      /// TODO: check if this is the most optimal model to use, based on price, speed, and quality of results
      model: "gpt-3.5-turbo-0613",
      messages: [
        OpenAIChatCompletionChoiceMessageModel(
          content: prompt,
          role: OpenAIChatMessageRole.user,
        ),
      ],
      n: 1,
      maxTokens: maxTokens,
    );
    _logger.i(
        'message: ${chatCompletion.choices.first.message.content} - completionTokens: ${chatCompletion.usage.completionTokens} - finishReason: ${chatCompletion.choices.first.finishReason}');
    return chatCompletion.choices.first.message.content;
  }
}
