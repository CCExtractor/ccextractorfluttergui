import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

import 'package:ccxgui/models/settings_model.dart';
import 'package:ccxgui/repositories/settings_repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository _settingsRepository;
  SettingsBloc(this._settingsRepository) : super(SettingsInitial()) {
    on<SettingsEvent>(_onEvent, transformer: sequential());
  }
  FutureOr<void> _onEvent(
      SettingsEvent event, Emitter<SettingsState> emit) async {
    // TODO: logic goes here...
    if (event is CheckSettingsEvent) {
      bool settingsStatus = await _settingsRepository.checkValidJSON();
      if (settingsStatus) {
        add(GetSettingsEvent());
      } else {
        emit(SettingsErrorState("Couldn't parse json file"));
      }
    } else if (event is GetSettingsEvent) {
      try {
        final _settings = await _settingsRepository.getSettings();
        emit(CurrentSettingsState(_settings));
      } catch (e) {
        emit(SettingsErrorState('Error getting settings.'));
      }
    } else if (event is ResetSettingsEvent) {
      await _settingsRepository.resetSettings();
      final _settings = await _settingsRepository.getSettings();

      emit(CurrentSettingsState(_settings));
    } else if (event is SettingsUpdatedEvent) {
      emit(CurrentSettingsState(event.settingsModel));
      add(SaveSettingsEvent(event.settingsModel));
      // improve
    } else if (event is SaveSettingsEvent) {
      if (await _settingsRepository.checkValidJSON()) {
        try {
          await _settingsRepository.saveSettings(event.settingsModel);
          final _settings = await _settingsRepository.getSettings();
          emit(CurrentSettingsState(_settings));
        } catch (e) {
          emit(SettingsErrorState('Error saving settings.'));
        }
      } else {
        // only possible when app is open and use manually messes up config.json.
        emit(SettingsErrorState('Corrupted config.json detected, rewriting.'));
        final _settings = await _settingsRepository.getSettings();
        emit(CurrentSettingsState(_settings));
      }
    }
  }
}
