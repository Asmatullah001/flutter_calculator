import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String display = '0';

  double firstNumber = 0;
  String operator = '';

  // When a number button is pressed
  void numberPressed(String number) {
    setState(() {
      if (display == '0') {
        display = number;
      } else {
        display += number;
      }
    });
  }

  // When an operator is pressed
  void operatorPressed(String op) {
    setState(() {
      firstNumber = double.parse(display);
      operator = op;
      display = '0';
    });
  }

  // Calculate result
  void calculate() {
    double secondNumber = double.parse(display);
    double result = 0;

    setState(() {
      if (operator == '+') {
        result = firstNumber + secondNumber;
      } else if (operator == '-') {
        result = firstNumber - secondNumber;
      } else if (operator == '×') {
        result = firstNumber * secondNumber;
      } else if (operator == '÷') {
        if (secondNumber == 0) {
          display = 'Error';
          return;
        }
        result = firstNumber / secondNumber;
      }

      // Remove unnecessary .0
      if (result == result.toInt()) {
        display = result.toInt().toString();
      } else {
        display = result.toString();
      }

      operator = '';
    });
  }

  // Clear calculator
  void clear() {
    setState(() {
      display = '0';
      firstNumber = 0;
      operator = '';
    });
  }

  // Percentage
  void percentage() {
    setState(() {
      double value = double.parse(display);
      display = (value / 100).toString();
    });
  }

  // Decimal point
  void decimal() {
    setState(() {
      if (!display.contains('.')) {
        display += '.';
      }
    });
  }

  // Calculator button
  Widget calcButton(
      String text, {
        Color? color,
        Color? textColor,
        VoidCallback? onPressed,
      }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: SizedBox(
          height: 70,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: color ?? Colors.grey[850],
              foregroundColor: textColor ?? Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        centerTitle: true,
      ),

      body: Column(
        children: [

          // Display
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              alignment: Alignment.bottomRight,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  display,
                  style: const TextStyle(
                    fontSize: 55,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          // Buttons
          Expanded(
            flex: 5,
            child: Column(
              children: [

                // Row 1
                Row(
                  children: [
                    calcButton(
                      'AC',
                      color: Colors.red[700],
                      onPressed: clear,
                    ),
                    calcButton(
                      '%',
                      color: Colors.blueGrey[700],
                      onPressed: percentage,
                    ),
                    calcButton(
                      '÷',
                      color: Colors.orange[700],
                      onPressed: () => operatorPressed('÷'),
                    ),
                  ],
                ),

                // Row 2
                Row(
                  children: [
                    calcButton('7',
                        onPressed: () => numberPressed('7')),
                    calcButton('8',
                        onPressed: () => numberPressed('8')),
                    calcButton('9',
                        onPressed: () => numberPressed('9')),
                    calcButton(
                      '×',
                      color: Colors.orange[700],
                      onPressed: () => operatorPressed('×'),
                    ),
                  ],
                ),

                // Row 3
                Row(
                  children: [
                    calcButton('4',
                        onPressed: () => numberPressed('4')),
                    calcButton('5',
                        onPressed: () => numberPressed('5')),
                    calcButton('6',
                        onPressed: () => numberPressed('6')),
                    calcButton(
                      '-',
                      color: Colors.orange[700],
                      onPressed: () => operatorPressed('-'),
                    ),
                  ],
                ),

                // Row 4
                Row(
                  children: [
                    calcButton('1',
                        onPressed: () => numberPressed('1')),
                    calcButton('2',
                        onPressed: () => numberPressed('2')),
                    calcButton('3',
                        onPressed: () => numberPressed('3')),
                    calcButton(
                      '+',
                      color: Colors.orange[700],
                      onPressed: () => operatorPressed('+'),
                    ),
                  ],
                ),

                // Row 5
                Row(
                  children: [
                    calcButton(
                      '0',
                      onPressed: () => numberPressed('0'),
                    ),
                    calcButton(
                      '.',
                      onPressed: decimal,
                    ),
                    calcButton(
                      '=',
                      color: Colors.green[700],
                      onPressed: calculate,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}