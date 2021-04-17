import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ccxgui/main.dart';
import 'package:ccxgui/models/settings_model.dart';
import 'package:ccxgui/repositories/settings_repository.dart';
import 'package:ccxgui/utils/constants.dart';
import 'package:equatable/equatable.dart';

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
      if (await _settingsRepository.checkValidJSON()) {
        await storage.ready;
        if (!outputFormats.contains(await storage.getItem("output_format")) ||
            await storage.getItem("output_file_name") is! String ||
            await storage.getItem("append") is! bool ||
            await storage.getItem("autoprogram") is! bool) {
          yield SettingsErrorState(
              "config.json corrupted, switching to default settings");
        }
      } else {
        yield SettingsErrorState("Error parsing json file");
      }
      add(GetSettingsEvent());
    }
    if (event is GetSettingsEvent) {
      try {
        final _settings = await _settingsRepository.getSettings();
        yield CurrentSettingsState(_settings);
      } catch (e) {
        print(e);
        yield SettingsErrorState("Error getting settings.\n Logs: $e");
      }
    }
    // This is just to show UI updates before applying settings.
    // An alternative to this would be using setState but fuck you setState
    if (event is SettingsUpdatedEvent) {
      yield CurrentSettingsState(event.settingsModel);
    }
    if (event is SaveSettingsEvent) {
      try {
        await _settingsRepository.saveSettings(event.settingsModel);
        yield CurrentSettingsState(event.settingsModel);
      } catch (e) {
        print(e);
        yield SettingsErrorState("Error saving settings.\n Logs: $e");
      }
    }
  }
}
