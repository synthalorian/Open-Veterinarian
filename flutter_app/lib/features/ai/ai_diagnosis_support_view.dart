import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/search_provider.dart';
import '../ui/glow_card.dart';

class AiDiagnosisSupportView extends ConsumerStatefulWidget {
  const AiDiagnosisSupportView({super.key});

  @override
  ConsumerState<AiDiagnosisSupportView> createState() => _AiDiagnosisSupportViewState();
}

class _AiDiagnosisSupportViewState extends ConsumerState<AiDiagnosisSupportView> {
  final TextEditingController _queryController = TextEditingController();
  String _response = '';
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI DIAGNOSIS SUPPORT')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Enter clinical signs or lab results for synthclaw synthesis.',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _queryController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'e.g. 10yo Canine, PU/PD, CREA 2.5, USG 1.012...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.psychology),
                label: const Text('SYNTHESIZE'),
                onPressed: _loading ? null : _synthesize,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.purpleAccent, foregroundColor: Colors.black),
              ),
            ),
            const SizedBox(height: 24),
            if (_loading) const CircularProgressIndicator(color: Colors.purpleAccent),
            if (_response.isNotEmpty)
              Expanded(
                child: SingleChildScrollView(
                  child: GlowCard(
                    glowColor: Colors.purpleAccent,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        _response,
                        style: const TextStyle(fontSize: 14, height: 1.5),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _synthesize() async {
    setState(() {
      _loading = true;
      _response = '';
    });

    // In a real implementation, this would call a local LLM or protected API.
    // For now, we simulate the synthesis engine response based on common patterns.
    await Future.delayed(const Duration(seconds: 2));

    final query = _queryController.text.toLowerCase();
    String result = '🎹🦞 SYNTHESIS COMPLETE:\n\n';

    if (query.contains('pu/pd') || query.contains('crea')) {
      result += 'Potential differential: Chronic Kidney Disease (CKD).\nRecommended Actions:\n- Verify Blood Pressure\n- Perform full Urinalysis (USG/UPC)\n- Check SDMA levels.';
    } else if (query.contains('glucose') || query.contains('hyperglycemia')) {
      result += 'Potential differential: Diabetes Mellitus.\nRecommended Actions:\n- Check Fructosamine\n- Monitor for Ketonuria\n- Evaluate SRR.';
    } else {
      result += 'Patterns unclear. Please provide more specific lab results or clinical signs for a deeper scan of the grid.';
    }

    setState(() {
      _loading = false;
      _response = result;
    });
  }
}
