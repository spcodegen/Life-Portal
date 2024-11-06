class GlobalData {
  static String? loggedInNic;

  static void setLoggedInNic(String nicNumber) {
    loggedInNic = nicNumber;
  }

  static String? getLoggedInNic() {
    return loggedInNic;
  }
}
