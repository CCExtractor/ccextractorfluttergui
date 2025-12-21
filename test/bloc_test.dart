import 'package:bloc_test/bloc_test.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ccxgui/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:ccxgui/bloc/process_bloc/process_bloc.dart';
import 'package:ccxgui/bloc/settings_bloc/settings_bloc.dart';
import 'package:ccxgui/models/settings_model.dart';
import 'package:ccxgui/repositories/settings_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SettingsBloc', () {
    late SettingsRepository settingsRepository;
    late SettingsModel settingsModel;

    setUp(() {
      settingsRepository = SettingsRepository();
      settingsModel = SettingsModel();
    });

    blocTest<SettingsBloc, SettingsState>(
      'emits [] when nothing is added',
      build: () => SettingsBloc(settingsRepository),
      expect: () => [],
    );

    blocTest<SettingsBloc, SettingsState>(
      'emit default settings model when nothing is changed',
      build: () => SettingsBloc(settingsRepository),
      act: (bloc) => bloc.add(SettingsUpdatedEvent(settingsModel)),
      // we don't care what's here so no expect. This just sets up config.json
      // properly if it is not created yet, example on GH actions
    );

    blocTest<SettingsBloc, SettingsState>(
      'emits new settings model, settings saved correctly and getParamsList has the new setting',
      build: () => SettingsBloc(settingsRepository),
      act: (bloc) {
        settingsModel.append = true;
        settingsModel.autoprogram = false;
        bloc.add(SettingsUpdatedEvent(settingsModel));
      },
      expect: () => [CurrentSettingsState(settingsModel)],
      verify: (_) {
        expect(
          settingsRepository.getParamsList(settingsModel).contains('--append'),
          true,
        );
        expect(
          settingsRepository
              .getParamsList(settingsModel)
              .contains('--autoprogram'),
          false,
        );
        expect(
          settingsRepository
              .getParamsList(settingsModel)
              .contains('some_random_nonexistent_param'),
          false,
        );
      },
    );
  });

  group('DashboardBloc', () {
    late DashboardBloc dashboardBloc;
    final testFile1 = XFile('/path/to/video1.mp4');
    final testFile2 = XFile('/path/to/video2.mkv');

    setUp(() {
      dashboardBloc = DashboardBloc();
    });

    tearDown(() {
      dashboardBloc.close();
    });

    test('initial state is empty', () {
      expect(dashboardBloc.state.files, isEmpty);
      expect(dashboardBloc.state.alreadyPresent, false);
    });

    blocTest<DashboardBloc, DashboardState>(
      'emits state with file when NewFileAdded is added',
      build: () => DashboardBloc(),
      act: (bloc) => bloc.add(NewFileAdded([testFile1])),
      expect: () => [
        DashboardState(files: [testFile1], alreadyPresent: false),
      ],
    );

    blocTest<DashboardBloc, DashboardState>(
      'emits state with multiple files when NewFileAdded is added twice',
      build: () => DashboardBloc(),
      act: (bloc) {
        bloc.add(NewFileAdded([testFile1]));
        bloc.add(NewFileAdded([testFile2]));
      },
      expect: () => [
        DashboardState(files: [testFile1], alreadyPresent: false),
        DashboardState(files: [testFile1, testFile2], alreadyPresent: false),
      ],
    );

    blocTest<DashboardBloc, DashboardState>(
      'emits state with alreadyPresent=true when duplicate file is added',
      build: () => DashboardBloc(),
      act: (bloc) {
        bloc.add(NewFileAdded([testFile1]));
        bloc.add(NewFileAdded([testFile1]));
      },
      expect: () => [
        DashboardState(files: [testFile1], alreadyPresent: false),
        DashboardState(files: [testFile1], alreadyPresent: true),
      ],
    );

    blocTest<DashboardBloc, DashboardState>(
      'emits empty state when RemoveAllFiles is added',
      build: () => DashboardBloc(),
      seed: () =>
          DashboardState(files: [testFile1, testFile2], alreadyPresent: false),
      act: (bloc) => bloc.add(RemoveAllFiles()),
      expect: () => [
        DashboardState(files: [], alreadyPresent: false),
      ],
    );

    blocTest<DashboardBloc, DashboardState>(
      'emits state without removed file when FileRemoved is added',
      build: () => DashboardBloc(),
      seed: () =>
          DashboardState(files: [testFile1, testFile2], alreadyPresent: false),
      act: (bloc) => bloc.add(FileRemoved(testFile1)),
      expect: () => [
        DashboardState(files: [testFile2], alreadyPresent: false),
      ],
    );
  });

  group('ProcessBloc', () {
    late ProcessBloc processBloc;
    final testFile = XFile('/path/to/video.mp4');

    setUp(() {
      processBloc = ProcessBloc();
    });

    tearDown(() {
      processBloc.close();
    });

    test('initial state has empty lists and started=false', () {
      expect(processBloc.state.originalList, isEmpty);
      expect(processBloc.state.queue, isEmpty);
      expect(processBloc.state.processed, isEmpty);
      expect(processBloc.state.started, false);
      expect(processBloc.state.progress, '0');
      expect(processBloc.state.current, isNull);
    });

    blocTest<ProcessBloc, ProcessState>(
      'emits state with files when ProcessFilesSubmitted is added',
      build: () => ProcessBloc(),
      act: (bloc) => bloc.add(ProcessFilesSubmitted([testFile])),
      expect: () => [
        isA<ProcessState>()
            .having((s) => s.originalList, 'originalList', [testFile]).having(
                (s) => s.queue, 'queue', [testFile]),
      ],
    );

    blocTest<ProcessBloc, ProcessState>(
      'emits empty state when ProcessRemoveAll is added',
      build: () => ProcessBloc(),
      seed: () => ProcessState(
        originalList: [testFile],
        queue: [testFile],
        processed: [],
        log: [],
        videoDetails: [],
        started: false,
        progress: '0',
        current: null,
        version: '0',
      ),
      act: (bloc) => bloc.add(ProcessRemoveAll()),
      expect: () => [
        isA<ProcessState>()
            .having((s) => s.originalList, 'originalList', isEmpty)
            .having((s) => s.queue, 'queue', isEmpty)
            .having((s) => s.started, 'started', false),
      ],
    );

    blocTest<ProcessBloc, ProcessState>(
      'emits state with exitCode when ProcessError is added',
      build: () => ProcessBloc(),
      act: (bloc) => bloc.add(ProcessError(10)),
      expect: () => [
        isA<ProcessState>().having((s) => s.exitCode, 'exitCode', 10),
      ],
    );

    blocTest<ProcessBloc, ProcessState>(
      'emits state with null exitCode when ResetProcessError is added',
      build: () => ProcessBloc(),
      seed: () => ProcessState(
        originalList: [],
        queue: [],
        processed: [],
        log: [],
        videoDetails: [],
        started: false,
        progress: '0',
        current: null,
        version: '0',
        exitCode: 10,
      ),
      act: (bloc) => bloc.add(ResetProcessError()),
      expect: () => [
        isA<ProcessState>().having((s) => s.exitCode, 'exitCode', isNull),
      ],
    );
  });
}
