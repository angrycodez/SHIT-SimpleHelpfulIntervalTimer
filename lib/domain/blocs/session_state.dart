part of 'session_cubit.dart';

class SessionState extends Equatable {
  final Session session;
  final bool hasChanges;
  const SessionState(this.session, {this.hasChanges=false});

  @override
  List<Object> get props => [session];

  SessionState copyWith({
    Session? session,
    bool? hasChanges,
  }) {
    return SessionState(
      session ?? this.session,
      hasChanges: hasChanges ?? this.hasChanges,
    );
  }
}
