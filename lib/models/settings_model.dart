// To parse this JSON data, do
//
//     final settingsModel = settingsModelFromJson(jsonString);

class SettingsModel {
  String outputFormat;
  String outputFilename;
  bool autoprogram;
  bool append;

  SettingsModel({
    this.outputFormat = 'srt',
    this.outputFilename = '',
    this.autoprogram = true,
    this.append = false,
  });

  SettingsModel copyWith({
    String? outputFormat,
    String? outputFilename,
    bool? autoprogram,
    bool? append,
  }) =>
      SettingsModel(
        outputFormat: outputFormat ?? this.outputFormat,
        outputFilename: outputFilename ?? this.outputFilename,
        autoprogram: autoprogram ?? this.autoprogram,
        append: append ?? this.append,
      );

  factory SettingsModel.fromJson(Map<String, dynamic> json) => SettingsModel(
        outputFormat: json['output_format'],
        outputFilename: json['output_file_name'],
        autoprogram: json['autoprogram'],
        append: json['append'],
      );

  Map<String, dynamic> toJson() => {
        'output_format': outputFormat,
        'output_file_name': outputFilename,
        'autoprogram': autoprogram,
        'append': append,
      };
}
