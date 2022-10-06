import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  factory UserPreferences() => _instancia;
  UserPreferences._internal();
  static final UserPreferences _instancia = UserPreferences._internal();

  SharedPreferences _prefs;

  String _localProyectKey = '__local_projects__key__';
  String _userDataKey = '__user_data_key__';
  String _projectsDetailKey = '__projects_detail_key__';
  String _projectsCacheKey = '__projects_cache_key__';

  Future<SharedPreferences> initPrefs() async =>
      _prefs = await SharedPreferences.getInstance();

  String get userData {
    return _prefs.getString(_userDataKey) ?? '';
  }

  set userData(String value) {
    _prefs.setString(_userDataKey, value);
  }

  String get projects {
    return _prefs.getString(_localProyectKey) ?? '';
  }

  set projects(String value) {
    _prefs.setString(_localProyectKey, value);
  }

  String get projectsDetail {
    return _prefs.getString(_projectsDetailKey) ?? '';
  }

  set projectsDetail(String value) {
    _prefs.setString(_projectsDetailKey, value);
  }

  String get projectsCache {
    return _prefs.getString(_projectsCacheKey) ?? '';
  }

  set projectsCache(String value) {
    _prefs.setString(_projectsCacheKey, value);
  }

  Future<bool> clear() async {
    return await _prefs.clear();
  }
}
