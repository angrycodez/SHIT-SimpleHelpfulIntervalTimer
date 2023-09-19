
class TypeConverter{
  static String durationToString(Duration duration, {bool addAppendix = true}){
    String s = "";
    String appendix = " min";
    int hours = hoursFromDuration(duration);
    if(hours > 0){
      s += "$hours:";
      appendix = " h";
    }
    int minutes = minutesFromDuration(duration);
    int seconds = secondsFromDuration(duration);
    s += "${intToString(minutes, 2)}:${intToString(seconds, 2)}${addAppendix ? appendix : ""}";
    return s;
  }

  static String intToString(int value, int digits) => value.toString().padLeft(digits, '0');


  static int hoursFromDuration(Duration d) {
    return int.parse(d.toString().split(":")[0]);
  }

  static int minutesFromDuration(Duration d) {
    return int.parse(d.toString().split(":")[1]);
  }

  static int secondsFromDuration(Duration d) {
    return int.parse(d.toString().split(".")[0].split(":")[2]);
  }
}