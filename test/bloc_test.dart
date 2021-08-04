import 'package:bloc_test/bloc_test.dart';
import 'package:ccxgui/bloc/settings_bloc/settings_bloc.dart';
import 'package:ccxgui/models/settings_model.dart';
import 'package:ccxgui/repositories/settings_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CounterBloc', () {
    SettingsRepository _settingsRepository = SettingsRepository();
    SettingsModel settingsModel = SettingsModel();

    blocTest<SettingsBloc, SettingsState>(
      'emits [] when nothing is added',
      build: () => SettingsBloc(_settingsRepository),
      expect: () => [],
    );

    blocTest<SettingsBloc, SettingsState>(
      'emit default settings model when nothing is changed',
      build: () => SettingsBloc(_settingsRepository),
      act: (bloc) => bloc.add(SettingsUpdatedEvent(settingsModel)),
      expect: () => [CurrentSettingsState(settingsModel)],
    );
    blocTest<SettingsBloc, SettingsState>(
        'emits new settings model, settings saved correctly and getParamsList has the new setting',
        build: () => SettingsBloc(_settingsRepository),
        act: (bloc) {
          settingsModel.append = true;
          settingsModel.autoprogram = false;
          bloc.add(SettingsUpdatedEvent(settingsModel));
        },
        expect: () => [CurrentSettingsState(settingsModel)],
        verify: (_) {
          expect(
              _settingsRepository
                  .getParamsList(settingsModel)
                  .contains('--append'),
              true);
          expect(
              _settingsRepository
                  .getParamsList(settingsModel)
                  .contains('-autoprogram'),
              false);
          expect(
              _settingsRepository
                  .getParamsList(settingsModel)
                  .contains('some_random_nonexistent_param'),
              false);
        });
  });
}
