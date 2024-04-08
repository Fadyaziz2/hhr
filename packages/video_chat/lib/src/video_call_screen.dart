import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:video_chat/const/app_const.dart';

class VideoCallScreen extends StatefulWidget {
  final String channelId;
  const VideoCallScreen({
    Key? key,
    required this.channelId,
  }) : super(key: key);

  @override
  VideoCallScreenState createState() => VideoCallScreenState();
}

class VideoCallScreenState extends State<VideoCallScreen> {
  AgoraClient? client;
  String baseUrl = 'https://whatsapp-clone-rrr.herokuapp.com';

  @override
  void initState() {
    super.initState();
    client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: AppConst.appId,
        channelName: widget.channelId,
        tokenUrl: baseUrl,
      ),
    );
    initAgora();
  }

  void initAgora() async {
    await client!.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: client == null
          ? const Center(child: CircularProgressIndicator(),)
          : SafeArea(
              child: Stack(
                children: [
                  AgoraVideoViewer(client: client!),
                  AgoraVideoButtons(
                    client: client!,
                    disconnectButtonChild: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle
                      ),
                      child: IconButton(
                        color: Colors.red,
                        onPressed: () async {
                          await client!.engine.leaveChannel().then((_){
                            Navigator.pop(context,false);
                          });
                        },
                        icon: const Icon(Icons.call_end),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
