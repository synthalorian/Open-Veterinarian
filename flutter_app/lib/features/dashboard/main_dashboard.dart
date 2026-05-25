import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../calculator/dose_calculator_view.dart';
import '../calculator/fluid_calculator_view.dart';
import '../calculator/emergency_calculator_view.dart';
import '../calculator/cri_calculator_view.dart';
import '../calculator/fluid_additives_calculator_view.dart';
import '../calculator/blood_gas_view.dart';
import '../ui/unit_converter_view.dart';
import '../reference/lab_reference_view.dart';
import '../reference/species_vitals_view.dart';
import '../reference/drug_formulary_view.dart';
import '../reference/drug_detail_view.dart';
import '../reference/species_detail_view.dart';
import '../reference/lab_detail_view.dart';
import '../reference/pathology_list_view.dart';
import '../reference/pathology_detail_view.dart';
import '../reference/imaging_list_view.dart';
import '../reference/anatomy_atlas_view.dart';
import '../reference/ecg_library_view.dart';
import '../reference/ophthalmic_hub_view.dart';
import '../reference/neurology_hud_view.dart';
import '../reference/triage_hud_view.dart';
import '../reference/client_education_hub_view.dart';
import '../video/video_reference_view.dart';
import '../inventory/inventory_tracker_view.dart';
import '../reports/laboratory_logs_view.dart';
import '../reports/surgical_note_taker_view.dart';
import '../anesthesia/anesthesia_checklist_view.dart';
import '../anesthesia/anesthesia_timer_view.dart';
import '../anesthesia/anesthesia_protocols_view.dart';
import '../ai/ai_diagnosis_support_view.dart';
import '../profile/settings_view.dart';
import '../ui/neon_grid_background.dart';
import '../ui/glow_card.dart';
import '../ui/responsive_layout.dart';
import '../reports/report_service.dart';
import '../../providers/search_provider.dart';
import '../../providers/profile_provider.dart';
import '../../providers/theme_provider.dart';
import '../../features/theme/app_theme.dart';

class MainDashboard extends ConsumerStatefulWidget {
  const MainDashboard({super.key});

  @override
  ConsumerState<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends ConsumerState<MainDashboard> {
  Widget? _selectedView;

  @override
  Widget build(BuildContext context) {
    final appColors = ref.watch(appColorsProvider);

    return ResponsiveLayout(
      mobile: _buildMobileDashboard(context, appColors),
      tablet: _buildTabletDashboard(context, appColors),
    );
  }

  Widget _buildMobileDashboard(BuildContext context, AppColors appColors) {
    return Scaffold(
      appBar: _buildAppBar(context, appColors),
      body: Stack(
        children: [
          _buildBackground(appColors),
          ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
            children: _buildDashboardItems(context, appColors),
          ),
        ],
      ),
    );
  }

