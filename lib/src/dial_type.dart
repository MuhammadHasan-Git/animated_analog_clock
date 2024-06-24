/// An enumeration to define the types of dials that can be displayed on a clock.
enum DialType {
  /// Displays only dashes on the clock face.
  dashes,

  /// Displays only numbers on the clock face.
  numbers,

  /// Displays both dashes and numbers at 12, 3, 6, and 9 positions on the clock face.
  numberAndDashes,

  /// Displays only roman numerals on the clock face.
  romanNumerals,

  /// Displays no dials on the clock face.
  none,
}
