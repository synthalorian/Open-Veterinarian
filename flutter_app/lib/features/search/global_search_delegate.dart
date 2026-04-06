import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/search_provider.dart';

class GlobalSearchDelegate extends SearchDelegate<SearchResult?> {
  final WidgetRef ref;

  GlobalSearchDelegate(this.ref);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
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
  Widget buildResults(BuildContext context) {
    ref.read(globalSearchProvider.notifier).search(query);
    final results = ref.watch(globalSearchProvider);

    if (results.isEmpty) {
      return const Center(child: Text('No results found.'));
    }

    return _buildResultsList(results);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    ref.read(globalSearchProvider.notifier).search(query);
    final results = ref.watch(globalSearchProvider);

    return _buildResultsList(results);
  }

  Widget _buildResultsList(List<SearchResult> results) {
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final result = results[index];
        IconData icon;
        switch (result.type) {
          case SearchResultType.species:
            icon = Icons.pets;
          case SearchResultType.drug:
            icon = Icons.medication;
          case SearchResultType.lab:
            icon = Icons.science;
          case SearchResultType.pathology:
            icon = Icons.biotech;
          case SearchResultType.imaging:
            icon = Icons.image_search;
        }

        return ListTile(
          leading: Icon(icon, color: Colors.cyanAccent),
          title: Text(result.title),
          subtitle: Text(result.subtitle),
          onTap: () {
            // Future: Navigate to detail view
            close(context, result);
          },
        );
      },
    );
  }
}
