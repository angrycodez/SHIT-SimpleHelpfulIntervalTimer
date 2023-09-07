part of 'session_overview_cubit.dart';

class SessionOverviewState extends Equatable {
  const SessionOverviewState();

  @override
  List<Object> get props => [];
}
class SessionOverviewStateInitialized extends SessionOverviewState {
  final List<SessionCubit> sessions;
  const SessionOverviewStateInitialized(this.sessions);

  @override
  List<Object> get props => [sessions];

  SessionOverviewStateInitialized copyWith({List<SessionCubit>? sessions}){
    return SessionOverviewStateInitialized(sessions ?? this.sessions);
  }
}
