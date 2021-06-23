// Dart imports:
import 'dart:async';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:ccxgui/models/settings_model.dart';
import 'package:ccxgui/repositories/settings_repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository _settingsRepository;
  SettingsBloc(this._settingsRepository) : super(SettingsInitial());

  @override
  Stream<SettingsState> mapEventToState(
    SettingsEvent event,
  ) async* {
    if (event is CheckSettingsEvent) {
      bool settingsStatus = await _settingsRepository.checkValidJSON();
      if (settingsStatus) {
        add(GetSettingsEvent());
      } else {
        yield SettingsErrorState("Couldn't parse json file");
      }
    }
    if (event is GetSettingsEvent) {
      try {
        final _settings = await _settingsRepository.getSettings();
        yield CurrentSettingsState(_settings);
      } catch (e) {
        yield SettingsErrorState('Error getting settings.');
      }
    }

    if (event is SettingsUpdatedEvent) {
      yield CurrentSettingsState(event.settingsModel);
    }
    if (event is SaveSettingsEvent) {
      if (await _settingsRepository.checkValidJSON()) {
        try {
          await _settingsRepository.saveSettings(event.settingsModel);
          final _settings = await _settingsRepository.getSettings();
          yield CurrentSettingsState(_settings);
        } catch (e) {
          yield SettingsErrorState('Error saving settings.');
        }
      } else {
        // only possible when app is open and use manually messes up config.json.
        yield SettingsErrorState('Corrupted config.json detected, rewriting.');
        final _settings = await _settingsRepository.getSettings();
        yield CurrentSettingsState(_settings);
      }
    }
  }
}