  Widget _buildTabletDashboard(BuildContext context, AppColors appColors) {
    return Scaffold(
      appBar: _buildAppBar(context, appColors),
      body: Stack(
        children: [
          _buildBackground(appColors),
          Row(
            children: [
              Container(
                width: 300,
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(color: appColors.accent.withAlpha(12)),
                  ),
                ),
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: _buildDashboardItems(context, appColors, isCompact: true),
                ),
              ),
              Expanded(
                child: _selectedView ?? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset('assets/images/app_logo.jpg', width: 200, height: 200),
                      ),
                      const SizedBox(height: 24),
                      Text('Select a tool to begin clinical synthesis', style: TextStyle(color: appColors.textDim)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, AppColors appColors) {
    return AppBar(
      title: Text('Open Veterinarian', style: TextStyle(color: appColors.accent)),
      actions: [
        IconButton(
          icon: Icon(Icons.settings, color: appColors.accent),
          onPressed: () => _navigateTo(context, const SettingsView()),
        ),
      ],
    );
  }

  Widget _buildBackground(AppColors appColors) {
    return Stack(
      children: [
        Positioned.fill(child: CustomPaint(painter: NeonGridBackground(gridColor: appColors.gridColor))),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  appColors.surface.withValues(alpha: 0.8),
                  Colors.transparent,
                  appColors.surface.withValues(alpha: 0.8),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _navigateTo(BuildContext context, Widget view) {
    if (ResponsiveLayout.isTablet(context)) {
      setState(() => _selectedView = view);
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (_) => view));
    }
  }

  List<Widget> _buildDashboardItems(BuildContext context, AppColors appColors, {bool isCompact = false}) {
    return [
      if (!isCompact) ...[
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset('assets/images/app_logo.jpg', width: 120, height: 120),
          ),
        ),
        const SizedBox(height: 24),
      ],
      _buildSectionHeader('Clinical Reference', appColors),
      _buildMenuCard(context, Icons.pets, 'Species Vitals', 'HR, Temp, Resp.', const SpeciesVitalsView(), appColors, isCompact),
      _buildMenuCard(context, Icons.medication, 'Drug Formulary', 'Dosages & indications.', const DrugFormularyView(), appColors, isCompact),
      _buildMenuCard(context, Icons.science, 'Lab Results', 'Reference ranges.', const LabReferenceView(), appColors, isCompact),
      _buildMenuCard(context, Icons.biotech, 'Pathology Hub', 'Disease profiles.', const PathologyListView(), appColors, isCompact, glowColor: appColors.warning),
      _buildMenuCard(context, Icons.settings_overscan, 'Imaging Hub', 'X-Ray & Ultrasound.', const ImagingReferenceListView(), appColors, isCompact, glowColor: appColors.accent),
      _buildMenuCard(context, Icons.visibility, 'Ophthalmic Hub', 'Eye disease reference.', const OphthalmicHubView(), appColors, isCompact),
      _buildMenuCard(context, Icons.psychology, 'Neurology HUD', 'Reflex checklists.', const NeurologyHudView(), appColors, isCompact, glowColor: appColors.accentTertiary),
      _buildMenuCard(context, Icons.warning_amber, 'Emergency Triage', 'A-B-C-D-E checklists.', const TriageHudView(), appColors, isCompact, glowColor: appColors.danger),
      _buildMenuCard(context, Icons.accessibility_new, 'Anatomy Atlas', 'Skeletal & joints.', const AnatomyAtlasView(), appColors, isCompact, glowColor: appColors.success),
      _buildMenuCard(context, Icons.monitor_heart, 'ECG Library', 'Cardiac patterns.', const EcgLibraryView(), appColors, isCompact, glowColor: appColors.danger),
      _buildMenuCard(context, Icons.video_library, 'Video Library', 'Clinical techniques.', const VideoLibraryView(), appColors, isCompact, glowColor: appColors.accentTertiary),
      _buildMenuCard(context, Icons.menu_book, 'Client Education', 'Diagrams for owners.', const ClientEducationHubView(), appColors, isCompact, glowColor: appColors.success),

      const SizedBox(height: 24),
      _buildSectionHeader('Calculators & Tools', appColors),
      _buildMenuCard(context, Icons.report_problem, 'Emergency / CPR', 'Crash cart math.', const EmergencyCalculatorView(), appColors, isCompact, glowColor: appColors.danger),
      _buildMenuCard(context, Icons.calculate, 'Dose Calculator', 'Weight-based math.', const DoseCalculatorView(), appColors, isCompact, glowColor: appColors.accentTertiary),
      _buildMenuCard(context, Icons.water_drop, 'Fluid Therapy', 'Maintenance & deficit.', const FluidCalculatorView(), appColors, isCompact, glowColor: appColors.accent),
      _buildMenuCard(context, Icons.add_circle_outline, 'Fluid Additives', 'K+ or Dextrose.', const FluidAdditivesCalculatorView(), appColors, isCompact),
      _buildMenuCard(context, Icons.trending_up, 'CRI Calculator', 'Constant infusion.', const CriCalculatorView(), appColors, isCompact, glowColor: appColors.success),
      _buildMenuCard(context, Icons.bloodtype, 'Blood Gas', 'Acid-base interpreter.', const BloodGasInterpreterView(), appColors, isCompact, glowColor: appColors.accent),
      _buildMenuCard(context, Icons.swap_horiz, 'Unit Converter', 'Lbs/Kg & F/C.', const UnitConverterView(), appColors, isCompact, glowColor: appColors.warning),
      _buildMenuCard(context, Icons.inventory, 'Inventory Tracker', 'Stock monitoring.', const InventoryTrackerView(), appColors, isCompact),

      const SizedBox(height: 24),
      _buildSectionHeader('Intelligence', appColors),
      _buildMenuCard(context, Icons.auto_awesome, 'AI Diagnosis', 'Synthesis patterns.', const AiDiagnosisSupportView(), appColors, isCompact, glowColor: appColors.accentTertiary),

      const SizedBox(height: 24),
      _buildSectionHeader('Anesthesia & Safety', appColors),
      _buildMenuCard(context, Icons.assignment, 'Protocols', 'ASA-based drug regimens.', const AnesthesiaProtocolsView(), appColors, isCompact, glowColor: appColors.accentTertiary),
      _buildMenuCard(context, Icons.fact_check, 'Checklist', 'Interactive safety checks.', const AnesthesiaChecklistView(), appColors, isCompact, glowColor: appColors.danger),
      _buildMenuCard(context, Icons.timer, 'Anesthesia Timer', 'Real-time monitoring.', const AnesthesiaTimerView(), appColors, isCompact, glowColor: appColors.warning),

      const SizedBox(height: 24),
      _buildSectionHeader('Patient Reports & Logs', appColors),
      _buildMenuCard(context, Icons.analytics, 'Lab Logs', 'Track patient trends.', const LaboratoryLogsView(), appColors, isCompact, glowColor: appColors.accent),
      _buildMenuCard(context, Icons.mic, 'Surgical Notes', 'Note dictation (TTS).', const SurgicalNoteTakerView(), appColors, isCompact, glowColor: appColors.accentTertiary),
      _buildMenuCard(context, Icons.picture_as_pdf, 'Client Summary', 'Generate PDF reports.', null, appColors, isCompact, glowColor: appColors.success, isDialog: true),

      if (!isCompact) ...[
        const SizedBox(height: 40),
        Center(
          child: Text(
            '🎹🦞 VERSION 1.7.0 "NEON-SURGEON"',
            style: TextStyle(fontSize: 10, color: appColors.textDim, letterSpacing: 2, fontFamily: 'monospace'),
          ),
        ),
      ],
    ];
  }

  Widget _buildMenuCard(BuildContext context, IconData icon, String title, String subtitle, Widget? view, AppColors appColors, bool isCompact, {Color? glowColor, bool isDialog = false}) {
    final gc = glowColor ?? appColors.glowColor;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlowCard(
        glowColor: gc,
        child: ListTile(
          onTap: isDialog
            ? () => _showReportDialog(context, ref, appColors)
            : (view != null ? () => _navigateTo(context, view) : null),
          contentPadding: EdgeInsets.symmetric(horizontal: isCompact ? 12 : 20, vertical: isCompact ? 0 : 8),
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: gc.withAlpha(25), borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: gc, size: isCompact ? 20 : 28),
          ),
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: appColors.accent.withAlpha(230), fontSize: isCompact ? 13 : 16)),
          subtitle: isCompact ? null : Text(subtitle, style: TextStyle(fontSize: 12, color: appColors.textDim)),
          trailing: isCompact ? null : Icon(Icons.chevron_right, color: gc.withAlpha(77)),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, AppColors appColors) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 4),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 3.0, color: appColors.sectionHeader),
      ),
    );
  }

  void _showReportDialog(BuildContext context, WidgetRef ref, AppColors appColors) {
    final petNameController = TextEditingController();
    final reasonController = TextEditingController();
    String species = 'Canine';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: appColors.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: appColors.accent, width: 0.5),
        ),
        title: Text('GENERATE CLIENT SUMMARY', style: TextStyle(color: appColors.accent, fontSize: 16, letterSpacing: 1.5)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: petNameController,
              style: TextStyle(color: appColors.accent.withAlpha(204)),
              decoration: InputDecoration(
                labelText: 'Pet Name',
                labelStyle: TextStyle(color: appColors.textDim),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: appColors.accent.withAlpha(25))),
              ),
            ),
            DropdownButtonFormField<String>(
              value: species,
              dropdownColor: appColors.card,
              style: TextStyle(color: appColors.accent),
              items: const [
                DropdownMenuItem(value: 'Canine', child: Text('Canine')),
                DropdownMenuItem(value: 'Feline', child: Text('Feline')),
              ],
              onChanged: (val) => species = val!,
              decoration: InputDecoration(
                labelText: 'Species',
                labelStyle: TextStyle(color: appColors.textDim),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: appColors.accent.withAlpha(25))),
              ),
            ),
            TextField(
              controller: reasonController,
              style: TextStyle(color: appColors.accent.withAlpha(204)),
              decoration: InputDecoration(
                labelText: 'Reason for Visit',
                labelStyle: TextStyle(color: appColors.textDim),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: appColors.accent.withAlpha(25))),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('CANCEL', style: TextStyle(color: appColors.textDim)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: appColors.accent, foregroundColor: Colors.white),
            onPressed: () {
              final profile = ref.read(profileNotifierProvider);
              ReportService.generateClientSummary(
                petName: petNameController.text,
                species: species,
                weight: 5.0,
                reasonForVisit: reasonController.text,
                findings: {
                  'Temperature': '38.5 °C',
                  'Heart Rate': '120 bpm',
                  'Assessment': 'Normal clinical examination.',
                  'Veterinarian': profile.veterinarianName,
                  'Clinic': profile.clinicName,
                },
              );
              Navigator.pop(context);
            },
            child: const Text('GENERATE PDF'),
          ),
        ],
      ),
    );
  }
}

