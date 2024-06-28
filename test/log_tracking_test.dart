import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:log_tracking/log.dart';

void main() {
  Log.w("test");
  int x = 0;
  test('adds one to input values', () {
    Test2().testCalistir();
    // final calculator = Calculator();
    // expect(calculator.addOne(2), 3);
    // expect(calculator.addOne(-7), -6);
    // expect(calculator.addOne(0), 1);
  });
}

class Test2 {
  void testCalistir() {
    Log.w("test");
    int x = 0;
  }
}
