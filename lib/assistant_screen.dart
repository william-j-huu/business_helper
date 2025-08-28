import 'package:buisnesshelper/base_screen/base.dart';
import 'package:buisnesshelper/constants.dart';
import 'package:buisnesshelper/home_page.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AssistantScreen extends StatefulWidget {
  const AssistantScreen({super.key});

  @override
  State<AssistantScreen> createState() => _AssistantScreenState();
}

class _AssistantScreenState extends State<AssistantScreen> {
  final _formKey = GlobalKey<FormState>();
  final _messageController = TextEditingController();
  late List<Map<String, String>> message = [];
  final ScrollController _scrollController = ScrollController();
  late OpenAI _openAI;

  @override
  void initState(){
    super.initState();
    _openAI = OpenAI.instance.build(
      token: dotenv.env['OPENAI_API_KEY'],
      baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 60)),
      enableLog: true,
    );
    message.add(
      {
        "message": "Hi William! How can I help your business today?",
        "sender": "AI"
      }
    );
  }

  Future<void> addMessage() async {
    if(_formKey.currentState?.validate() ?? false){
        setState(() {
          message.add(
            {
              "message": _messageController.text,
              "sender": "User"
            }
          );
        });

        await _aiAssistant();

        setState(() {
          _messageController.clear();
        });

        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        });
      }
  }

  Future<void> _aiAssistant() async {
    try {
      String prompt =
      '''
      Ensure that any response is related to business and anything off topic you respond with a message to bring back on topic: ${_messageController.text}
      ''';

      final request = ChatCompleteText(
          model: GptTurboChatModel(),
          messages: [
            {
              "role" : "user",
              "content" : [
                {
                  "type" : "text",
                  "text" : prompt
                }
              ]
            }
          ],
        maxToken: 500
      );

      final response = await _openAI.onChatCompletion(request: request);
      final content = response?.choices.first.message?.content ?? '';

      setState(() {
        message.add(
            {
              'message' : content,
              'sender' : 'AI'
            }
        );
      });


    }

    catch (e) {
      setState(() {
        message.add(
            {
              'message' : "Ran out of Tokens",
              'sender' : 'AI'
            }
        );
      });
      print(e);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Base(
        child: Column(
          children: [
            TitleCard(
              leading: Icon(Icons.smart_toy,color: Colors.orange, size: 50,),
              title: 'AI Business Assistant',
              body: 'Ask me anything about your business',
            ),
            Container(
              height: 500,
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 15),
              margin: EdgeInsets.only(top: 25, left: 15, right: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: CardColor
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // ChatBot(text: "Hi William! How can I help your business today?"),
                    // ChatPerson(text: "I need help with customer service"),

                    Expanded(
                      child: ListView.separated(
                        controller: _scrollController,
                        separatorBuilder: (context, index) => SizedBox(height: 12,),
                        itemCount: message.length,
                        itemBuilder: (BuildContext context, int index){
                          if(message[index]["sender"] == "AI"){
                            return ChatBot(text: message[index]["message"]!);
                          }
                          else{
                            return ChatPerson(text: message[index]["message"]!);
                          }
                      }
                      ),
                    ),

                    Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                              controller: _messageController,
                              decoration: const InputDecoration(labelText: "Type your message..."),
                              validator: (value) => (value == null || value.isEmpty) ? "Please enter your message" : null,
                            )
                        ),
                        GestureDetector(
                          onTap: addMessage,
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: primaryColor
                            ),
                            child: Icon(Icons.send, color: Colors.white,),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ChatBot extends StatelessWidget {
  final String text;
  const ChatBot({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16)
          ),
          child: Icon(Icons.smart_toy, color: Colors.orange,),
        ),
        SizedBox(width: 10,),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16)
            ),
            child: Text(text),
          ),
        )
      ],
    );
  }
}

class ChatPerson extends StatelessWidget {
  final String text;
  const ChatPerson({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16)
            ),
            child: Text(text),
          ),
        ),
        SizedBox(width: 10,),
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.4),
              borderRadius: BorderRadius.circular(16)
          ),
          child: Icon(Icons.person, color: Colors.blue,),
        )
      ],
    );
  }
}


