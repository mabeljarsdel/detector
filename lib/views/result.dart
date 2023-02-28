import 'package:ai_detector/constant/const.dart';
import 'package:flutter/material.dart';

class Result extends StatefulWidget {
  final String result;
  final num score;
  const Result({Key? key, required this.result, required this.score})
      : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> with TickerProviderStateMixin {
  num? realResult;
  num? fakeResult;
  late AnimationController _realController;
  late AnimationController _fakeController;

  @override
  void initState() {
    super.initState();
    if (widget.result == "Real") {
      realResult = widget.score;
      fakeResult = 1 - widget.score;
    } else {
      fakeResult = widget.score;
      realResult = 1 - widget.score;
    }
    _realController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _fakeController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _realController.forward();
    _fakeController.forward();
    _realController.addListener(() {
      setState(() {});
    });
    _fakeController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _fakeController.dispose();
    _realController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constant.mainColor,
        elevation: 0.5,
        centerTitle: true,
        title: const Text('AI Detector'),
      ),
      backgroundColor: Constant.mainColor,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const Text(
                      "Real",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Stack(
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: CircularProgressIndicator(
                            value: _realController.value >= realResult!
                                ? realResult!.toDouble()
                                : _realController.value,
                            color: const Color(0xffd9d9d9),
                            strokeWidth: 12,
                            backgroundColor:
                                const Color.fromARGB(255, 47, 86, 67),
                          ),
                        ),
                        Positioned(
                            bottom: 40,
                            left: 22,
                            child: Text(
                              "${(_realController.value >= realResult! ? realResult! * 100 : _realController.value * 100).toStringAsFixed(2)}%",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            )),
                      ],
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    const Text(
                      "AI",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Stack(
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: CircularProgressIndicator(
                            value: _fakeController.value >= fakeResult!
                                ? fakeResult!.toDouble()
                                : _fakeController.value,
                            color: const Color(0xffd9d9d9),
                            strokeWidth: 12,
                            backgroundColor:
                                const Color.fromARGB(255, 47, 86, 67),
                          ),
                        ),
                        Positioned(
                            bottom: 40,
                            left: 22,
                            child: Text(
                              "${(_fakeController.value >= fakeResult! ? fakeResult! * 100 : _fakeController.value * 100).toStringAsFixed(2)}%",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            )),
                      ],
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            if (fakeResult! >= realResult!)
              const Text(
                "AI high probability",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            if (fakeResult! <= realResult!)
              const Text(
                "Human Content",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            const SizedBox(
              height: 15,
            ),
            if (fakeResult! >= realResult!)
              const Text(
                "It appears that the text you have provided was generated using artificial intelligence. The level of detail and complexity suggests that it was not created by a human.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            if (fakeResult! <= realResult!)
              const Text(
                "Based on our analysis, the text you provided appears to be the product of human creativity and thought, rather than being generated by a machine. The presence of unique phrasing and personal style support this conclusion.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
