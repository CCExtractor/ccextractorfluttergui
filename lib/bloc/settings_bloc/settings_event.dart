part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class SettingsUpdatedEvent extends SettingsEvent {
  final SettingsModel settingsModel;

  SettingsUpdatedEvent(this.settingsModel);
  @override
  List<Object> get props => [settingsModel];
}

class ResetSettingsEvent extends SettingsEvent {
  @override
  List<Object> get props => [];
}

class GetSettingsEvent extends SettingsEvent {
  @override
  List<Object> get props => [];
}

class SaveSettingsEvent extends SettingsEvent {
  final SettingsModel settingsModel;

  SaveSettingsEvent(this.settingsModel);
  @override
  List<Object> get props => [settingsModel];
}

class CheckSettingsEvent extends SettingsEvent {
  @override
  List<Object> get props => [];
}
