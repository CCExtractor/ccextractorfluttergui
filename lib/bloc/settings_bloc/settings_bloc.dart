import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:ccxgui/models/settings_model.dart';
import 'package:ccxgui/repositories/settings_repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository _settingsRepository;
  SettingsBloc(this._settingsRepository) : super(SettingsInitial()) {
    on<CheckSettingsEvent>(_onCheckSettings);
    on<GetSettingsEvent>(_onGetSettings);
    on<ResetSettingsEvent>(_onResetSettings);
    on<SettingsUpdatedEvent>(_onSettingsUpdated);
    on<SaveSettingsEvent>(_onSaveSettings);
  }

  Future<void> _onCheckSettings(
      CheckSettingsEvent event, Emitter<SettingsState> emit) async {
    try {
      bool settingsStatus = await _settingsRepository.checkValidJSON();
      if (settingsStatus) {
        add(GetSettingsEvent());
      } else {
        // Config was invalid but has been rewritten with defaults, load it
        add(GetSettingsEvent());
      }
    } catch (e) {
      emit(SettingsErrorState('Failed to initialize settings: $e'));
    }
  }

  Future<void> _onGetSettings(
      GetSettingsEvent event, Emitter<SettingsState> emit) async {
    try {
      final settings = await _settingsRepository.getSettings();
      emit(CurrentSettingsState(settings));
    } catch (e) {
      emit(SettingsErrorState('Error getting settings.'));
    }
  }

  Future<void> _onResetSettings(
      ResetSettingsEvent event, Emitter<SettingsState> emit) async {
    await _settingsRepository.resetSettings();
    final settings = await _settingsRepository.getSettings();
    emit(CurrentSettingsState(settings));
  }

  Future<void> _onSettingsUpdated(
      SettingsUpdatedEvent event, Emitter<SettingsState> emit) async {
    emit(CurrentSettingsState(event.settingsModel));
    add(SaveSettingsEvent(event.settingsModel));
  }

  Future<void> _onSaveSettings(
      SaveSettingsEvent event, Emitter<SettingsState> emit) async {
    if (await _settingsRepository.checkValidJSON()) {
      try {
        await _settingsRepository.saveSettings(event.settingsModel);
        final settings = await _settingsRepository.getSettings();
        emit(CurrentSettingsState(settings));
      } catch (e) {
        emit(SettingsErrorState('Error saving settings.'));
      }
    } else {
      emit(SettingsErrorState('Corrupted config.json detected, rewriting.'));
      final settings = await _settingsRepository.getSettings();
      emit(CurrentSettingsState(settings));
    }
  }
}
