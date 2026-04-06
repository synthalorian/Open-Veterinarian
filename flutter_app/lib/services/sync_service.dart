import 'package:supabase_flutter/supabase_flutter.dart';
import '../features/profile/user_profile.dart';
import '../features/anesthesia/anesthesia_protocols.dart';

class SyncService {
  static final SupabaseClient client = Supabase.instance.client;

  static Future<void> initialize(String url, String anonKey) async {
    await Supabase.initialize(url: url, anonKey: anonKey);
  }

  static bool get isAuthenticated => client.auth.currentUser != null;

  static Future<void> signUp(String email, String password) async {
    await client.auth.signUp(email: email, password: password);
  }

  static Future<void> signIn(String email, String password) async {
    await client.auth.signInWithPassword(email: email, password: password);
  }

  static Future<void> signOut() async {
    await client.auth.signOut();
  }

  static Future<void> syncProfileToCloud(UserProfile profile) async {
    final userId = client.auth.currentUser?.id;
    if (userId == null) return;

    await client.from('profiles').upsert({
      'id': userId,
      'veterinarian_name': profile.veterinarianName,
      'clinic_name': profile.clinicName,
      'license_number': profile.licenseNumber,
      'email': profile.email,
      'phone_number': profile.phoneNumber,
      'updated_at': DateTime.now().toIso8601String(),
    });
  }

  static Future<void> syncProtocolsToCloud(List<AnesthesiaProtocol> protocols) async {
    final userId = client.auth.currentUser?.id;
    if (userId == null) return;

    for (var protocol in protocols) {
      await client.from('anesthesia_protocols').upsert({
        'user_id': userId,
        'name': protocol.name,
        'description': protocol.description,
        'drugs': protocol.drugs,
        'indications': protocol.indications,
      });
    }
  }

  static Future<UserProfile?> fetchProfileFromCloud() async {
    final userId = client.auth.currentUser?.id;
    if (userId == null) return null;

    final response = await client.from('profiles').select().eq('id', userId).maybeSingle();
    if (response != null) {
      return UserProfile(
        veterinarianName: response['veterinarian_name'] ?? '',
        clinicName: response['clinic_name'] ?? '',
        licenseNumber: response['license_number'] ?? '',
        email: response['email'] ?? '',
        phoneNumber: response['phone_number'] ?? '',
      );
    }
    return null;
  }
}
