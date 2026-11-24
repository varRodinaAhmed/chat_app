import 'package:flutter/material.dart';

class CallTile extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String time;
  final bool isAnswered;
  final VoidCallback? onCall;
  final VoidCallback? onVideoCall;

  const CallTile({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.time,
    required this.isAnswered,
    this.onCall,
    this.onVideoCall,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = isAnswered ? const Color(0xFF0F6E56) : Colors.red;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          CircleAvatar(radius: 24, backgroundImage: NetworkImage(imageUrl)),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      isAnswered ? Icons.call_received : Icons.call_missed,
                      size: 14,
                      color: statusColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: onCall,
            icon: Icon(Icons.call_outlined, color: Colors.grey.shade400),
          ),
          IconButton(
            onPressed: onVideoCall,
            icon: Icon(Icons.videocam_outlined, color: Colors.grey.shade400),
          ),
        ],
      ),
    );
  }
}
