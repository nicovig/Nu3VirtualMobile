abstract class DateStore {
  Future<DateTime> getDate();
  Future<void> setDate(DateTime date);
}
