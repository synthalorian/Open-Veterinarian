import 'package:hive/hive.dart';

part 'user_profile.g.dart';

@HiveType(typeId: 8)
class UserProfile extends HiveObject {
  @HiveField(0)
  String veterinarianName;
  @HiveField(1)
  String clinicName;
  @HiveField(2)
  String licenseNumber;
  @HiveField(3)
  String email;
  @HiveField(4)
  String phoneNumber;

  UserProfile({
    this.veterinarianName = '',
    this.clinicName = '',
    this.licenseNumber = '',
    this.email = '',
    this.phoneNumber = '',
  });

  UserProfile copyWith({
    String? veterinarianName,
    String? clinicName,
    String? licenseNumber,
    String? email,
    String? phoneNumber,
  }) {
    return UserProfile(
      veterinarianName: veterinarianName ?? this.veterinarianName,
      clinicName: clinicName ?? this.clinicName,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
