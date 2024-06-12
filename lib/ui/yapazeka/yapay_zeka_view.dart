import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:yz_app_jam/common/widgets/message.dart';
import 'package:yz_app_jam/ui/yapazeka/yapay_zeka_view_model.dart';

class YapayZekaView extends StatefulWidget {
  const YapayZekaView({super.key});

  @override
  State<YapayZekaView> createState() => _YapayZekaViewState();
}

class _YapayZekaViewState extends State<YapayZekaView> {
  TextEditingController _userInput = TextEditingController();
  static const apikey = '';
  final model = GenerativeModel(model: 'gemini-pro', apiKey: apikey);
  final List<Message> _messages = [];

  @override
  Future<void> sendMessage() async {
    final message = _userInput.text;
    setState(() {
      _messages
          .add(Message(isUser: true, message: message, date: DateTime.now()));
    });
    final content = [Content.text(message)];
    final response = await model.generateContent(content);
    setState(() {
      _messages.add(Message(
          isUser: false, message: response.text ?? "", date: DateTime.now()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<YapayZekaViewModel>.reactive(
        viewModelBuilder: () => YapayZekaViewModel(),
        onViewModelReady: (viewModel) => viewModel.init(),
        builder: (context, viewModel, child) => Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: const Text(
                  "DoğaDostum",
                  style: TextStyle(color: Color(0xff20AE67)),
                ),
              ),
              body: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(0.8), BlendMode.dstATop),
                        image: AssetImage('assets/white.png'),
                        fit: BoxFit.cover)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                        child: ListView.builder(
                            itemCount: _messages.length,
                            itemBuilder: (context, index) {
                              final message = _messages[index];
                              return Messages(
                                  isUser: message.isUser,
                                  message: message.message,
                                  date:
                                      DateFormat('HH:mm').format(message.date));
                            })),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 15,
                            child: TextFormField(
                              style: TextStyle(color: Colors.black),
                              controller: _userInput,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                label: Text('Mesajınızı Giriniz'),
                                labelStyle: TextStyle(color: Color(0xff20AE67)),
                                focusedBorder: OutlineInputBorder(
                                  // Odaklandığında çizginin rengini ayarlamak için
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                      color: Color(
                                          0xff20AE67)), // Dönen çizginin yeni rengi
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          IconButton(
                              padding: EdgeInsets.all(12),
                              iconSize: 30,
                              style: ButtonStyle(
                                  foregroundColor: MaterialStatePropertyAll(
                                      Color(0xff20AE67))),
                              onPressed: () {
                                sendMessage();
                                _userInput.clear();
                              },
                              icon: Icon(Icons.send)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}
