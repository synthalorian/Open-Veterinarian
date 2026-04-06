import 'package:hive_flutter/hive_flutter.dart';
import '../features/reference/data/species_vitals.dart';
import '../features/reference/data/drug_reference.dart';
import '../features/reference/data/lab_reference.dart';
import '../features/reference/data/pathology.dart';
import '../features/reference/data/imaging.dart';
import '../features/reference/data/anatomy.dart';
import '../features/reference/data/ecg_reference.dart';
import '../features/reference/data/ophthalmology.dart';
import '../features/reference/data/triage.dart';
import '../features/video/video_reference.dart';
import '../features/inventory/inventory_item.dart';
import '../features/anesthesia/surgical_checklist.dart';
import '../features/anesthesia/anesthesia_protocols.dart';
import '../features/profile/user_profile.dart';
import '../features/reports/patient_lab_log.dart';

class DatabaseService {
  static const String speciesBoxName = 'species_vitals';
  static const String drugsBoxName = 'drug_reference';
  static const String labsBoxName = 'lab_reference';
  static const String pathologyBoxName = 'pathology_hub';
  static const String imagingBoxName = 'imaging_hub';
  static const String anatomyBoxName = 'anatomy_atlas';
  static const String ecgBoxName = 'ecg_library';
  static const String ophthalmicBoxName = 'ophthalmic_hub';
  static const String triageBoxName = 'triage_criteria';
  static const String videoBoxName = 'video_reference';
  static const String inventoryBoxName = 'inventory';
  static const String checklistBoxName = 'surgical_checklists';
  static const String profileBoxName = 'user_profile';
  static const String protocolsBoxName = 'anesthesia_protocols';
  static const String labLogBoxName = 'patient_lab_logs';

  static Future<void> init() async {
    await Hive.initFlutter();

    // Register Adapters
    Hive.registerAdapter(VitalRangeAdapter());
    Hive.registerAdapter(SpeciesVitalsAdapter());
    Hive.registerAdapter(DosageAdapter());
    Hive.registerAdapter(DrugReferenceAdapter());
    Hive.registerAdapter(LabRangeAdapter());
    Hive.registerAdapter(LabTestAdapter());
    Hive.registerAdapter(PathologyAdapter());
    Hive.registerAdapter(ImagingReferenceAdapter());
    Hive.registerAdapter(AnatomyReferenceAdapter());
    Hive.registerAdapter(EcgPatternAdapter());
    Hive.registerAdapter(OphthalmicReferenceAdapter());
    Hive.registerAdapter(TriageCriteriaAdapter());
    Hive.registerAdapter(VideoReferenceAdapter());
    Hive.registerAdapter(InventoryItemAdapter());
    Hive.registerAdapter(ChecklistItemAdapter());
    Hive.registerAdapter(SurgicalChecklistAdapter());
    Hive.registerAdapter(UserProfileAdapter());
    Hive.registerAdapter(AnesthesiaProtocolAdapter());
    Hive.registerAdapter(PatientLabLogAdapter());

    // Open Boxes
    final speciesBox = await Hive.openBox<SpeciesVitals>(speciesBoxName);
    final drugsBox = await Hive.openBox<DrugReference>(drugsBoxName);
    final labsBox = await Hive.openBox<LabTest>(labsBoxName);
    final pathologyBox = await Hive.openBox<Pathology>(pathologyBoxName);
    final imagingBox = await Hive.openBox<ImagingReference>(imagingBoxName);
    final anatomyBox = await Hive.openBox<AnatomyReference>(anatomyBoxName);
    final ecgBox = await Hive.openBox<EcgPattern>(ecgBoxName);
    final ophthalmicBox = await Hive.openBox<OphthalmicReference>(ophthalmicBoxName);
    final triageBox = await Hive.openBox<TriageCriteria>(triageBoxName);
    final videoBox = await Hive.openBox<VideoReference>(videoBoxName);
    await Hive.openBox<InventoryItem>(inventoryBoxName);
    final checklistBox = await Hive.openBox<SurgicalChecklist>(checklistBoxName);
    final profileBox = await Hive.openBox<UserProfile>(profileBoxName);
    final protocolsBox = await Hive.openBox<AnesthesiaProtocol>(protocolsBoxName);
    await Hive.openBox<PatientLabLog>(labLogBoxName);

    // Seed Data
    if (speciesBox.isEmpty) await speciesBox.addAll(initialVitalsData);
    if (drugsBox.isEmpty) await drugsBox.addAll(initialDrugData);
    if (labsBox.isEmpty) await labsBox.addAll(initialLabData);
    if (pathologyBox.isEmpty) await pathologyBox.addAll(initialPathologyData);
    if (imagingBox.isEmpty) await imagingBox.addAll(initialImagingData);
    if (anatomyBox.isEmpty) await anatomyBox.addAll(initialAnatomyData);
    if (ecgBox.isEmpty) await ecgBox.addAll(initialEcgData);
    if (ophthalmicBox.isEmpty) await ophthalmicBox.addAll(initialOphthalmicData);
    if (triageBox.isEmpty) await triageBox.addAll(initialTriageData);
    if (videoBox.isEmpty) await videoBox.addAll(initialVideoData);
    if (checklistBox.isEmpty) await checklistBox.addAll(initialChecklistData);
    if (profileBox.isEmpty) await profileBox.add(UserProfile());
    if (protocolsBox.isEmpty) await protocolsBox.addAll(initialProtocolData);
  }

  static Box<SpeciesVitals> getSpeciesBox() => Hive.box<SpeciesVitals>(speciesBoxName);
  static Box<DrugReference> getDrugsBox() => Hive.box<DrugReference>(drugsBoxName);
  static Box<LabTest> getLabsBox() => Hive.box<LabTest>(labsBoxName);
  static Box<Pathology> getPathologyBox() => Hive.box<Pathology>(pathologyBoxName);
  static Box<ImagingReference> getImagingBox() => Hive.box<ImagingReference>(imagingBoxName);
  static Box<AnatomyReference> getAnatomyBox() => Hive.box<AnatomyReference>(anatomyBoxName);
  static Box<EcgPattern> getEcgBox() => Hive.box<EcgPattern>(ecgBoxName);
  static Box<OphthalmicReference> getOphthalmicBox() => Hive.box<OphthalmicReference>(ophthalmicBoxName);
  static Box<TriageCriteria> getTriageBox() => Hive.box<TriageCriteria>(triageBoxName);
  static Box<VideoReference> getVideoBox() => Hive.box<VideoReference>(videoBoxName);
  static Box<InventoryItem> getInventoryBox() => Hive.box<InventoryItem>(inventoryBoxName);
  static Box<SurgicalChecklist> getChecklistBox() => Hive.box<SurgicalChecklist>(checklistBoxName);
  static Box<UserProfile> getProfileBox() => Hive.box<UserProfile>(profileBoxName);
  static Box<AnesthesiaProtocol> getProtocolsBox() => Hive.box<AnesthesiaProtocol>(protocolsBoxName);
  static Box<PatientLabLog> getLabLogBox() => Hive.box<PatientLabLog>(labLogBoxName);
}
