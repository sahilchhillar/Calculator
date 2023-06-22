import 'package:flutter/material.dart';
import 'dart:core';
import 'package:logger/logger.dart';

import 'package:test_proj/Button/RoundButton.dart';
import 'Button/ButtonZero.dart';

void main() {
  runApp(const ButtonApp());
}

class ButtonApp extends StatelessWidget {
  const ButtonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const RoundButtonApp(),
    );
  }
}

class RoundButtonApp extends StatefulWidget {
  const RoundButtonApp({super.key});

  @override
  _RoundButtonApp createState() => _RoundButtonApp();
}

class _RoundButtonApp extends State<RoundButtonApp> {
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  String result = "0";
  String newResult = "";

  String allClear = "AC";
  int clearCount = 0;

  List operands = [];
  List operations = [];

  void addToString(String num, bool isOperator) {
    if (!isOperator) {
      if (num != "0" && result == "0") {
        newResult = num;
        setState(() {
          result = newResult;
          allClear = "C";
        });
      } else {
        newResult += num;
        setState(() {
          result = newResult;
          allClear = "C";
        });
      }
    } else {
      if (num == "=") {
        double number = double.parse(result);
        operands.add(number);
        logger.i(operands.toString());
        logger.i(operations.toString());

        String answer = performOperations();

        setState(() {
          result = answer;
          operands.clear();
          operations.clear();
        });
      } else if (num == '%') {
        double number = double.parse(result);
        setState(() {
          number /= 100;
          setState(() {
            result = number.toString();
          });
        });
      } else if (num == "+/-") {
        double number = double.parse(result) * -1;
        setState(() {
          result = number.toString();
        });
      } else {
        double number = double.parse(result);
        operands.add(number);
        operations.add(num);
        setState(() {
          result = "0";
          newResult = "";
        });
      }
    }
  }

  int precedence(List operationsList) {
    var priorityOrder = {'/': 4, '*': 3, '+': 2, '-': 1};

    var maxPriority = priorityOrder[operationsList[0]];
    int maxPriroityIndex = 0;

    for (int i = 0; i < operationsList.length; i++) {
      if (priorityOrder[operationsList[i]]! > maxPriority!) {
        maxPriority = priorityOrder[operationsList[i]];
        maxPriroityIndex = i;
      }
    }

    return maxPriroityIndex;
  }

  String performOperations() {
    while (operands.length > 1) {
      double result = 0;
      int index = precedence(operations);

      logger.i(index.toString());

      double num1 = operands[index] as double;
      logger.i(num1.toString());

      double num2 = operands[index + 1] as double;
      operands.removeRange(index, index + 2);
      logger.i(num2.toString());

      var operator = operations[index];
      operations.removeAt(index);
      logger.i(operator);

      switch (operator) {
        case '/':
          {
            if (num2 == 0) {
              return 'Invalid Operation!!!';
            } else {
              result = num1 / num2;
            }
            break;
          }

        case '+':
          {
            result = (num1 + num2);
            break;
          }

        case '-':
          {
            result = (num1 - num2);
            break;
          }

        case '*':
          {
            result = (num1 * num2);
            break;
          }
      }
      operands.insert(index, result);
    }

    return operands[0].toString();
  }

  void clearScreen() {
    clearCount++;
    if (clearCount == 1) {
      setState(() {
        allClear = "AC";
        newResult = "";
        result = "0";
      });
    } else {
      setState(() {
        result = "0";
        newResult = "";
        operands.clear();
        operations.clear();
        clearCount = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  result,
                  style: const TextStyle(color: Colors.white, fontSize: 70),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RoundButton(
                  text: allClear,
                  onPressed: () => clearScreen(),
                  clr: Colors.grey,
                  txtSize: 30,
                ),
                const SizedBox(
                  width: 5,
                ),
                RoundButton(
                  text: "+/-",
                  onPressed: () => addToString("+/-", true),
                  clr: Colors.grey,
                  txtSize: 30,
                ),
                const SizedBox(
                  width: 5,
                ),
                RoundButton(
                  text: "%",
                  onPressed: () => addToString("%", true),
                  clr: Colors.grey,
                  txtSize: 30,
                ),
                const SizedBox(
                  width: 5,
                ),
                RoundButton(
                  text: "/",
                  onPressed: () => addToString("/", true),
                  clr: Colors.orange,
                  txtSize: 30,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RoundButton(
                  text: "7",
                  onPressed: () => addToString('7', false),
                  clr: const Color.fromARGB(255, 48, 47, 47),
                  txtSize: 35,
                ),
                const SizedBox(
                  width: 5,
                ),
                RoundButton(
                  text: "8",
                  onPressed: () => addToString('8', false),
                  clr: const Color.fromARGB(255, 48, 47, 47),
                  txtSize: 35,
                ),
                const SizedBox(
                  width: 5,
                ),
                RoundButton(
                  text: "9",
                  onPressed: () => addToString('9', false),
                  clr: const Color.fromARGB(255, 48, 47, 47),
                  txtSize: 35,
                ),
                const SizedBox(
                  width: 5,
                ),
                RoundButton(
                  text: "x",
                  onPressed: () => addToString("*", true),
                  clr: Colors.orange,
                  txtSize: 35,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RoundButton(
                  text: "4",
                  onPressed: () => addToString('4', false),
                  clr: const Color.fromARGB(255, 48, 47, 47),
                  txtSize: 35,
                ),
                const SizedBox(
                  width: 5,
                ),
                RoundButton(
                  text: "5",
                  onPressed: () => addToString('5', false),
                  clr: const Color.fromARGB(255, 48, 47, 47),
                  txtSize: 35,
                ),
                const SizedBox(
                  width: 5,
                ),
                RoundButton(
                  text: "6",
                  onPressed: () => addToString('6', false),
                  clr: const Color.fromARGB(255, 48, 47, 47),
                  txtSize: 35,
                ),
                const SizedBox(
                  width: 5,
                ),
                RoundButton(
                  text: "-",
                  onPressed: () => addToString("-", true),
                  clr: Colors.orange,
                  txtSize: 35,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RoundButton(
                  text: "1",
                  onPressed: () => addToString('1', false),
                  clr: const Color.fromARGB(255, 48, 47, 47),
                  txtSize: 35,
                ),
                const SizedBox(
                  width: 5,
                ),
                RoundButton(
                  text: "2",
                  onPressed: () => addToString('2', false),
                  clr: const Color.fromARGB(255, 48, 47, 47),
                  txtSize: 35,
                ),
                const SizedBox(
                  width: 5,
                ),
                RoundButton(
                  text: "3",
                  onPressed: () => addToString('3', false),
                  clr: const Color.fromARGB(255, 48, 47, 47),
                  txtSize: 35,
                ),
                const SizedBox(
                  width: 5,
                ),
                RoundButton(
                  text: "+",
                  onPressed: () => addToString("+", true),
                  clr: Colors.orange,
                  txtSize: 35,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonZero(
                  onPressed: () => addToString('0', false),
                  text: "0",
                  txtSize: 40,
                  clr: const Color.fromARGB(255, 48, 47, 47),
                ),
                const SizedBox(
                  width: 5,
                ),
                RoundButton(
                  text: ".",
                  onPressed: () => addToString(".", false),
                  clr: const Color.fromARGB(255, 48, 47, 47),
                  txtSize: 35,
                ),
                const SizedBox(
                  width: 5,
                ),
                RoundButton(
                  text: "=",
                  onPressed: () => addToString('=', true),
                  clr: Colors.orange,
                  txtSize: 35,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
