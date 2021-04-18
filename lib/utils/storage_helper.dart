import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart' show ValueNotifier;
import 'package:path_provider/path_provider.dart';

/// Creates instance of a local storage. Key is used as a filename
class LocalStorage {
  Stream<Map<String, dynamic>> get stream => _dir.stream;
  Map<String, dynamic>? _initialData;

  static final Map<String, LocalStorage> _cache = {};

  late DirUtils _dir;

  /// [ValueNotifier] which notifies about errors during storage initialization
  ValueNotifier<Error> onError = ValueNotifier(Error());

  /// A future indicating if localstorage instance is ready for read/write operations
  late Future<bool> ready;

  /// [key] is used as a filename
  /// Optional [path] is used as a directory. Defaults to application document directory
  factory LocalStorage(String key,
      [String? path, Map<String, dynamic>? initialData]) {
    if (_cache.containsKey(key)) {
      return _cache[key]!;
    } else {
      final instance = LocalStorage._internal(key, path, initialData);
      _cache[key] = instance;

      return instance;
    }
  }

  void dispose() {
    _dir.dispose();
  }

  LocalStorage._internal(String key,
      [String? path, Map<String, dynamic>? initialData]) {
    _dir = DirUtils(key, path);
    _initialData = initialData;

    ready = Future<bool>(() async {
      await _init();
      return true;
    });
  }

  Future<void> _init() async {
    try {
      await _dir.init(_initialData ?? {});
    } on Error catch (err) {
      onError.value = err;
    }
  }

  /// Returns a value from storage by key
  dynamic getItem(String key) {
    return _dir.getItem(key);
  }

  /// Saves item by [key] to a storage. Value should be json encodable (`json.encode()` is called under the hood).
  /// After item was set to storage, consecutive [getItem] will return `json` representation of this item
  /// if [toEncodable] is provided, it is called before setting item to storage
  /// otherwise `value.toJson()` is called
  Future<void> setItem(
    String key,
    value, [
    Object Function(Object nonEncodable)? toEncodable,
  ]) async {
    var data = toEncodable?.call(value);
    if (data == null) {
      try {
        data = value.toJson();
      } on NoSuchMethodError catch (_) {
        data = value;
      }
    }

    await _dir.setItem(key, data);

    return _flush();
  }

  /// Removes item from storage by key
  Future<void> deleteItem(String key) async {
    await _dir.remove(key);
    return _flush();
  }

  /// Removes all items from localstorage
  Future<void> clear() async {
    await _dir.clear();
    return _flush();
  }

  Future<void> _flush() async {
    try {
      await _dir.flush();
    } catch (e) {
      rethrow;
    }
    return;
  }
}

abstract class LocalStorageImpl {
  LocalStorageImpl(this.fileName, [this.path]);

  final String fileName;
  final String? path;

  Stream<Map<String, dynamic>> get stream;

  void dispose();

  Future<void> init([Map<String, dynamic> initialData]);

  Future<void> setItem(String key, dynamic value);

  dynamic getItem(String key);

  Future<bool> exists();

  Future<void> clear();

  Future<void> remove(String key);

  Future<void> flush();
}

class DirUtils implements LocalStorageImpl {
  DirUtils(this.fileName, [this.path]);

  @override
  final String? path;
  @override
  final String fileName;

  Map<String, dynamic> _data = {};

  @override
  Stream<Map<String, dynamic>> get stream => storage.stream;

  StreamController<Map<String, dynamic>> storage =
      StreamController<Map<String, dynamic>>();

  RandomAccessFile? _file;

  @override
  Future<void> clear() async {
    _data.clear();
    // storage.add(null);
  }

  @override
  void dispose() {
    storage.close();
    _file?.close();
  }

  @override
  Future<bool> exists() async {
    return true;
  }

  @override
  Future<void> flush([dynamic data]) async {
    final serialized = json.encode(data ?? _data);
    final buffer = utf8.encode(serialized);

    _file = await _file?.lock();
    _file = await _file?.setPosition(0);
    _file = await _file?.writeFrom(buffer);
    _file = await _file?.truncate(buffer.length);
    await _file?.unlock();
  }

  @override
  dynamic getItem(String key) {
    return _data[key];
  }

  @override
  Future<void> init([Map<String, dynamic> initialData = const {}]) async {
    _data = initialData;

    final f = await _getFile();
    final length = await f.length();

    if (length == 0) {
      return flush({});
    } else {
      await _readFile();
    }
  }

  @override
  Future<void> remove(String key) async {
    _data.remove(key);
  }

  @override
  Future<void> setItem(String key, dynamic value) async {
    _data[key] = value;
  }

  Future<void> _readFile() async {
    RandomAccessFile _file = await _getFile();
    final length = await _file.length();
    _file = await _file.setPosition(0);
    final buffer = Uint8List(length);
    await _file.readInto(buffer);
    final contentText = utf8.decode(buffer);

    _data = json.decode(contentText) as Map<String, dynamic>;
    storage.add(_data);
  }

  Future<RandomAccessFile> _getFile() async {
    if (_file != null) {
      return _file!;
    }

    final _path = path ?? (await _getDocumentDir()).path;
    final file = File('$_path/$fileName');

    if (await file.exists()) {
      _file = await file.open(mode: FileMode.append);
    } else {
      await file.create();
      _file = await file.open(mode: FileMode.append);
    }

    return _file!;
  }

  Future<Directory> _getDocumentDir() async {
    try {
      return await getApplicationDocumentsDirectory();
    } catch (err) {
      throw Error();
    }
  }
}
