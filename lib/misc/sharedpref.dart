import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  saveData(key, email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(key, email);
    print('saved in shared pref : $email');
  }

  loadData(key) async {
    await SharedPreferences.getInstance().then(
      (prefs) {
        var fetched = prefs.getString(key);
        return fetched;
      },
    );
  }
}
