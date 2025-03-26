import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = '';
  String result = '';

  void onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        input = '';
        result = '';
      } else if (value == '=') {
        result = evaluateExpression(input);
      } else {
        input += value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Simple Calculator")),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.all(20),
            child: Text(input, style: const TextStyle(fontSize: 32)),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.all(20),
            child: Text(result, style: const TextStyle(fontSize: 32, 
              fontWeight: FontWeight.bold)),
          ),
          Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              ElevatedButton(onPressed: () => onButtonPressed('7'), child: Text('7')),
              ElevatedButton(onPressed: () => onButtonPressed('8'), child: Text('8')),
              ElevatedButton(onPressed: () => onButtonPressed('9'), child: Text('9')),
              ElevatedButton(onPressed: () => onButtonPressed('/'), child: Text('/')),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              ElevatedButton(onPressed: () => onButtonPressed('4'), child: Text('4')),
              ElevatedButton(onPressed: () => onButtonPressed('5'), child: Text('5')),
              ElevatedButton(onPressed: () => onButtonPressed('6'), child: Text('6')),
              ElevatedButton(onPressed: () => onButtonPressed('*'), child: Text('*')),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              ElevatedButton(onPressed: () => onButtonPressed('1'), child: Text('1')),
              ElevatedButton(onPressed: () => onButtonPressed('2'), child: Text('2')),
              ElevatedButton(onPressed: () => onButtonPressed('3'), child: Text('3')),
              ElevatedButton(onPressed: () => onButtonPressed('-'), child: Text('-')),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              ElevatedButton(onPressed: () => onButtonPressed('C'), child: Text('C')),
              ElevatedButton(onPressed: () => onButtonPressed('0'), child: Text('0')),
              ElevatedButton(onPressed: () => onButtonPressed('='), child: Text('=')),
              ElevatedButton(onPressed: () => onButtonPressed('+'), child: Text('+')),
            ]),
          ]),
        ],
      ),
    );
  }


String evaluateExpression(String expression) {
  expression = expression.replaceAll('×', '*').replaceAll('÷', '/');

  List<String> numbers = [];
  List<String> operators = [];
  String currentNumber = "";

  for (int i = 0; i < expression.length; i++) {
    String char = expression[i];

    if ("0123456789.".contains(char)) {
      currentNumber += char; 
    } else if ("+-*/".contains(char)) {
      if (currentNumber != "") {
        numbers.add(currentNumber);
        currentNumber = "";
      }
      operators.add(char);
    }
  }
  if (currentNumber != "") {
    numbers.add(currentNumber);
  }
  if (numbers.length < 2 || operators.isEmpty) {
    return "Error";
  }

  double num1 = double.parse(numbers[0]);
  double num2 = double.parse(numbers[1]);
  String op = operators[0];

  if (op == "+") return (num1 + num2).toString();
  if (op == "-") return (num1 - num2).toString();
  if (op == "*") return (num1 * num2).toString();
  if (op == "/" && num2 != 0) return (num1 / num2).toString();
  return "Error"; 
  }
}
