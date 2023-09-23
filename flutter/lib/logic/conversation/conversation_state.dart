part of 'conversation_cubit.dart';

@immutable
class ConversationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ConversationInitial extends ConversationState {}

class ConversationLoadingState extends ConversationState {}
class ConversationEmptyState extends ConversationState {}

class ConversationSuccessState extends ConversationState {
  final String state;

  ConversationSuccessState(this.state);

  @override
  List<Object?> get props => [];
}

class ConversationErrorState extends ConversationState {}
