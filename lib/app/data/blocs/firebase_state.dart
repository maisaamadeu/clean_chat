import 'package:clean_chat/app/data/models/contact_model.dart';

abstract class FirebaseState {
  final List<ContactModel?> contacts;

  FirebaseState({required this.contacts});
}

class FirebaseInitialState extends FirebaseState {
  FirebaseInitialState()
      : super(
          contacts: [],
        );
}

class FirebaseLoadingState extends FirebaseState {
  FirebaseLoadingState()
      : super(
          contacts: [],
        );
}

class FirebaseLoadedState extends FirebaseState {
  FirebaseLoadedState({required List<ContactModel?> contacts})
      : super(
          contacts: contacts,
        );
}

class FirebaseErrorState extends FirebaseState {
  final Exception exception;
  FirebaseErrorState({required this.exception})
      : super(
          contacts: [],
        );
}
