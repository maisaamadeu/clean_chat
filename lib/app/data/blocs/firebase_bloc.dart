import 'package:clean_chat/app/data/blocs/firebase_event.dart';
import 'package:clean_chat/app/data/blocs/firebase_state.dart';
import 'package:clean_chat/app/data/models/contact_model.dart';
import 'package:clean_chat/app/data/repositories/firebase_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirebaseBloc extends Bloc<FirebaseEvent, FirebaseState> {
  final FirebaseRepository _repository = FirebaseRepository();

  FirebaseBloc() : super(FirebaseInitialState()) {
    on(_mapEventToState);
  }

  void _mapEventToState(FirebaseEvent event, Emitter emit) async {
    List<ContactModel?> contacts = [];

    emit(FirebaseLoadingState());

    if (event is GetContacts) {
      contacts = await _repository.getContacts();
    }

    emit(FirebaseLoadedState(contacts: contacts));
  }
}
