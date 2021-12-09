import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

enum ShorteningPolicy { none, thousand, mill, bill, trill, auto }

enum ThousandSeparator { comma, period, none, sp, sc }

final RegExp _repeatingDots = RegExp(r'\.{2,}');
final RegExp _repeatingCommas = RegExp(r',{2,}');
final RegExp _repeatingSpaces = RegExp(r'\s{2,}');

class MoneySymbols {
  static const String dollar = '\$';
  static const String euro = '€';
  static const String pound = '£';
  static const String yen = '￥';
  static const String eth = 'Ξ';
  static const String btc = 'Ƀ';
  static const String swiss = '₣';
  static const String ruble = '₽';
  static const String ngn = '₦';
}

class MoneyInputFormatter extends TextInputFormatter {
  static final RegExp _wrongLeadingZeroMatcher = RegExp(r'^0\d{1}');

  final ThousandSeparator thousandSeparator;
  final int mantissaLength;
  final String leadingSymbol;
  final String trailingSymbol;
  final bool useSymbolPadding;
  final int? maxTextLength;
  final ValueChanged<double>? onValueChange;
  MoneyInputFormatter({
    this.thousandSeparator = ThousandSeparator.comma,
    this.mantissaLength = 2,
    this.leadingSymbol = '',
    this.trailingSymbol = '',
    this.useSymbolPadding = false,
    this.onValueChange,
    this.maxTextLength,
  });

