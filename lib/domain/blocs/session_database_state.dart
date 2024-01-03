part of 'session_database_cubit.dart';

class SessionDatabaseState extends Equatable {
  final SessionDatabase database;
  const SessionDatabaseState(this.database);

  @override
  List<Object?> get props => [database];
}
