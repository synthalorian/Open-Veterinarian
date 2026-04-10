import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/profile_provider.dart';
import '../../providers/auth_provider.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('SETTINGS & PROFILE'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildProfileSection(context, profile, profileNotifier),
            const SizedBox(height: 24),
            _buildSyncSection(context, user, authNotifier, profile),
            const SizedBox(height: 24),
            _buildBackupSection(context),
            const SizedBox(height: 24),
            _buildAppInfoSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSyncSection(BuildContext context, user, authNotifier, profile) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return GlowCard(
      glowColor: Colors.greenAccent,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.cloud_sync, color: Colors.greenAccent),
                const SizedBox(width: 12),
                const Text(
                  'CLOUD SYNC (SUPABASE)',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.greenAccent,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (user == null) ...[
              const Text(
                'Sign in to sync your clinical data and profile across devices.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white10)),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: passwordController,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white10)),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => authNotifier.signIn(emailController.text, passwordController.text),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent, foregroundColor: Colors.black),
                      child: const Text('LOGIN'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => authNotifier.signUp(emailController.text, passwordController.text),
                      style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.greenAccent), foregroundColor: Colors.greenAccent),
                      child: const Text('SIGN UP'),
                    ),
                  ),
                ],
              ),
            ] else ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.account_circle, color: Colors.greenAccent, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Signed in as: ${user.email}',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
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
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent, foregroundColor: Colors.black),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.logout),
                      label: const Text('LOGOUT'),
                      onPressed: () => authNotifier.signOut(),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent.withValues(alpha: 0.2), foregroundColor: Colors.white),
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

  Widget _buildProfileSection(BuildContext context, profile, notifier) {
    return GlowCard(
      glowColor: Colors.cyanAccent,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'VETERINARIAN PROFILE',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.cyanAccent,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            _buildTextField(
              'Veterinarian Name',
              profile.veterinarianName,
              notifier.updateName,
            ),
            _buildTextField(
              'Clinic Name',
              profile.clinicName,
              notifier.updateClinic,
            ),
            _buildTextField(
              'License Number',
              profile.licenseNumber,
              notifier.updateLicense,
            ),
            _buildTextField(
              'Email Address',
              profile.email,
              notifier.updateEmail,
              keyboardType: TextInputType.emailAddress,
            ),
            _buildTextField(
              'Phone Number',
              profile.phoneNumber,
              notifier.updatePhone,
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String initialValue, Function(String) onChanged, {TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: TextEditingController(text: initialValue)..selection = TextSelection.collapsed(offset: initialValue.length),
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.grey),
          border: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white10)),
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.cyanAccent)),
        ),
        keyboardType: keyboardType,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildBackupSection(BuildContext context) {
    return GlowCard(
      glowColor: Colors.blueAccent,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'DATABASE BACKUP',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Export or import your entire clinical database (Vitals, Drugs, Labs, Profile, and Checklists).',
              style: TextStyle(fontSize: 12, color: Colors.grey),
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
                      backgroundColor: Colors.blueAccent.withValues(alpha: 0.2),
                      foregroundColor: Colors.white,
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
                      backgroundColor: Colors.redAccent.withValues(alpha: 0.2),
                      foregroundColor: Colors.white,
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

  Widget _buildAppInfoSection(BuildContext context) {
    return GlowCard(
      glowColor: Colors.purpleAccent,
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'APP INFORMATION',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.purpleAccent,
                letterSpacing: 1.5,
              ),
            ),
            SizedBox(height: 16),
            _InfoRow('Version', '1.1.0 "Cyber-Lobster"'),
            _InfoRow('Engine', 'Flutter 3.4.1'),
            _InfoRow('Persistence', 'Hive NoSQL'),
            _InfoRow('Sync Engine', 'Supabase'),
            _InfoRow('License', 'Open Source (GPL-3.0)'),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace')),
        ],
      ),
    );
  }
}
