import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/sync_service.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  User? build() {
    return SyncService.client.auth.currentUser;
  }

  Future<void> signIn(String email, String password) async {
    await SyncService.signIn(email, password);
    state = SyncService.client.auth.currentUser;
  }

  Future<void> signUp(String email, String password) async {
    await SyncService.signUp(email, password);
    state = SyncService.client.auth.currentUser;
  }

  Future<void> signOut() async {
    await SyncService.signOut();
    state = null;
  }
}
