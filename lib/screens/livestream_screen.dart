import 'package:flutter/material.dart';
import '../core/webrtc/webrtc_client.dart';
import '../core/widgets/safe_wrapper.dart';

class LiveStreamScreen extends StatefulWidget {
  const LiveStreamScreen({super.key, required this.courseId});
  final String courseId;

  @override
  State<LiveStreamScreen> createState() => _LiveStreamScreenState();
}

class _LiveStreamScreenState extends State<LiveStreamScreen> {
  final webRtc = WebRTCClient();
  bool started = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Live Stream - ${widget.courseId}')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SafeRow(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: started
                        ? null
                        : () async {
                            await webRtc.startLocal(video: true, audio: true);
                            setState(() => started = true);
                          },
                    child: const Text('Start (local)'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: !started
                        ? null
                        : () {
                            webRtc.stopLocal();
                            setState(() => started = false);
                          },
                    child: const Text('End'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                color: Colors.black12,
                alignment: Alignment.center,
                child: Text(started ? 'Local stream started (demo)' : 'Not streaming'),
              ),
            )
          ],
        ),
      ),
    );
  }
}


