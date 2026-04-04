import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../features/profile/user_profile.dart';
import '../services/database_service.dart';

part 'profile_provider.g.dart';

@riverpod
class ProfileNotifier extends _$ProfileNotifier {
  @override
  UserProfile build() {
    final box = DatabaseService.getProfileBox();
    return box.getAt(0) ?? UserProfile();
  }

  void updateName(String name) {
    state = state.copyWith(veterinarianName: name);
    state.save();
  }

  void updateClinic(String clinic) {
    state = state.copyWith(clinicName: clinic);
    state.save();
  }

  void updateLicense(String license) {
    state = state.copyWith(licenseNumber: license);
    state.save();
  }

  void updateEmail(String email) {
    state = state.copyWith(email: email);
    state.save();
  }

  void updatePhone(String phone) {
    state = state.copyWith(phoneNumber: phone);
    state.save();
  }
}
