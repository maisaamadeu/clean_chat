import 'package:clean_chat/app/data/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({super.key, required this.message});

  final MessageModel message;
  final String userId = '1';

  @override
  Widget build(BuildContext context) {
    final bool isUser = message.userId == userId;
    return Container(
      margin: const EdgeInsets.only(
        bottom: 15,
      ),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment:
                isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.sizeOf(context).width * 0.7,
                ),
                decoration: BoxDecoration(
                  color: isUser ? Colors.deepPurple : Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: const Radius.circular(15),
                    bottomLeft: const Radius.circular(15),
                    bottomRight: Radius.circular(isUser ? 0 : 15),
                    topLeft: Radius.circular(isUser ? 15 : 0),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  crossAxisAlignment: isUser
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    message.imageUrl != null && message.imageUrl != ''
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Positioned(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                                Image.network(message.imageUrl!),
                              ],
                            ),
                          )
                        : Container(
                            width: 0,
                          ),
                    message.message != null && message.message != ''
                        ? Text(
                            message.message.toString(),
                            style: GoogleFonts.inter(
                              color: isUser ? Colors.white : Colors.black,
                            ),
                          )
                        : Container(
                            width: 0,
                          ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    '0' + DateFormat.jm().format(message.date).toString(),
                    style: GoogleFonts.inter(
                      color: const Color(0xFFA6A6A6),
                      fontSize: 12,
                    ),
                  ),
                  isUser
                      ? Container(
                          margin: const EdgeInsets.only(
                            left: 5,
                          ),
                          child: Icon(
                            Icons.done_all_rounded,
                            size: 15,
                            color: message.wasViewed
                                ? Colors.deepPurple
                                : const Color(0xFFA6A6A6),
                          ),
                        )
                      : Container(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