  //_removeWrongLeadingZero
  String? _removeLeadingZero(String value, TextEditingValue textValue) {
    var tempValue = value;
    final leadingTotalLength = _leadingLength + _paddingLength;
    if (leadingTotalLength != 0 && tempValue.length >= leadingTotalLength) {
      final curLeading = tempValue.substring(0, leadingTotalLength);
      tempValue = tempValue.substring(leadingTotalLength);
      final match = _wrongLeadingZeroMatcher.matchAsPrefix(tempValue);
      if (match != null) {
        tempValue = tempValue.substring(1, tempValue.length);
        return '$curLeading$tempValue';
      }
    }

    return null;
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (_leadingLength > 0 && _trailingLength > 0) {
      throw 'You cannot use trailing an leading symbols at the same time';
    }
    var newText = newValue.text;
    var oldText = oldValue.text;
    if (oldValue == newValue) {
      return newValue;
    }
    if (newText.contains(',.') || newText.contains('..')) {
      return oldValue.copyWith(
        selection: newValue.selection,
      );
    }

    newText = _stripRepeatingSeparators(newText);
    oldText = _stripRepeatingSeparators(oldText);
    int numZeroesRemovedAtStringStart = 0;
    var newRemoveZeroResult = _removeLeadingZero(
      newText,
      newValue,
    );
    if (newRemoveZeroResult != null) {
      newText = newRemoveZeroResult;
      numZeroesRemovedAtStringStart = 1;
    }

    var usesCommaForMantissa = _usesCommasForMantissa();
    if (usesCommaForMantissa) {
      newText = _swapCommasAndPeriods(newText);
      oldText = _swapCommasAndPeriods(oldText);
      oldValue = oldValue.copyWith(text: oldText);
      newValue = newValue.copyWith(text: newText);
    }
    var usesSpacesAsThousandSeparator = _usesSpacesForThousands();
    if (usesSpacesAsThousandSeparator) {
      newText = _replaceSpacesByCommas(
        newText,
        leadingLength: _leadingLength,
        trailingLength: _trailingLength,
      );
      oldText = _replaceSpacesByCommas(
        oldText,
        leadingLength: _leadingLength,
        trailingLength: _trailingLength,
      );
      oldValue = oldValue.copyWith(text: oldText);
      newValue = newValue.copyWith(text: newText);
    }

    var isErasing = newValue.text.length < oldValue.text.length;

    TextSelection selection;
    var mantissaSymbol = '.';
    var leadingZeroWithDot = '${leadingSymbol}0$mantissaSymbol';
    var leadingZeroWithoutDot = '$leadingSymbol$mantissaSymbol';

    if (isErasing) {
      if (newValue.selection.end < _leadingLength) {
        selection = TextSelection.collapsed(
          offset: _leadingLength,
        );
        return TextEditingValue(
          selection: selection,
          text: _prepareDotsAndCommas(oldText),
        );
      }
    } else {
      if (maxTextLength != null) {
        if (newValue.text.length > maxTextLength!) {
          var lastSeparatorIndex = oldText.lastIndexOf('.');
          var isAfterMantissa = newValue.selection.end > lastSeparatorIndex + 1;

          if (!newValue.text.contains('..')) {
            if (!isAfterMantissa) {
              return oldValue;
            }
          }
        }
      }

      if (oldValue.text.isEmpty && newValue.text.length != 1) {
        if (_leadingLength < 1) {
          return newValue;
        }
      }
    }

    _processCallback(newText);

    if (isErasing) {
      selection = newValue.selection;
      var lastSeparatorIndex = oldText.lastIndexOf('.');
      if (selection.end == lastSeparatorIndex) {
        selection = TextSelection.collapsed(
          offset: oldValue.selection.extentOffset - 1,
        );
        var preparedText = _prepareDotsAndCommas(oldText);
        return TextEditingValue(
          selection: selection,
          text: preparedText,
        );
      }

      var isAfterSeparator = lastSeparatorIndex < selection.extentOffset;
      if (isAfterSeparator && lastSeparatorIndex > -1) {
        return newValue.copyWith(
          text: _prepareDotsAndCommas(newValue.text),
        );
      }
      var numSeparatorsBefore = _countSymbolsInString(
        newText,
        ',',
      );
      newText = toCurrencyString(
        newText,
        mantissaLength: mantissaLength,
        leadingSymbol: leadingSymbol,
        trailingSymbol: trailingSymbol,
        thousandSeparator: ThousandSeparator.comma,
        useSymbolPadding: useSymbolPadding,
      );
      var numSeparatorsAfter = _countSymbolsInString(
        newText,
        ',',
      );
      if (thousandSeparator == ThousandSeparator.none) {
        numSeparatorsAfter = 0;
      }

      var selectionOffset = numSeparatorsAfter - numSeparatorsBefore;
      int offset = selection.extentOffset + selectionOffset;
      if (_leadingLength > 0) {
        if (offset < _leadingLength) {
          offset += _leadingLength;
        }
      }
      selection = TextSelection.collapsed(
        offset: offset,
      );

      if (_leadingLength > 0) {
        if (newText.contains(leadingZeroWithDot)) {
          newText = newText.replaceAll(
            leadingZeroWithDot,
            leadingZeroWithoutDot,
          );
          offset -= 1;
          if (offset < _leadingLength) {
            offset = _leadingLength;
          }
          selection = TextSelection.collapsed(
            offset: offset,
          );
        }
      }

      var preparedText = _prepareDotsAndCommas(newText);
      return TextEditingValue(
        selection: selection,
        text: preparedText,
      );
    }
    bool oldStartsWithLeading = leadingSymbol.isNotEmpty &&
        oldValue.text.startsWith(
          leadingSymbol,
        );
    var oldSelectionEnd = oldValue.selection.end;
    TextEditingValue value = oldSelectionEnd > -1 ? oldValue : newValue;
    String oldSubStringBeforeSelection = oldSelectionEnd > -1
        ? value.text.substring(0, value.selection.end)
        : '';
    int numThousandSeparatorsInOldSub = _countSymbolsInString(
      oldSubStringBeforeSelection,
      ',',
    );
    var startsWithOrphanPeriod = numericStringStartsWithOrphanPeriod(newText);
    var formattedValue = toCurrencyString(
      newText,
      leadingSymbol: leadingSymbol,
      mantissaLength: mantissaLength,
      thousandSeparator: ThousandSeparator.comma,
      trailingSymbol: trailingSymbol,
      useSymbolPadding: useSymbolPadding,
    );

    String newSubStringBeforeSelection = oldSelectionEnd > -1
        ? formattedValue.substring(
            0,
            value.selection.end,
          )
        : '';
    int numThousandSeparatorsInNewSub = _countSymbolsInString(
      newSubStringBeforeSelection,
      ',',
    );

    int numAddedSeparators =
        numThousandSeparatorsInNewSub - numThousandSeparatorsInOldSub;

    if (thousandSeparator == ThousandSeparator.none) {
      /// FIXME: dirty hack. I will probably find a better solution.
      numThousandSeparatorsInNewSub = 0;
      numAddedSeparators = 0;
    }

    bool newStartsWithLeading = leadingSymbol.isNotEmpty &&
        formattedValue.startsWith(
          leadingSymbol,
        );
    bool addedLeading = !oldStartsWithLeading && newStartsWithLeading;

    var selectionIndex = value.selection.end + numAddedSeparators;

    int wholePartSubStart = 0;
    if (addedLeading) {
      wholePartSubStart = _leadingLength;
      selectionIndex += _leadingLength;
    }
    if (startsWithOrphanPeriod) {
      selectionIndex += 1;
    }

    selectionIndex -= numZeroesRemovedAtStringStart;

    var mantissaIndex = formattedValue.indexOf(mantissaSymbol);
    if (mantissaIndex > wholePartSubStart) {
      var wholePartSubstring = formattedValue.substring(
        wholePartSubStart,
        mantissaIndex,
      );
      if (selectionIndex < mantissaIndex) {
        if (wholePartSubstring == '0' ||
            wholePartSubstring == '${leadingSymbol}0') {
          /// if the whole part contains 0 only, then we need
          /// to bring the selection after the
          /// fractional part right away
          selectionIndex += 1;
        }
      }
    }
    selectionIndex += 1;
    if (oldValue.text.isEmpty && useSymbolPadding) {
      /// to skip leading space right after a currency symbol
      selectionIndex += 1;
    }

    var preparedText = _prepareDotsAndCommas(
      formattedValue,
    );
    var selectionEnd = min(
      selectionIndex,
      preparedText.length,
    );

    return TextEditingValue(
      selection: TextSelection.collapsed(
        offset: selectionEnd,
      ),
      text: preparedText,
    );
  }

