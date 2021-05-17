import 'dart:async' show Future;
import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  static String introScreen = "IntroScrees";
  static String isLogin = "isLogin";
  static String userId = "userId";
  static String userName = "userName";
  static String userRole = "userRole";
  static String UserId = "userId";
  static String isStudent = "isStudent";
  static String isOrganization = "isOrganization";
  static String userFirstName = "userFirstName";
  static String userLastName = "userLastName";
  static String userEmail = "userEmail";
  static String userMobileNumber = "userMobileNumber";
  static String userImage = "userImage";
  static String fcmToken = "fcmToken";
  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences _prefsInstance;

  // call this method from iniState() function of mainApp().

  static Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  static Future<String> setFcmToken(String token) async {
    var prefs = await _instance;
    return prefs?.setString(fcmToken, token) ?? Future.value('');
  }

  static getFcmToken() {
    return _prefsInstance.getString(fcmToken);
  }

  static Future<String> setUserName(String Username) async {
    var prefs = await _instance;
    return prefs?.setString(userName, Username) ?? Future.value('');
  }

  static getUserName() {
    return _prefsInstance.getString(userName);
  }

  static Future<String> setUserFirstName(String firstName) async {
    var prefs = await _instance;
    return prefs.setString(userFirstName, firstName) ?? Future.value('');
  }

  static getUserFirstName() {
    return _prefsInstance.getString(userFirstName);
  }

  static Future<String> setUserLastName(String lastName) async {
    var prefs = await _instance;
    return prefs.setString(userLastName, lastName) ?? Future.value('');
  }

  static getUserLastName() {
    return _prefsInstance.getString(userLastName);
  }

  static Future<String> setUserEmail(String userEmailId) async {
    var prefs = await _instance;
    return prefs.setString(userEmail, userEmailId) ?? Future.value('');
  }

  static getUserEmail() {
    return _prefsInstance.getString(userEmail);
  }

  static Future<String> setUserMobile(String userMobileNo) async {
    var prefs = await _instance;
    return prefs.setString(userMobileNumber, userMobileNo) ?? Future.value('');
  }

  static getUserMobile() {
    return _prefsInstance.getString(userMobileNumber);
  }

  static Future<bool> setBoolen(bool value) async {
    var prefs = await _instance;
    return prefs?.setBool(introScreen, value) ?? Future.value(false);
  }

  static getBoolen() {
    return _prefsInstance.getBool(introScreen) ?? false;
  }

  static Future<bool> setIsLogin(bool value) async {
    var prefs = await _instance;
    return prefs?.setBool(isLogin, value) ?? Future.value(false);
  }

  static getIsLogin() {
    return _prefsInstance.getBool(isLogin) ?? false;
  }

  static Future<bool> setIsOrganization(bool value) async {
    var prefs = await _instance;
    return prefs?.setBool(isOrganization, value) ?? Future.value(false);
  }

  static getIsOrganization() {
    return _prefsInstance.getBool(isOrganization) ?? false;
  }

  static Future<bool> setIsStudent(bool value) async {
    var prefs = await _instance;
    return prefs?.setBool(isStudent, value) ?? Future.value(false);
  }

  static getIsStudent() {
    return _prefsInstance.getBool(isStudent) ?? false;
  }

  static Future<int> setUserRole(int value) async {
    var prefs = await _instance;
    return prefs?.setInt(userRole, value) ?? Future.value(0);
  }

  static getUserRole() {
    return _prefsInstance.getInt(userRole);
  }

  static Future<int> setUserId(int newuserId) async {
    var prefs = await _instance;
    return prefs?.setInt(userId, newuserId) ?? Future.value(0);
  }

  static getUserId() {
    return _prefsInstance.getInt(userId);
  }

  static Future<String> setUserImage(String imageUrl) async {
    var prefs = await _instance;
    return prefs?.setString(userImage, imageUrl) ?? Future.value('');
  }

  static getUserImage() {
    return _prefsInstance.getString(userImage);
  }

  void clearPreferences() {
    _prefsInstance.remove(userName);
    _prefsInstance.remove(isLogin);
  }

}
