import 'package:flutter/material.dart';
import 'package:inogpt/constants/constants.dart';
import 'package:inogpt/providers/chat_provider.dart';
import 'package:inogpt/services/assets_manager.dart';
import 'package:inogpt/widgets/text_widget.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:provider/provider.dart';

class ChatWidget extends StatefulWidget {
  final String msg;
  final int chatIndex;

  const ChatWidget({
    super.key,
    required this.msg,
    required this.chatIndex,
  });

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final chatProvider = Provider.of<ChatProvider>(context);
    return Column(
      children: [
        Material(
          color: widget.chatIndex == 0 ? scaffoldBackgroundColor : cardColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  widget.chatIndex == 0
                      ? AssetsManager.userImage
                      : AssetsManager.botImage,
                  width: 30,
                  height: 30,
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: widget.chatIndex == 0
                      ? TextWidget(
                          label: widget.msg,
                        )
                      : DefaultTextStyle(
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                          child: AnimatedTextKit(
                            isRepeatingAnimation: false,
                            repeatForever: false,
                            // displayFullTextOnTap: true,
                            totalRepeatCount: 0,
                            onFinished: () {
                              chatProvider.finishingText();
                            },
                            animatedTexts: [
                              TyperAnimatedText(
                                widget.msg.trim(),
                                speed: const Duration(milliseconds:30),
                              ),
                            ],
                          ),
                        ),
                ),
                widget.chatIndex == 0
                    ? const SizedBox.shrink()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.thumb_up_alt_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.thumb_down_alt_outlined,
                            color: Colors.white,
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