  bool isZero(String text) {
    var numericString = toNumericString(
      text,
      allowPeriod: true,
    );
    var value = double.tryParse(numericString) ?? 0.0;
    return value == 0.0;
  }

  int get _paddingLength {
    return useSymbolPadding ? 1 : 0;
  }

  int get _leadingLength => leadingSymbol.length;
  int get _trailingLength => trailingSymbol.length;

  String _stripRepeatingSeparators(String input) {
    return input
        .replaceAll(_repeatingDots, '.')
        .replaceAll(_repeatingCommas, ',')
        .replaceAll(_repeatingSpaces, ' ');
  }

  bool _usesCommasForMantissa() {
    var value = (thousandSeparator == ThousandSeparator.period ||
        thousandSeparator == ThousandSeparator.sc);
    return value;
  }

  bool _usesSpacesForThousands() {
    var value = (thousandSeparator == ThousandSeparator.sc ||
        thousandSeparator == ThousandSeparator.sp);
    return value;
  }

  String _prepareDotsAndCommas(String value) {
    var useCommasForMantissa = _usesCommasForMantissa();
    if (useCommasForMantissa) {
      value = _swapCommasAndPeriods(value);
    }
    if (thousandSeparator == ThousandSeparator.sc) {
      value = value.replaceAll('.', ' ');
    } else if (thousandSeparator == ThousandSeparator.sp) {
      value = value.replaceAll(',', ' ');
    } else if (thousandSeparator == ThousandSeparator.none) {
      value = value.replaceAll(',', '');
    }
    return value;
  }

  void _processCallback(String value) {
    if (onValueChange != null) {
      var numericValue = toNumericString(value, allowPeriod: true);
      var val = double.tryParse(numericValue) ?? 0.0;
      onValueChange!(val);
    }
  }
}

int _countSymbolsInString(String string, String symbolToCount) {
  var counter = 0;
  for (var i = 0; i < string.length; i++) {
    if (string[i] == symbolToCount) counter++;
  }
  return counter;
}

