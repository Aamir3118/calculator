import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({Key? key}) : super(key: key);

  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  bool _isPressed = false;
  static const textButtonColor =
      Colors.white70; //Color.fromARGB(189, 238, 238, 238);
  String equation = '';
  String result = '';
  String expression = '';
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;
  // String ans = '';
  dynamic newNum = 0.0;
  String finalNum = '';
  RegExp regExp = RegExp(r'([.]*0)(?!.*\d)');
  List historyData = [];
  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'AC') {
        equation = '';
        result = '';
        if (result != '') {
          historyData.add(equation);
        }
      } else if (equation.length >= 15) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(milliseconds: 100),
            content: Text('Limit reached! \nCan\'t write more than 15')));
      } else if (buttonText == 'DEL') {
        equation = equation.substring(0, equation.length - 1);
      } else if (buttonText == '=') {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        expression = equation;
        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll('\u00F7', '/');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          newNum = '${exp.evaluate(EvaluationType.REAL, cm)}';
          //print(ans);
          //newNum = ans;
          print(newNum);
          finalNum = newNum.toString().replaceAll(regExp, '');
          print(finalNum);
          result = finalNum;
          //equation = '';
          equation = finalNum;
          //historyData.add(expression);
          print(expression);
        } catch (e) {
          equation = 'Error';
        }
      } else {
        equation = equation + buttonText;
        equationFontSize = 38.0;
      }
    });
  }

  AppBar appBar = AppBar(
    centerTitle: true,
    title: const Text('Simple Calculator'),
  );

  @override
  Widget build(BuildContext context) {
    // print((result));

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // color: Colors.amber,
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.13,
              padding: EdgeInsets.only(top: 5, right: 10),
              alignment: Alignment.centerRight,
              child: Text(
                equation,
                style: TextStyle(fontSize: equationFontSize),
              ),
            ),
            Container(
              //color: Colors.red,
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.08,
              padding: EdgeInsets.only(top: 5, right: 10),
              alignment: Alignment.centerRight,
              child: Text(
                result,
                style: TextStyle(fontSize: resultFontSize, color: Colors.grey),
              ),
            ),

            //result, //  ans.toString(), // == null ? result : ans.toString(),
            //style: TextStyle(fontSize: resultFontSize),
            //),

            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.06,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 10),
                        child: IconButton(
                            onPressed: () {
                              print(historyData);
                              setState(() {
                                _isPressed = !_isPressed;
                              });
                            },
                            icon: Icon(Icons.history)),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 20),
                          height: (MediaQuery.of(context).size.height -
                                  appBar.preferredSize.height -
                                  MediaQuery.of(context).padding.top) *
                              0.73,
                          width: MediaQuery.of(context).size.width,
                          child: Table(children: [
                            TableRow(
                              children: [
                                _buildButtons(
                                    context,
                                    'AC',
                                    1,
                                    Color.fromARGB(255, 214, 233, 241),
                                    Color.fromARGB(255, 14, 65, 106)),
                                _buildButtons(
                                    context,
                                    'DEL',
                                    1,
                                    Color.fromARGB(255, 214, 233, 241),
                                    Color.fromARGB(255, 14, 65, 106)),
                                _buildButtons(
                                    context,
                                    '%',
                                    1,
                                    Color.fromARGB(255, 214, 233, 241),
                                    Color.fromARGB(255, 14, 65, 106)),
                                _buildButtons(
                                    context,
                                    '+',
                                    1,
                                    Color.fromARGB(255, 214, 233, 241),
                                    Color.fromARGB(255, 14, 65, 106)),
                              ],
                            ),
                            TableRow(
                              children: [
                                _buildButtons(context, '7', 1, textButtonColor,
                                    Colors.black),
                                _buildButtons(context, '8', 1, textButtonColor,
                                    Colors.black),
                                _buildButtons(context, '9', 1, textButtonColor,
                                    Colors.black),
                                _buildButtons(
                                    context,
                                    '-',
                                    1,
                                    Color.fromARGB(255, 214, 233, 241),
                                    Color.fromARGB(255, 14, 65, 106)),
                              ],
                            ),
                            TableRow(
                              children: [
                                _buildButtons(context, '4', 1, textButtonColor,
                                    Colors.black),
                                _buildButtons(context, '5', 1, textButtonColor,
                                    Colors.black),
                                _buildButtons(context, '6', 1, textButtonColor,
                                    Colors.black),
                                _buildButtons(
                                    context,
                                    'x',
                                    1,
                                    Color.fromARGB(255, 214, 233, 241),
                                    Color.fromARGB(255, 14, 65, 106)),
                              ],
                            ),
                            TableRow(
                              children: [
                                _buildButtons(context, '1', 1, textButtonColor,
                                    Colors.black),
                                _buildButtons(context, '2', 1, textButtonColor,
                                    Colors.black),
                                _buildButtons(context, '3', 1, textButtonColor,
                                    Colors.black),
                                _buildButtons(
                                    context,
                                    '\u00F7',
                                    1,
                                    Color.fromARGB(255, 214, 233, 241),
                                    Color.fromARGB(255, 14, 65, 106)),
                              ],
                            ),
                            TableRow(
                              children: [
                                _buildButtons(context, '0', 1, textButtonColor,
                                    Colors.black),
                                _buildButtons(context, '00', 1, textButtonColor,
                                    Colors.black),
                                _buildButtons(context, '.', 1, textButtonColor,
                                    Colors.black),
                                _buildButtons(
                                    context,
                                    '=',
                                    1,
                                    Color.fromARGB(255, 214, 233, 241),
                                    Color.fromARGB(255, 14, 65, 106)),
                              ],
                            ),
                          ]),
                        ),
                        _isPressed
                            ? Positioned(
                                top: 15,
                                left: 0,
                                right: 98,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                  ),
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                    itemCount: historyData.length,
                                    itemBuilder: (context, index) => ListTile(
                                      title: Text(expression),
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _calculatorHistory() {
    return Positioned(
      right: 20,
      child: Container(
        color: Colors.amber,
        height: 150,
        width: 150,
      ),
    );
  }

  Padding _buildButtons(BuildContext context, String buttonText,
      double buttonHeight, Color buttonColor, Color textColor) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
            color: buttonColor, borderRadius: BorderRadius.circular(25.0)),
        height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
        child: TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  side: BorderSide(
                      color: Colors.black, width: 2, style: BorderStyle.none)),
            ),
          ),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: textColor),
          ),
        ),
      ),
    );
  }
}
