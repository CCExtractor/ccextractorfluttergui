part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {}

class CurrentSettingsState extends SettingsState {
  final SettingsModel settingsModel;
  CurrentSettingsState(this.settingsModel);
  @override
  List<Object> get props => [settingsModel];
}

class SettingsErrorState extends SettingsState {
  final String message;

  SettingsErrorState(this.message);
  @override
  List<Object> get props => [message];
}