String toCurrencyString(
  String value, {
  int mantissaLength = 2,
  ThousandSeparator thousandSeparator = ThousandSeparator.comma,
  ShorteningPolicy shorteningPolicy = ShorteningPolicy.none,
  String leadingSymbol = '',
  String trailingSymbol = '',
  bool useSymbolPadding = false,
}) {
  var swapCommasAndPrePeriods = false;
  if (mantissaLength <= 0) {
    mantissaLength = 0;
  }

  String? tSeparator;
  switch (thousandSeparator) {
    case ThousandSeparator.comma:
      tSeparator = ',';
      break;
    case ThousandSeparator.period:
      tSeparator = ',';
      swapCommasAndPrePeriods = true;
      break;
    case ThousandSeparator.none:
      tSeparator = '';
      break;
    case ThousandSeparator.sp:
      tSeparator = ' ';
      break;
    case ThousandSeparator.sc:
      tSeparator = ' ';
      swapCommasAndPrePeriods = true;
      break;
  }
  // print(thousandSeparator);
  value = value.replaceAll(_repeatingDots, '.');
  if (mantissaLength == 0) {
    var substringEnd = value.lastIndexOf('.');
    if (substringEnd > 0) {
      value = value.substring(0, substringEnd);
    }
  }
  value = toNumericString(value, allowPeriod: mantissaLength > 0);
  var isNegative = value.contains('-');

  /// parsing here is done to avoid any unnecessary symbols inside
  /// a number
  var parsed = (double.tryParse(value) ?? 0.0);
  if (parsed == 0.0) {
    if (isNegative) {
      var containsMinus = parsed.toString().contains('-');
      if (!containsMinus) {
        value =
            '-${parsed.toStringAsFixed(mantissaLength).replaceFirst('0.', '.')}';
      } else {
        value = parsed.toStringAsFixed(mantissaLength);
      }
    } else {
      value = parsed.toStringAsFixed(mantissaLength);
    }
  }
  var noShortening = shorteningPolicy == ShorteningPolicy.none;

  var minShorteningLength = 0;
  switch (shorteningPolicy) {
    case ShorteningPolicy.none:
      break;
    case ShorteningPolicy.thousand:
      minShorteningLength = 4;
      value = '${_getRoundedValue(value, 1000)}K';
      break;
    case ShorteningPolicy.mill:
      minShorteningLength = 7;
      value = '${_getRoundedValue(value, 1000000)}M';
      break;
    case ShorteningPolicy.bill:
      minShorteningLength = 10;
      value = '${_getRoundedValue(value, 1000000000)}B';
      break;
    case ShorteningPolicy.trill:
      minShorteningLength = 13;
      value = '${_getRoundedValue(value, 1000000000000)}T';
      break;
    case ShorteningPolicy.auto:
      // find out what shortening to use base on the length of the string
      var intValStr = (int.tryParse(value) ?? 0).toString();
      if (intValStr.length < 7) {
        minShorteningLength = 4;
        value = '${_getRoundedValue(value, 1000)}K';
      } else if (intValStr.length < 10) {
        minShorteningLength = 7;
        value = '${_getRoundedValue(value, 1000000)}M';
      } else if (intValStr.length < 13) {
        minShorteningLength = 10;
        value = '${_getRoundedValue(value, 1000000000)}B';
      } else {
        minShorteningLength = 13;
        value = '${_getRoundedValue(value, 1000000000000)}T';
      }
      break;
  }
  var list = <String?>[];
  var mantissa = '';
  var split = value.split('');
  var mantissaList = <String>[];
  var mantissaSeparatorIndex = value.indexOf('.');
  if (mantissaSeparatorIndex > -1) {
    var start = mantissaSeparatorIndex + 1;
    var end = start + mantissaLength;
    for (var i = start; i < end; i++) {
      if (i < split.length) {
        mantissaList.add(split[i]);
      } else {
        mantissaList.add('0');
      }
    }
  }

  mantissa = noShortening
      ? _postProcessMantissa(mantissaList.join(''), mantissaLength)
      : '';
  var maxIndex = split.length - 1;
  if (mantissaSeparatorIndex > 0 && noShortening) {
    maxIndex = mantissaSeparatorIndex - 1;
  }
  var digitCounter = 0;
  if (maxIndex > -1) {
    for (var i = maxIndex; i >= 0; i--) {
      digitCounter++;
      list.add(split[i]);
      if (noShortening) {
        // в случае с отрицательным числом, запятая перед минусом не нужна
        if (digitCounter % 3 == 0 && i > (isNegative ? 1 : 0)) {
          list.add(tSeparator);
        }
      } else {
        if (value.length >= minShorteningLength) {
          if (!isDigit(split[i])) digitCounter = 1;
          if (digitCounter % 3 == 1 &&
              digitCounter > 1 &&
              i > (isNegative ? 1 : 0)) {
            list.add(tSeparator);
          }
        }
      }
    }
  } else {
    list.add('0');
  }

  if (leadingSymbol.isNotEmpty) {
    if (useSymbolPadding) {
      list.add('$leadingSymbol ');
    } else {
      list.add(leadingSymbol);
    }
  }
  var reversed = list.reversed.join('');
  String result;

  if (trailingSymbol.isNotEmpty) {
    if (useSymbolPadding) {
      result = '$reversed$mantissa $trailingSymbol';
    } else {
      result = '$reversed$mantissa$trailingSymbol';
    }
  } else {
    result = '$reversed$mantissa';
  }

  if (swapCommasAndPrePeriods) {
    return _swapCommasAndPeriods(result);
  }
  return result;
}

