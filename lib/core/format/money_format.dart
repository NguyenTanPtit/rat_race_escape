
class MoneyFormat {
  MoneyFormat._();

  static String format(double amount) {
    if (amount == 0) return '0 ₫';
    
    final bool isNegative = amount < 0;
    final double absAmount = amount.abs();
    
    String formatted;
    
    if (absAmount >= 1000000000) {
      // Tỷ
      final value = absAmount / 1000000000;
      formatted = '${_formatValue(value)} tỷ';
    } else if (absAmount >= 1000000) {
      // Triệu
      final value = absAmount / 1000000;
      formatted = '${_formatValue(value)}tr';
    } else if (absAmount >= 1000) {
      // Nghìn
      final value = absAmount / 1000;
      formatted = '${_formatValue(value)}k';
    } else {
      formatted = _formatValue(absAmount);
    }
    
    return '${isNegative ? '-' : ''}$formatted ₫';
  }

  static String _formatValue(double value) {
    // Làm tròn half-up 2 chữ số sau dấu phẩy.
    // Tránh sai số IEEE 754 bằng cách cộng thêm epsilon nhỏ.
    final roundedValue = ((value + 1e-9) * 100).round() / 100;
    
    String str = roundedValue.toStringAsFixed(2);
    
    // Loại bỏ số 0 thừa ở cuối nếu là số thập phân
    if (str.contains('.')) {
      str = str.replaceAll(RegExp(r'0*$'), '');
      str = str.replaceAll(RegExp(r'\.$'), '');
    }
    
    // Thay dấu chấm (thập phân) thành dấu phẩy chuẩn Việt Nam
    return str.replaceAll('.', ',');
  }
}
