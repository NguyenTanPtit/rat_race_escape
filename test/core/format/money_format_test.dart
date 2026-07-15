import 'package:flutter_test/flutter_test.dart';
import 'package:rat_race_escape/core/format/money_format.dart';

void main() {
  group('MoneyFormat', () {
    test('formats 0 correctly', () {
      expect(MoneyFormat.format(0), '0 ₫');
      expect(MoneyFormat.format(0.0), '0 ₫');
    });

    test('formats thousands correctly', () {
      expect(MoneyFormat.format(1000), '1k ₫');
      expect(MoneyFormat.format(1500), '1,5k ₫');
      expect(MoneyFormat.format(1250), '1,25k ₫');
    });

    test('formats millions correctly', () {
      expect(MoneyFormat.format(1000000), '1tr ₫');
      expect(MoneyFormat.format(12500000), '12,5tr ₫');
      expect(MoneyFormat.format(12550000), '12,55tr ₫');
    });

    test('formats billions correctly', () {
      expect(MoneyFormat.format(1000000000), '1 tỷ ₫');
      expect(MoneyFormat.format(1640000000), '1,64 tỷ ₫');
      expect(MoneyFormat.format(12555000000), '12,56 tỷ ₫'); // Half-up check
    });

    test('handles negative amounts', () {
      expect(MoneyFormat.format(-1000), '-1k ₫');
      expect(MoneyFormat.format(-12500000), '-12,5tr ₫');
      expect(MoneyFormat.format(-1640000000), '-1,64 tỷ ₫');
    });

    test('half-up rounding rules to 2 decimal places', () {
      // 12.555 million -> 12.56 million
      expect(MoneyFormat.format(12555000), '12,56tr ₫');
      // 12.554 million -> 12.55 million
      expect(MoneyFormat.format(12554000), '12,55tr ₫');
      
      // Negative half-up (away from zero)
      // -12.555 -> -12.56tr
      expect(MoneyFormat.format(-12555000), '-12,56tr ₫');
    });
    
    test('strips trailing zeros', () {
      expect(MoneyFormat.format(1200000), '1,2tr ₫');
      expect(MoneyFormat.format(12000000), '12tr ₫');
    });
  });
}
