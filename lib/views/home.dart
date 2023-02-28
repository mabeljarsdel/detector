import 'package:ai_detector/constant/const.dart';
import 'package:ai_detector/model/ai_res.dart';
import 'package:ai_detector/views/button.dart';
import 'package:ai_detector/views/result.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../API/detect_api.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  AIDetector? result;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    // DetectAd.loadSaveAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Detector'),
        centerTitle: true,
        backgroundColor: Constant.mainColor,
        elevation: 0.5,
      ),
      backgroundColor: Constant.mainColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                const Text(
                  "Our AI content detector app uses advanced machine learning algorithms to quickly and accurately identify and classify content, making it easy to filter out inappropriate or offensive material. Whether you're a parent looking to protect your children from harmful content online, or a business owner trying to keep your website or social media pages safe and friendly for all users, our app is the perfect solution. With our app, you can rest assured that your online content is being monitored and moderated by the latest and most advanced AI technology available.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                if (_controller.text.isNotEmpty)
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        _controller.clear();
                        setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(12)),
                        child: const Text("Clear"),
                      ),
                    ),
                  ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  maxLines: 12,
                  maxLength: 1280,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter a valid value";
                    }
                    return null;
                  },
                  // minLines: 1,
                  controller: _controller,

                  decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.only(left: 15, top: 50, right: 5),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(22)),
                          borderSide: BorderSide.none),
                      filled: true,
                      hintText: "Paste or write here...",
                      fillColor: Color(0xff849793)),
                ),
                const SizedBox(
                  height: 30,
                ),
                DefButton(
                  text: "Detect",
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      result =
                          await DetectAIAPI.detectAI(_controller.text.trim());
                      if (result != null) {
                        setState(() {
                          isLoading = false;
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.leftToRight,
                                  duration: const Duration(milliseconds: 200),
                                  child: Result(
                                    result: result!.label!,
                                    score: result!.score!,
                                  )));

                          // DetectAd.showSaveAd();
                        });
                      }
                    }
                  },
                  isLoading: isLoading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
