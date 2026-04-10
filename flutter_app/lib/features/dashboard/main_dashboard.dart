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

class MainDashboard extends ConsumerStatefulWidget {
  const MainDashboard({super.key});

  @override
  ConsumerState<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends ConsumerState<MainDashboard> {
  Widget? _selectedView;

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobileDashboard(context),
      tablet: _buildTabletDashboard(context),
    );
  }

  Widget _buildMobileDashboard(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(context),
      body: Stack(
        children: [
          _buildBackground(),
          ListView(
            padding: const EdgeInsets.fromLTRB(16, 120, 16, 40),
            children: _buildDashboardItems(context),
          ),
        ],
      ),
    );
  }

  Widget _buildTabletDashboard(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Stack(
        children: [
          _buildBackground(),
          Row(
            children: [
              Container(
                width: 300,
                decoration: BoxDecoration(border: Border(right: BorderSide(color: Colors.white.withValues(alpha: 0.1)))),
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: _buildDashboardItems(context, isCompact: true),
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
                      const Text('Select a tool to begin clinical synthesis', style: TextStyle(color: Colors.white24)),
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

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!ResponsiveLayout.isTablet(context))
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.asset('assets/images/app_logo.jpg', width: 24, height: 24),
              ),
            ),
          const Text('🎹🦞 OPEN VETERINARIAN'),
        ],
      ),
      actions: [
        IconButton(icon: const Icon(Icons.settings, color: Colors.cyanAccent), onPressed: () => _navigateTo(context, const SettingsView())),
        IconButton(
          icon: const Icon(Icons.search, color: Colors.cyanAccent),
          onPressed: () {
            showSearch(context: context, delegate: GlobalSearchDelegate(ref, onNavigate: (view) => _navigateTo(context, view)));
          },
        ),
      ],
    );
  }

  Widget _buildBackground() {
    return Stack(
      children: [
        Positioned.fill(child: CustomPaint(painter: NeonGridBackground(gridColor: Colors.cyan))),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black.withValues(alpha: 0.8), Colors.transparent, Colors.black.withOpacity(0.8)],
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

  List<Widget> _buildDashboardItems(BuildContext context, {bool isCompact = false}) {
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
      _buildSectionHeader('Clinical Reference'),
      _buildMenuCard(context, Icons.pets, 'Species Vitals', 'HR, Temp, Resp.', const SpeciesVitalsView(), isCompact),
      _buildMenuCard(context, Icons.medication, 'Drug Formulary', 'Dosages & indications.', const DrugFormularyView(), isCompact),
      _buildMenuCard(context, Icons.science, 'Lab Results', 'Reference ranges.', const LabReferenceView(), isCompact),
      _buildMenuCard(context, Icons.biotech, 'Pathology Hub', 'Disease profiles.', const PathologyListView(), isCompact, glowColor: Colors.orangeAccent),
      _buildMenuCard(context, Icons.settings_overscan, 'Imaging Hub', 'X-Ray & Ultrasound.', const ImagingReferenceListView(), isCompact, glowColor: Colors.blueAccent),
      _buildMenuCard(context, Icons.visibility, 'Ophthalmic Hub', 'Eye disease reference.', const OphthalmicHubView(), isCompact),
      _buildMenuCard(context, Icons.psychology, 'Neurology HUD', 'Reflex checklists.', const NeurologyHudView(), isCompact, glowColor: Colors.purpleAccent),
      _buildMenuCard(context, Icons.warning_amber, 'Emergency Triage', 'A-B-C-D-E checklists.', const TriageHudView(), isCompact, glowColor: Colors.redAccent),
      _buildMenuCard(context, Icons.accessibility_new, 'Anatomy Atlas', 'Skeletal & joints.', const AnatomyAtlasView(), isCompact, glowColor: Colors.greenAccent),
      _buildMenuCard(context, Icons.monitor_heart, 'ECG Library', 'Cardiac patterns.', const EcgLibraryView(), isCompact, glowColor: Colors.redAccent),
      _buildMenuCard(context, Icons.video_library, 'Video Library', 'Clinical techniques.', const VideoLibraryView(), isCompact, glowColor: Colors.pinkAccent),
      _buildMenuCard(context, Icons.menu_book, 'Client Education', 'Diagrams for owners.', const ClientEducationHubView(), isCompact, glowColor: Colors.tealAccent),
      
      const SizedBox(height: 24),
      _buildSectionHeader('Calculators & Tools'),
      _buildMenuCard(context, Icons.report_problem, 'Emergency / CPR', 'Crash cart math.', const EmergencyCalculatorView(), isCompact, glowColor: Colors.redAccent),
      _buildMenuCard(context, Icons.calculate, 'Dose Calculator', 'Weight-based math.', const DoseCalculatorView(), isCompact, glowColor: Colors.purpleAccent),
      _buildMenuCard(context, Icons.water_drop, 'Fluid Therapy', 'Maintenance & deficit.', const FluidCalculatorView(), isCompact, glowColor: Colors.blueAccent),
      _buildMenuCard(context, Icons.add_circle_outline, 'Fluid Additives', 'K+ or Dextrose.', const FluidAdditivesCalculatorView(), isCompact),
      _buildMenuCard(context, Icons.trending_up, 'CRI Calculator', 'Constant infusion.', const CriCalculatorView(), isCompact, glowColor: Colors.greenAccent),
      _buildMenuCard(context, Icons.bloodtype, 'Blood Gas', 'Acid-base interpreter.', const BloodGasInterpreterView(), isCompact, glowColor: Colors.cyanAccent),
      _buildMenuCard(context, Icons.swap_horiz, 'Unit Converter', 'Lbs/Kg & F/C.', const UnitConverterView(), isCompact, glowColor: Colors.orangeAccent),
      _buildMenuCard(context, Icons.inventory, 'Inventory Tracker', 'Stock monitoring.', const InventoryTrackerView(), isCompact),
      
      const SizedBox(height: 24),
      _buildSectionHeader('Intelligence'),
      _buildMenuCard(context, Icons.auto_awesome, 'AI Diagnosis', 'Synthesis patterns.', const AiDiagnosisSupportView(), isCompact, glowColor: Colors.purpleAccent),
      
      const SizedBox(height: 24),
      _buildSectionHeader('Anesthesia & Safety'),
      _buildMenuCard(context, Icons.assignment, 'Protocols', 'ASA-based drug regimens.', const AnesthesiaProtocolsView(), isCompact, glowColor: Colors.purpleAccent),
      _buildMenuCard(context, Icons.fact_check, 'Checklist', 'Interactive safety checks.', const AnesthesiaChecklistView(), isCompact, glowColor: Colors.redAccent),
      _buildMenuCard(context, Icons.timer, 'Anesthesia Timer', 'Real-time monitoring.', const AnesthesiaTimerView(), isCompact, glowColor: Colors.orangeAccent),
      
      const SizedBox(height: 24),
      _buildSectionHeader('Patient Reports & Logs'),
      _buildMenuCard(context, Icons.analytics, 'Lab Logs', 'Track patient trends.', const LaboratoryLogsView(), isCompact, glowColor: Colors.blueAccent),
      _buildMenuCard(context, Icons.mic, 'Surgical Notes', 'Note dictation (TTS).', const SurgicalNoteTakerView(), isCompact, glowColor: Colors.pinkAccent),
      _buildMenuCard(context, Icons.picture_as_pdf, 'Client Summary', 'Generate PDF reports.', null, isCompact, glowColor: Colors.greenAccent, isDialog: true),
      
      if (!isCompact) ...[
        const SizedBox(height: 40),
        const Center(
          child: Text(
            '🎹🦞 VERSION 1.7.0 "NEON-SURGEON"',
            style: TextStyle(fontSize: 10, color: Colors.grey, letterSpacing: 2, fontFamily: 'monospace'),
          ),
        ),
      ],
    ];
  }

  Widget _buildMenuCard(BuildContext context, IconData icon, String title, String subtitle, Widget? view, bool isCompact, {Color glowColor = Colors.cyanAccent, bool isDialog = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlowCard(
        glowColor: glowColor,
        child: ListTile(
          onTap: isDialog 
            ? () => _showReportDialog(context, ref)
            : (view != null ? () => _navigateTo(context, view) : null),
          contentPadding: EdgeInsets.symmetric(horizontal: isCompact ? 12 : 20, vertical: isCompact ? 0 : 8),
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: glowColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: glowColor, size: isCompact ? 20 : 28),
          ),
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: isCompact ? 13 : 16)),
          subtitle: isCompact ? null : Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          trailing: isCompact ? null : Icon(Icons.chevron_right, color: glowColor.withValues(alpha: 0.5)),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 4),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 3.0, color: Colors.white70),
      ),
    );
  }

  void _showReportDialog(BuildContext context, WidgetRef ref) {
    final petNameController = TextEditingController();
    final reasonController = TextEditingController();
    String species = 'Canine';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF0A0A0A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: const BorderSide(color: Colors.cyanAccent, width: 0.5)),
        title: const Text('GENERATE CLIENT SUMMARY', style: TextStyle(color: Colors.cyanAccent, fontSize: 16, letterSpacing: 1.5)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: petNameController, decoration: const InputDecoration(labelText: 'Pet Name', labelStyle: TextStyle(color: Colors.grey))),
            DropdownButtonFormField<String>(
              value: species,
              dropdownColor: Colors.black,
              items: const [
                DropdownMenuItem(value: 'Canine', child: Text('Canine')),
                DropdownMenuItem(value: 'Feline', child: Text('Feline')),
              ],
              onChanged: (val) => species = val!,
              decoration: const InputDecoration(labelText: 'Species', labelStyle: TextStyle(color: Colors.grey)),
            ),
            TextField(controller: reasonController, decoration: const InputDecoration(labelText: 'Reason for Visit', labelStyle: TextStyle(color: Colors.grey))),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCEL', style: TextStyle(color: Colors.grey))),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.cyanAccent, foregroundColor: Colors.black),
            onPressed: () {
              final profile = ref.read(profileNotifierProvider);
              ReportService.generateClientSummary(
                petName: petNameController.text,
                species: species,
                weight: 5.0, // Placeholder
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
  final Function(Widget) onNavigate;

  GlobalSearchDelegate(this.ref, {required this.onNavigate});

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.grey),
        border: InputBorder.none,
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
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
        color: Colors.black,
        child: const Center(child: Text('Search drugs, species, labs, or pathology...', style: TextStyle(color: Colors.grey, fontFamily: 'monospace'))),
      );
    }

    if (results.isEmpty) {
      return Container(
        color: Colors.black,
        child: const Center(child: Text('No results found.', style: TextStyle(color: Colors.redAccent, fontFamily: 'monospace'))),
      );
    }

    return Container(
      color: Colors.black,
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
            leading: Icon(icon, color: Colors.cyanAccent),
            title: Text(result.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: Text(result.subtitle, style: const TextStyle(color: Colors.grey)),
            onTap: () {
              // Detailed Navigation
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
