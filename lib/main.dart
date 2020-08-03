import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_calculator/text_containers.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Calculator Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final snackBar = SnackBar(
    content: Text('Too long!!!'),
  );

  String equation;
  String result;
  String expression;
  bool resetEquation = false;

  @override
  void initState() {
    super.initState();
    equation = "0";
    result = "0";
  }

  void _equation(String val) {
    setState(() async {
      if (resetEquation) {
        equation = "0";
        resetEquation = false;
      }

      switch (val) {
        case "AC":
          equation = "0";
          result = "0";
          return;
        case "⌫":
          equation = equation.substring(0, equation.length - 1);
          if (equation == "") equation = "0";
          return;
        case "=":
          expression = equation;
          expression = expression.replaceAll("×", "*");
          expression = expression.replaceAll("÷", "/");
          try {
            Parser p = Parser();
            Expression exp = p.parse(expression);

            ContextModel cm = ContextModel();
            result = "${exp.evaluate(EvaluationType.REAL, cm)}";
            resetEquation = true;
          } catch (e) {
            result = "Error";
          }
          return;
        case "+":
        case "-":
        case "÷":
        case "×":
          if (equation.length == 1) {
            equation = result + val;
          } else
            equation += val;
          return;
        case "0":
          equation = val;
          return;
        default:
          if (equation == "0")
            equation = val;
          else
            equation += val;
          return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text(widget.title),
      ),
      backgroundColor: Colors.grey[850],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(flex: 3, child: TextContainers(equation, 3)),
          TextContainers(result, 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        _button("AC", Colors.grey[800]),
                        _button("÷", Colors.grey[800]),
                        _button("×", Colors.grey[800]),
                      ],
                    ),
                    TableRow(
                      children: [
                        _button("7", Colors.grey[600]),
                        _button("8", Colors.grey[600]),
                        _button("9", Colors.grey[600]),
                      ],
                    ),
                    TableRow(
                      children: [
                        _button("4", Colors.grey[600]),
                        _button("5", Colors.grey[600]),
                        _button("6", Colors.grey[600]),
                      ],
                    ),
                    TableRow(
                      children: [
                        _button("1", Colors.grey[600]),
                        _button("2", Colors.grey[600]),
                        _button("3", Colors.grey[600]),
                      ],
                    ),
                    TableRow(
                      children: [
                        _button("0", Colors.grey[600]),
                        _button("00", Colors.grey[600]),
                        _button(".", Colors.grey[600]),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        _button("⌫", Colors.orange),
                      ],
                    ),
                    TableRow(
                      children: [
                        _button("-", Colors.orange),
                      ],
                    ),
                    TableRow(
                      children: [
                        _button("+", Colors.orange),
                      ],
                    ),
                    TableRow(
                      children: [
                        _button("=", Colors.orange, buttonHeight: 2),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _button(String buttonText, Color color, {double buttonHeight = 1
//    , double buttonWidth = 1
      }) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: MaterialButton(
        height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
//        minWidth: MediaQuery.of(context).size.width * 0.1 * buttonWidth,
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        onPressed: () => _equation(buttonText),
      ),
    );
  }
}
