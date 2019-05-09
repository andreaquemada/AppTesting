// Crazy work-around to convert from String back to DateTime:
class String2DateTime {

  static DateTime getTime(String mytime) {

    DateTime outTime;

    String selectedSmall = mytime.substring(5);
    List<String> selectedPieces = selectedSmall.split('/');
    String selectedCombined = selectedPieces[2]+selectedPieces[0].padLeft(2,'0')+selectedPieces[1].padLeft(2,'0');
    outTime = DateTime.parse(selectedCombined);

    return outTime;
  }

}