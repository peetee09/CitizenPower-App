import 'package:flutter/material.dart';

class WebFallbackWidget extends StatelessWidget {
  final String featureName;
  
  const WebFallbackWidget({super.key, required this.featureName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.info, color: Colors.orange),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              '$featureName is optimized for mobile devices. Some features may be limited on web.',
              style: const TextStyle(color: Colors.orange[800]),
            ),
          ),
        ],
      ),
    );
  }
}