/// просто меняет точки и запятые местами
String _swapCommasAndPeriods(String input) {
  var temp = input;
  if (temp.contains('.,')) {
    temp = temp.replaceAll('.,', ',,');
  }
  temp = temp.replaceAll('.', 'PERIOD').replaceAll(',', 'COMMA');
  temp = temp.replaceAll('PERIOD', ',').replaceAll('COMMA', '.');
  return temp;
}

String _replaceSpacesByCommas(
  String value, {
  required int leadingLength,
  required int trailingLength,
}) {
  if (value.length < 2) return value;
  var preSplit = value.split('');
  var stringBuffer = StringBuffer();
  for (var i = 0; i < preSplit.length; i++) {
    var char = preSplit[i];
    if (char == ' ') {
      final minAllowedSpacePos = leadingLength;
      final maxAllowSpacePos = preSplit.length - (1 + trailingLength);
      if (i != minAllowedSpacePos && i != maxAllowSpacePos) {
        stringBuffer.write(',');
      } else {
        stringBuffer.write(char);
      }
    } else {
      stringBuffer.write(char);
    }
  }
  value = stringBuffer.toString();
  return value;
}

String _getRoundedValue(String numericString, double roundTo) {
  assert(roundTo != 0.0);
  var numericValue = double.tryParse(numericString) ?? 0.0;
  var result = numericValue / roundTo;

  var remainder = result.remainder(1.0);
  String prepared;
  if (remainder != 0.0) {
    prepared = result.toStringAsFixed(2);
    if (prepared[prepared.length - 1] == '0') {
      prepared = prepared.substring(0, prepared.length - 1);
    }
    return prepared;
  }
  return result.toInt().toString();
}

String _postProcessMantissa(String mantissaValue, int mantissaLength) {
  if (mantissaLength < 1) return '';
  if (mantissaValue.isNotEmpty) return '.$mantissaValue';
  return '.${List.filled(mantissaLength, '0').join('')}';
}

final RegExp _digitRegExp = RegExp(r'[-0-9]+');
final RegExp _positiveDigitRegExp = RegExp(r'[0-9]+');
final RegExp _digitWithPeriodRegExp = RegExp(r'[-0-9]+(\.[0-9]+)?');
final RegExp _oneDashRegExp = RegExp(r'[-]{2,}');
final RegExp _startPlusRegExp = RegExp(r'^\+{1}[)(\d]+');
final RegExp _maskContentsRegExp = RegExp(r'^[-0-9)( +]{3,}$');
final RegExp _isMaskSymbolRegExp = RegExp(r'^[-\+ )(]+$');

String toNumericString(
  String? inputString, {
  bool allowPeriod = false,
  bool allowHyphen = true,
}) {
  if (inputString == null) return '';
  var startsWithPeriod = numericStringStartsWithOrphanPeriod(
    inputString,
  );

  var regexWithoutPeriod = allowHyphen ? _digitRegExp : _positiveDigitRegExp;
  var regExp = allowPeriod ? _digitWithPeriodRegExp : regexWithoutPeriod;
  var result = inputString.splitMapJoin(
    regExp,
    onMatch: (m) => m.group(0)!,
    onNonMatch: (nm) => '',
  );
  if (startsWithPeriod && allowPeriod) {
    result = '0.$result';
  }
  return result;
}

bool numericStringStartsWithOrphanPeriod(String string) {
  var result = false;
  for (var i = 0; i < string.length; i++) {
    var char = string[i];
    if (isDigit(char)) {
      break;
    }
    if (char == '.' || char == ',') {
      result = true;
      break;
    }
  }
  return result;
}

void checkMask(String mask) {
  if (_oneDashRegExp.hasMatch(mask)) {
    throw ('A mask cannot contain more than one dash (-) symbols in a row');
    // return false;
  }
  if (!_startPlusRegExp.hasMatch(mask)) {
    throw ('A mask must start with a + sign followed by a digit of a rounded brace');
  }
  if (!_maskContentsRegExp.hasMatch(mask)) {
    throw ('A mask can only contain digits, a plus sign, spaces and dashes');
  }
}

bool isUnableToMaskSymbol(String? symbol) {
  if (symbol == null || symbol.length > 1) {
    return false;
  }
  return _isMaskSymbolRegExp.hasMatch(symbol);
}

bool isDigit(String? character) {
  if (character == null || character.isEmpty || character.length > 1) {
    return false;
  }
  return _digitRegExp.stringMatch(character) != null;
}
