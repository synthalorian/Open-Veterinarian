import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/profile_provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/theme_provider.dart';
import '../../features/theme/app_theme.dart';
import '../ui/glow_card.dart';
import '../backup/backup_service.dart';
import '../../services/sync_service.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileNotifierProvider);
    final profileNotifier = ref.read(profileNotifierProvider.notifier);
    final user = ref.watch(authNotifierProvider);
    final authNotifier = ref.read(authNotifierProvider.notifier);
    final currentTheme = ref.watch(themeNotifierProvider);
    final appColors = ref.watch(appColorsProvider);
    final themeNotifier = ref.read(themeNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text('SETTINGS & PROFILE', style: TextStyle(color: appColors.accent, fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 2.0, fontFamily: 'monospace')),
        iconTheme: IconThemeData(color: appColors.accent),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildThemeSection(context, currentTheme, themeNotifier, appColors),
            const SizedBox(height: 24),
            _buildProfileSection(context, profile, profileNotifier, appColors),
            const SizedBox(height: 24),
            _buildSyncSection(context, user, authNotifier, profile, appColors),
            const SizedBox(height: 24),
            _buildBackupSection(context, appColors),
            const SizedBox(height: 24),
            _buildAppInfoSection(context, appColors),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeSection(BuildContext context, AppThemeType currentTheme, ThemeNotifier notifier, AppColors appColors) {
    return GlowCard(
      glowColor: appColors.accentSecondary,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.palette, color: appColors.accentSecondary, size: 20),
                const SizedBox(width: 12),
                Text(
                  'THEME',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: appColors.accentSecondary,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...AppThemeType.values.map((theme) {
              final isSelected = currentTheme == theme;
              IconData icon;
              switch (theme) {
                case AppThemeType.dark:
                  icon = Icons.dark_mode;
                  break;
                case AppThemeType.light:
                  icon = Icons.light_mode;
                  break;
                case AppThemeType.synthwave:
                  icon = Icons.color_lens;
                  break;
                case AppThemeType.synthwave84:
                  icon = Icons.wb_sunny;
                  break;
              }
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: InkWell(
                  onTap: () => notifier.setTheme(theme),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: isSelected ? appColors.accentSecondary.withAlpha(26) : Colors.transparent,
                      border: Border.all(
                        color: isSelected ? appColors.accentSecondary : appColors.textDim.withAlpha(51),
                        width: isSelected ? 1.5 : 0.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(icon, color: isSelected ? appColors.accentSecondary : appColors.textDim, size: 20),
                        const SizedBox(width: 12),
                        Text(
                          theme.label,
                          style: TextStyle(
                            color: isSelected ? appColors.accentSecondary : appColors.textDim,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                        const Spacer(),
                        if (isSelected)
                          Icon(Icons.check_circle, color: appColors.accentSecondary, size: 18),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildSyncSection(BuildContext context, user, authNotifier, profile, AppColors appColors) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return GlowCard(
      glowColor: appColors.success,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.cloud_sync, color: appColors.success),
                const SizedBox(width: 12),
                Text(
                  'CLOUD SYNC (SUPABASE)',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: appColors.success,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (user == null) ...[
              Text(
                'Sign in to sync your clinical data and profile across devices.',
                style: TextStyle(fontSize: 12, color: appColors.textDim),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                style: TextStyle(color: appColors.accent.withAlpha(204)),
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: appColors.textDim),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: appColors.accent.withAlpha(25))),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: passwordController,
                obscureText: true,
                style: TextStyle(color: appColors.accent.withAlpha(204)),
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: appColors.textDim),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: appColors.accent.withAlpha(25))),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => authNotifier.signIn(emailController.text, passwordController.text),
                      style: ElevatedButton.styleFrom(backgroundColor: appColors.success, foregroundColor: Colors.white),
                      child: const Text('LOGIN'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => authNotifier.signUp(emailController.text, passwordController.text),
                      style: OutlinedButton.styleFrom(side: BorderSide(color: appColors.success), foregroundColor: appColors.success),
                      child: const Text('SIGN UP'),
                    ),
                  ),
                ],
              ),
            ] else ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: appColors.accent.withAlpha(12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.account_circle, color: appColors.success, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Signed in as: ${user.email}',
                        style: TextStyle(color: appColors.accent, fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.sync),
                      label: const Text('SYNC NOW'),
                      onPressed: () async {
                        await SyncService.syncProfileToCloud(profile);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile synced to cloud.')));
                        }
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: appColors.success, foregroundColor: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.logout),
                      label: const Text('LOGOUT'),
                      onPressed: () => authNotifier.signOut(),
                      style: ElevatedButton.styleFrom(backgroundColor: appColors.danger.withAlpha(51), foregroundColor: appColors.danger),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context, profile, notifier, AppColors appColors) {
    return GlowCard(
      glowColor: appColors.accent,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'VETERINARIAN PROFILE',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: appColors.accent,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            _buildTextField('Veterinarian Name', profile.veterinarianName, notifier.updateName, appColors),
            _buildTextField('Clinic Name', profile.clinicName, notifier.updateClinic, appColors),
            _buildTextField('License Number', profile.licenseNumber, notifier.updateLicense, appColors),
            _buildTextField('Email Address', profile.email, notifier.updateEmail, appColors, keyboardType: TextInputType.emailAddress),
            _buildTextField('Phone Number', profile.phoneNumber, notifier.updatePhone, appColors, keyboardType: TextInputType.phone),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String initialValue, Function(String) onChanged, AppColors appColors, {TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: TextEditingController(text: initialValue)..selection = TextSelection.collapsed(offset: initialValue.length),
        style: TextStyle(color: appColors.accent.withAlpha(204)),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: appColors.textDim),
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: appColors.accent.withAlpha(25))),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: appColors.accent)),
        ),
        keyboardType: keyboardType,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildBackupSection(BuildContext context, AppColors appColors) {
    return GlowCard(
      glowColor: appColors.accent,
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'DATABASE BACKUP',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: appColors.accent,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Export or import your entire clinical database (Vitals, Drugs, Labs, Profile, and Checklists).',
                style: TextStyle(fontSize: 12, color: appColors.textDim),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.upload_file),
                      label: const Text('EXPORT'),
                      onPressed: () => BackupService.exportBackup(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appColors.accent.withAlpha(51),
                        foregroundColor: appColors.accent,
                      ),
                    ),
                  ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.download_for_offline),
                    label: const Text('RESTORE'),
                    onPressed: () async {
                      final success = await BackupService.importBackup();
                      if (success && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Database restored successfully!')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appColors.danger.withAlpha(51),
                      foregroundColor: appColors.danger,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppInfoSection(BuildContext context, AppColors appColors) {
    return GlowCard(
      glowColor: appColors.accentTertiary,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'APP INFORMATION',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: appColors.accentTertiary,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            _InfoRow('Version', '1.7.0 "NEON-SURGEON"', appColors),
            _InfoRow('Engine', 'Flutter 3.4.1+', appColors),
            _InfoRow('Persistence', 'Hive NoSQL', appColors),
            _InfoRow('Sync Engine', 'Supabase', appColors),
            _InfoRow('License', 'Open Source (GPL-3.0)', appColors),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final AppColors appColors;

  const _InfoRow(this.label, this.value, this.appColors);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: appColors.textDim)),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', color: appColors.accent)),
        ],
      ),
    );
  }
}
