import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_interval_timer/domain/blocs/blocs.dart';

part 'sounds_edit_state.dart';

class SoundsEditCubit extends Cubit<SoundsEditState> {
  final SessionDatabaseCubit _databaseCubit;
  SoundsEditCubit(this._databaseCubit) : super(const SoundsEditState());
}
