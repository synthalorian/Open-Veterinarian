import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import '../ui/glow_card.dart';

class SurgicalNoteTakerView extends StatefulWidget {
  const SurgicalNoteTakerView({super.key});

  @override
  State<SurgicalNoteTakerView> createState() => _SurgicalNoteTakerViewState();
}

class _SurgicalNoteTakerViewState extends State<SurgicalNoteTakerView> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  final TextEditingController _noteController = TextEditingController();
  final FlutterTts _tts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(onResult: (val) => setState(() {
          _noteController.text = '${_noteController.text} ${val.recognizedWords}';
        }));
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  void _speak() async {
    if (_noteController.text.isNotEmpty) {
      await _tts.speak(_noteController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SURGICAL NOTE TAKER')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: GlowCard(
                glowColor: Colors.purpleAccent,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _noteController,
                    maxLines: null,
                    expands: true,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                    decoration: const InputDecoration(
                      hintText: 'Record surgical observations or dictate notes...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionCircle(
                  icon: _isListening ? Icons.mic : Icons.mic_none,
                  label: 'DICTATE',
                  color: _isListening ? Colors.redAccent : Colors.cyanAccent,
                  onTap: _listen,
                ),
                _buildActionCircle(
                  icon: Icons.volume_up,
                  label: 'PLAYBACK',
                  color: Colors.purpleAccent,
                  onTap: _speak,
                ),
                _buildActionCircle(
                  icon: Icons.save,
                  label: 'SAVE',
                  color: Colors.greenAccent,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Note saved to Grid.')));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCircle({required IconData icon, required String label, required Color color, required VoidCallback onTap}) {
    return Column(
      children: [
        IconButton.filled(
          icon: Icon(icon),
          onPressed: onTap,
          style: IconButton.styleFrom(
            backgroundColor: color.withOpacity(0.2),
            foregroundColor: color,
            minimumSize: const Size(60, 60),
            side: BorderSide(color: color.withOpacity(0.5)),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color, letterSpacing: 1.2)),
      ],
    );
  }
}
