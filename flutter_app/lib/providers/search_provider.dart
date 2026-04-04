import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../services/database_service.dart';

part 'search_provider.g.dart';

enum SearchResultType { species, drug, lab, pathology, imaging }

class SearchResult {
  final String title;
  final String subtitle;
  final SearchResultType type;
  final dynamic originalObject;

  SearchResult({
    required this.title,
    required this.subtitle,
    required this.type,
    required this.originalObject,
  });
}

@riverpod
class GlobalSearch extends _$GlobalSearch {
  @override
  List<SearchResult> build() => [];

  void search(String query) {
    if (query.isEmpty) {
      state = [];
      return;
    }

    final lowercaseQuery = query.toLowerCase();
    final List<SearchResult> results = [];

    // Search Species Vitals
    final speciesBox = DatabaseService.getSpeciesBox();
    for (var species in speciesBox.values) {
      if (species.name.toLowerCase().contains(lowercaseQuery) ||
          species.scientificName.toLowerCase().contains(lowercaseQuery)) {
        results.add(SearchResult(
          title: species.name,
          subtitle: species.scientificName,
          type: SearchResultType.species,
          originalObject: species,
        ));
      }
    }

    // Search Drugs
    final drugsBox = DatabaseService.getDrugsBox();
    for (var drug in drugsBox.values) {
      if (drug.name.toLowerCase().contains(lowercaseQuery) ||
          drug.category.toLowerCase().contains(lowercaseQuery)) {
        results.add(SearchResult(
          title: drug.name,
          subtitle: drug.category,
          type: SearchResultType.drug,
          originalObject: drug,
        ));
      }
    }

    // Search Labs
    final labsBox = DatabaseService.getLabsBox();
    for (var lab in labsBox.values) {
      if (lab.name.toLowerCase().contains(lowercaseQuery) ||
          lab.abbreviation.toLowerCase().contains(lowercaseQuery)) {
        results.add(SearchResult(
          title: '${lab.name} (${lab.abbreviation})',
          subtitle: lab.category,
          type: SearchResultType.lab,
          originalObject: lab,
        ));
      }
    }

    // Search Pathology
    final pathologyBox = DatabaseService.getPathologyBox();
    for (var path in pathologyBox.values) {
      if (path.name.toLowerCase().contains(lowercaseQuery) ||
          path.category.toLowerCase().contains(lowercaseQuery)) {
        results.add(SearchResult(
          title: path.name,
          subtitle: path.category,
          type: SearchResultType.pathology,
          originalObject: path,
        ));
      }
    }

    // Search Imaging
    final imagingBox = DatabaseService.getImagingBox();
    for (var img in imagingBox.values) {
      if (img.title.toLowerCase().contains(lowercaseQuery) ||
          img.category.toLowerCase().contains(lowercaseQuery)) {
        results.add(SearchResult(
          title: img.title,
          subtitle: img.category,
          type: SearchResultType.imaging,
          originalObject: img,
        ));
      }
    }

    state = results;
  }
}
