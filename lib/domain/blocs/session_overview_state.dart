part of 'session_overview_cubit.dart';

class SessionOverviewState extends Equatable {
  final List<SessionCubit> sessions;
  const SessionOverviewState(this.sessions);

  @override
  List<Object> get props => [sessions];

  SessionOverviewState copyWith({List<SessionCubit>? sessions}){
    return SessionOverviewState(sessions ?? this.sessions);
  }
}
