import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../services/smart_guide_service.dart';

class StoryModeButton extends StatefulWidget {
  final String placeId;
  final String placeName;
  final String category;
  final String? description;

  const StoryModeButton({
    super.key,
    required this.placeId,
    required this.placeName,
    required this.category,
    this.description,
  });

  @override
  State<StoryModeButton> createState() => _StoryModeButtonState();
}

class _StoryModeButtonState extends State<StoryModeButton> {
  final _smartGuide = SmartGuideService();
  final FlutterTts _tts = FlutterTts();

  bool _loading = false;
  bool _speaking = false;
  String? _story;
  String _modelBadge = '';

  @override
  void initState() {
    super.initState();
    _tts.setLanguage('en-IN');
    _tts.setSpeechRate(0.42);
    _tts.setCompletionHandler(() {
      if (mounted) setState(() => _speaking = false);
    });
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }

  Future<void> _onTap() async {
    if (_speaking) {
      await _tts.stop();
      setState(() => _speaking = false);
      return;
    }

    setState(() => _loading = true);

    _story ??= await _smartGuide.getSummary(
      placeId: widget.placeId,
      placeName: widget.placeName,
      category: widget.category,
      description: widget.description,
    );

    setState(() {
      _loading = false;
      _speaking = true;
      _modelBadge = _smartGuide.lastUsedModel;
    });

    await _tts.speak(_story!);
  }

  @override
  Widget build(BuildContext context) {
    final isGemma = _modelBadge.contains('Gemma');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: _loading ? null : _onTap,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: _speaking ? Colors.red : Colors.deepPurple,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurple.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    )
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_loading)
                      const SizedBox(
                        width: 16, height: 16,
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2),
                      )
                    else
                      Icon(
                        _speaking
                            ? Icons.stop_rounded
                            : Icons.auto_stories_rounded,
                        color: Colors.white, size: 18,
                      ),
                    const SizedBox(width: 8),
                    Text(
                      _speaking ? 'Stop' : 'Story Mode',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),

            if (_modelBadge.isNotEmpty) ...[
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isGemma
                      ? Colors.green.shade50
                      : Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isGemma
                        ? Colors.green.shade300
                        : Colors.blue.shade300,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _modelBadge.contains('Offline')
                          ? Icons.wifi_off_rounded
                          : Icons.cloud_rounded,
                      size: 12,
                      color: isGemma
                          ? Colors.green.shade700
                          : Colors.blue.shade700,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _modelBadge,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: isGemma
                            ? Colors.green.shade700
                            : Colors.blue.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),

        if (_story != null && !_speaking) ...[
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade50,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.deepPurple.shade100),
            ),
            child: Text(
              _story!,
              style: const TextStyle(fontSize: 13, height: 1.6),
            ),
          ),
        ],
      ],
    );
  }
}
