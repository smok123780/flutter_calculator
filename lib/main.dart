import 'package:flutter/material.dart';
import 'package:flutter_calculator/keyboard.dart';
import 'package:flutter_calculator/keyboard_on_pressed.dart';
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
  KeyboardOnPressed keyboardOnPressed;

  @override
  void initState() {
    super.initState();
    equation = "0";
    result = "0";
    keyboardOnPressed = KeyboardOnPressed(onButtonPressed: (buttonText) {
      _equation(buttonText);
    });
  }


  void _equation(String val) {
    setState(() {
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
          if (equation.length == 1 && equation == "0") {
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
          Keyboard(keyboardOnPressed),
        ],
      ),
    );
  }
}
