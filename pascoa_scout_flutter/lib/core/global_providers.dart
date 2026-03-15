import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pascoa_scout_client/pascoa_scout_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError(),
);

final clientProvider = Provider<Client>((ref) {
  return throw UnimplementedError();
});
