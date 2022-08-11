String toIso8601String(
    {year,
    month,
    day,
    hour,
    minute,
    second,
    millisecond,
    microsecond,
    twoDigits,
    threeDigits,
    fourDigits,
    sixDigits,
    isUtc}) {
  String y =
      (year >= -9999 && year <= 9999) ? fourDigits(year) : sixDigits(year);
  String m = twoDigits(month);
  String d = twoDigits(day);
  String h = twoDigits(hour);
  String min = twoDigits(minute);
  String sec = twoDigits(second);
  String ms = threeDigits(millisecond);
  String us = microsecond == 0 ? "" : threeDigits(microsecond);
  if (isUtc) {
    return "$y-$m-${d}T$h:$min:$sec.$ms${us}Z";
  } else {
    return "$y-$m-${d}T$h:$min:$sec.$ms$us";
  }
}