class GlobalSearchDelegate extends SearchDelegate {
  final WidgetRef ref;
  final AppColors appColors;
  final Function(Widget) onNavigate;

  GlobalSearchDelegate(this.ref, this.appColors, {required this.onNavigate});

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: appColors.textDim),
        border: InputBorder.none,
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear, color: appColors.accent),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, color: appColors.accent),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) => _buildSearchResults(context);

  @override
  Widget buildSuggestions(BuildContext context) => _buildSearchResults(context);

  Widget _buildSearchResults(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(globalSearchProvider.notifier).search(query);
    });

    final results = ref.watch(globalSearchProvider);

    if (query.isEmpty) {
      return Container(
        color: appColors.surface,
        child: Center(
          child: Text('Search drugs, species, labs, or pathology...', style: TextStyle(color: appColors.textDim, fontFamily: 'monospace')),
        ),
      );
    }

    if (results.isEmpty) {
      return Container(
        color: appColors.surface,
        child: Center(
          child: Text('No results found.', style: TextStyle(color: appColors.danger, fontFamily: 'monospace')),
        ),
      );
    }

    return Container(
      color: appColors.surface,
      child: ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          final result = results[index];
          IconData icon;
          switch (result.type) {
            case SearchResultType.species:
              icon = Icons.pets;
              break;
            case SearchResultType.drug:
              icon = Icons.medication;
              break;
            case SearchResultType.lab:
              icon = Icons.science;
              break;
            case SearchResultType.pathology:
              icon = Icons.biotech;
              break;
            case SearchResultType.imaging:
              icon = Icons.settings_overscan;
              break;
          }

          return ListTile(
            leading: Icon(icon, color: appColors.accent),
            title: Text(result.title, style: TextStyle(color: appColors.accent.withAlpha(230), fontWeight: FontWeight.bold)),
            subtitle: Text(result.subtitle, style: TextStyle(color: appColors.textDim)),
            onTap: () {
              Widget view;
              switch (result.type) {
                case SearchResultType.species:
                  view = SpeciesDetailView(species: result.originalObject);
                  break;
                case SearchResultType.drug:
                  view = DrugDetailView(drug: result.originalObject);
                  break;
                case SearchResultType.lab:
                  view = LabDetailView(lab: result.originalObject);
                  break;
                case SearchResultType.pathology:
                  view = PathologyDetailView(pathology: result.originalObject);
                  break;
                case SearchResultType.imaging:
                  view = const ImagingReferenceListView();
                  break;
              }
              close(context, null);
              onNavigate(view);
            },
          );
        },
      ),
    );
  }
}
