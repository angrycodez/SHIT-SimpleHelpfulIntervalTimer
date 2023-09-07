part of 'session_overview_cubit.dart';

class SessionOverviewState extends Equatable {
  final List<Session> sessions;
  const SessionOverviewState(this.sessions);

  @override
  List<Object> get props => [sessions];

  SessionOverviewState copyWith({List<Session>? sessions}){
    return SessionOverviewState(sessions ?? this.sessions);
  }
}
