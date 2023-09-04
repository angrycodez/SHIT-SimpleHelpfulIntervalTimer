part of 'session_overview_cubit.dart';

class SessionOverviewState extends Equatable {
  final List<Session> sessions;
  const SessionOverviewState(this.sessions);

  @override
  List<Object> get props => [sessions];
}
