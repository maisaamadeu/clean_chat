import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class MessageBloc {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late StreamSubscription<QuerySnapshot> _subscription;

  final _messageStreamController = StreamController<List<String>>();
  Stream<List<String>> get messageStream => _messageStreamController.stream;

  MessageBloc() {
    _subscription = _firestore
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .listen((snapshot) {
      final messages = snapshot.docs
          .map((doc) => (doc.data() as Map<String, dynamic>)['text'] as String)
          .toList();

      _messageStreamController.add(messages);
    });
  }

  void dispose() {
    _subscription.cancel();
    _messageStreamController.close();
  }
}
