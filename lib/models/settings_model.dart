// To parse this JSON data, do
//
//     final settingsModel = settingsModelFromJson(jsonString);

class SettingsModel {
  String outputformat;
  String outputfilename;
  bool autoprogram;
  bool append;

  SettingsModel({
    this.outputformat = 'srt',
    this.outputfilename = '',
    this.autoprogram = true,
    this.append = false,  
  });

  SettingsModel copyWith({
    String? outputformat,
    String? outputfilename,
    bool? autoprogram,
    bool? append,
  }) =>
      SettingsModel(
        outputformat: outputformat ?? this.outputformat,
        outputfilename: outputfilename ?? this.outputfilename,
        autoprogram: autoprogram ?? this.autoprogram,
        append: append ?? this.append,
      );

  factory SettingsModel.fromJson(Map<String, dynamic> json) => SettingsModel(
        outputformat: json['output_format'],
        outputfilename: json['output_file_name'],
        autoprogram: json['autoprogram'],
        append: json['append'],
      );

  Map<String, dynamic> toJson() => {
        'output_format': outputformat,
        'output_file_name': outputfilename,
        'autoprogram': autoprogram,
        'append': append,
      };
}
