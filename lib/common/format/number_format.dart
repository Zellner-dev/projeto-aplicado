class NumberFormat {
  static String format(int number) {
    String stringNumber = number.toString();
    String ddd = stringNumber.substring(0, 2);
    String firstDigits = stringNumber.substring(2, 7);
    String secondDigits = stringNumber.substring(7, 11);
    
    return "($ddd) $firstDigits-$secondDigits";
  }
}