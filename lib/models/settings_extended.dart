// THIS IS CURRENTLY A WIP FILE FOR THE SETTINGSMODEL FILE WHICH ADDS ALL THE 
// OTHER OPTIONS PROVIDED BY CCX. WILL BE FINISHED AFTER RELEASE THE FIRST RELEASE

// import 'dart:convert';

// class SettingsModel {
//   /// Select the format for output files, default srt
//   String outputformat;

//   /// Force specify the format for input files, if not passed ccx automatically
//   /// detects the input format
//   String inputformat;

//   /// Allows assigning a custom file name for the output subtitle files.
//   String outputfilename;

//   /// Enables fixptsbus which disables ignoreptsjumps, default value false
//   bool fixptsjumps;

//   /// Outputs the final file in [outinterval] number of part files.
//   int outinterval;

//   /// Something I frame, default value false
//   bool segmentonkeyonly;

//   /// Appends to existing file instead of overwriting.
//   bool append;

//   /// Use GOP time instead of PTS, default value false.
//   bool goptime;

//   /// Never use GOP even if detected, default value false.
//   bool nogoptime;

//   /// Fixes some bad timing issue, default value false.
//   bool fixpadding;

//   /// Very rare, default value false.
//   bool freqEs15;

//   /// Use if video was editied with some pro tool, default value false.
//   bool videoedited;

//   /// Use the pic_order_cnt_lsb in AVC/H.264 data streams, default value false.
//   bool usepicorder;
  
//   /// Force myth, default value false.
//   bool myth;

//   /// Use if not autodetected? default value false.
//   bool nomyth;

//   /// windows 7 only thing, default value false.
//   bool wtvconvertfix;

//   /// Get captions from mpeg2 instead of captions steam, default value false. 
//   bool wtvmpeg2;

//   /// Seems useful, default value true. (helps with program number stuff in TS)
//   bool autoprogram;

//   /// like autoprogram but not good? default value false. (autoprogram should 
//   /// work well)
//   bool multiprogram;

//   /// Some obscure card setting, default value false.
//   bool hauppauge;

//   /// 
//   bool mp4vidtrack;
//   bool noautotimeref;
//   bool noscte20;
//   bool webvttcss;
//   bool analyzevideo;
//   bool notimestamp;
//   bool nolevdist;
//   int minlevdist;
//   int maxlevdist;
//   bool bom;
//   bool nobom;
//   String encoder;
//   bool nofontcolor;
//   bool nohtmlescape;
//   bool notypesetting;
//   bool trim;
//   String defaultcolor;
//   bool sentencecap;
//   bool kf;
//   bool splitbysentence;
//   bool datets;
//   bool sects;
//   bool xds;
//   bool lf;
//   bool df;
//   bool autodash;
//   String quantmode;
//   String oem;
//   bool bufferinput;
//   bool nobufferinput;
//   int buffersize;
//   bool koc;
//   bool dru;
//   bool norollup;
//   int delay;
//   int startat;
//   int endat;
//   SettingsModel({
//     this.outputformat = 'srt',
//     this.inputformat = '',
//     this.outputfilename = '',
//     this.fixptsjumps = false,
//     this.outinterval,
//     this.segmentonkeyonly,
//     this.append,
//     this.goptime,
//     this.nogoptime,
//     this.fixpadding,
//     this.freqEs15,
//     this.videoedited,
//     this.usepicorder,
//     this.myth,
//     this.nomyth,
//     this.wtvconvertfix,
//     this.wtvmpeg2,
//     this.autoprogram,
//     this.multiprogram,
//     this.hauppauge,
//     this.mp4vidtrack,
//     this.noautotimeref,
//     this.noscte20,
//     this.webvttcss,
//     this.analyzevideo,
//     this.notimestamp,
//     this.nolevdist,
//     this.minlevdist,
//     this.maxlevdist,
//     this.bom,
//     this.nobom,
//     this.encoder,
//     this.nofontcolor,
//     this.nohtmlescape,
//     this.notypesetting,
//     this.trim,
//     this.defaultcolor,
//     this.sentencecap,
//     this.kf,
//     this.splitbysentence,
//     this.datets,
//     this.sects,
//     this.xds,
//     this.lf,
//     this.df,
//     this.autodash,
//     this.quantmode,
//     this.oem,
//     this.bufferinput,
//     this.nobufferinput,
//     this.buffersize,
//     this.koc,
//     this.dru,
//     this.norollup,
//     this.delay,
//     this.startat,
//     this.endat,
//   });

//   SettingsModel copyWith({
//     String? outputformat,
//     String? inputformat,
//     String? outputfilename,
//     bool? fixptsjumps,
//     int? outinterval,
//     bool? segmentonkeyonly,
//     bool? append,
//     bool? goptime,
//     bool? nogoptime,
//     bool? fixpadding,
//     bool? freqEs15,
//     bool? videoedited,
//     bool? usepicorder,
//     bool? myth,
//     bool? nomyth,
//     bool? wtvconvertfix,
//     bool? wtvmpeg2,
//     bool? autoprogram,
//     bool? multiprogram,
//     bool? hauppauge,
//     bool? mp4vidtrack,
//     bool? noautotimeref,
//     bool? noscte20,
//     bool? webvttcss,
//     bool? analyzevideo,
//     bool? notimestamp,
//     bool? nolevdist,
//     int? minlevdist,
//     int? maxlevdist,
//     bool? bom,
//     bool? nobom,
//     String? encoder,
//     bool? nofontcolor,
//     bool? nohtmlescape,
//     bool? notypesetting,
//     bool? trim,
//     String? defaultcolor,
//     bool? sentencecap,
//     bool? kf,
//     bool? splitbysentence,
//     bool? datets,
//     bool? sects,
//     bool? xds,
//     bool? lf,
//     bool? df,
//     bool? autodash,
//     String? quantmode,
//     String? oem,
//     bool? bufferinput,
//     bool? nobufferinput,
//     int? buffersize,
//     bool? koc,
//     bool? dru,
//     bool? norollup,
//     int? delay,
//     int? startat,
//     int? endat,
//   }) {
//     return SettingsModel(
//       outputformat: outputformat ?? this.outputformat,
//       inputformat: inputformat ?? this.inputformat,
//       outputfilename: outputfilename ?? this.outputfilename,
//       fixptsjumps: fixptsjumps ?? this.fixptsjumps,
//       outinterval: outinterval ?? this.outinterval,
//       segmentonkeyonly: segmentonkeyonly ?? this.segmentonkeyonly,
//       append: append ?? this.append,
//       goptime: goptime ?? this.goptime,
//       nogoptime: nogoptime ?? this.nogoptime,
//       fixpadding: fixpadding ?? this.fixpadding,
//       freqEs15: freqEs15 ?? this.freqEs15,
//       videoedited: videoedited ?? this.videoedited,
//       usepicorder: usepicorder ?? this.usepicorder,
//       myth: myth ?? this.myth,
//       nomyth: nomyth ?? this.nomyth,
//       wtvconvertfix: wtvconvertfix ?? this.wtvconvertfix,
//       wtvmpeg2: wtvmpeg2 ?? this.wtvmpeg2,
//       autoprogram: autoprogram ?? this.autoprogram,
//       multiprogram: multiprogram ?? this.multiprogram,
//       hauppauge: hauppauge ?? this.hauppauge,
//       mp4vidtrack: mp4vidtrack ?? this.mp4vidtrack,
//       noautotimeref: noautotimeref ?? this.noautotimeref,
//       noscte20: noscte20 ?? this.noscte20,
//       webvttcss: webvttcss ?? this.webvttcss,
//       analyzevideo: analyzevideo ?? this.analyzevideo,
//       notimestamp: notimestamp ?? this.notimestamp,
//       nolevdist: nolevdist ?? this.nolevdist,
//       minlevdist: minlevdist ?? this.minlevdist,
//       maxlevdist: maxlevdist ?? this.maxlevdist,
//       bom: bom ?? this.bom,
//       nobom: nobom ?? this.nobom,
//       encoder: encoder ?? this.encoder,
//       nofontcolor: nofontcolor ?? this.nofontcolor,
//       nohtmlescape: nohtmlescape ?? this.nohtmlescape,
//       notypesetting: notypesetting ?? this.notypesetting,
//       trim: trim ?? this.trim,
//       defaultcolor: defaultcolor ?? this.defaultcolor,
//       sentencecap: sentencecap ?? this.sentencecap,
//       kf: kf ?? this.kf,
//       splitbysentence: splitbysentence ?? this.splitbysentence,
//       datets: datets ?? this.datets,
//       sects: sects ?? this.sects,
//       xds: xds ?? this.xds,
//       lf: lf ?? this.lf,
//       df: df ?? this.df,
//       autodash: autodash ?? this.autodash,
//       quantmode: quantmode ?? this.quantmode,
//       oem: oem ?? this.oem,
//       bufferinput: bufferinput ?? this.bufferinput,
//       nobufferinput: nobufferinput ?? this.nobufferinput,
//       buffersize: buffersize ?? this.buffersize,
//       koc: koc ?? this.koc,
//       dru: dru ?? this.dru,
//       norollup: norollup ?? this.norollup,
//       delay: delay ?? this.delay,
//       startat: startat ?? this.startat,
//       endat: endat ?? this.endat,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'outputformat': outputformat,
//       'inputformat': inputformat,
//       'outputfilename': outputfilename,
//       'fixptsjumps': fixptsjumps,
//       'outinterval': outinterval,
//       'segmentonkeyonly': segmentonkeyonly,
//       'append': append,
//       'goptime': goptime,
//       'nogoptime': nogoptime,
//       'fixpadding': fixpadding,
//       'freqEs15': freqEs15,
//       'videoedited': videoedited,
//       'usepicorder': usepicorder,
//       'myth': myth,
//       'nomyth': nomyth,
//       'wtvconvertfix': wtvconvertfix,
//       'wtvmpeg2': wtvmpeg2,
//       'autoprogram': autoprogram,
//       'multiprogram': multiprogram,
//       'hauppauge': hauppauge,
//       'mp4vidtrack': mp4vidtrack,
//       'noautotimeref': noautotimeref,
//       'noscte20': noscte20,
//       'webvttcss': webvttcss,
//       'analyzevideo': analyzevideo,
//       'notimestamp': notimestamp,
//       'nolevdist': nolevdist,
//       'minlevdist': minlevdist,
//       'maxlevdist': maxlevdist,
//       'bom': bom,
//       'nobom': nobom,
//       'encoder': encoder,
//       'nofontcolor': nofontcolor,
//       'nohtmlescape': nohtmlescape,
//       'notypesetting': notypesetting,
//       'trim': trim,
//       'defaultcolor': defaultcolor,
//       'sentencecap': sentencecap,
//       'kf': kf,
//       'splitbysentence': splitbysentence,
//       'datets': datets,
//       'sects': sects,
//       'xds': xds,
//       'lf': lf,
//       'df': df,
//       'autodash': autodash,
//       'quantmode': quantmode,
//       'oem': oem,
//       'bufferinput': bufferinput,
//       'nobufferinput': nobufferinput,
//       'buffersize': buffersize,
//       'koc': koc,
//       'dru': dru,
//       'norollup': norollup,
//       'delay': delay,
//       'startat': startat,
//       'endat': endat,
//     };
//   }

//   factory SettingsModel.fromMap(Map<String, dynamic> map) {
//     return SettingsModel(
//       outputformat: map['outputformat'],
//       inputformat: map['inputformat'],
//       outputfilename: map['outputfilename'],
//       fixptsjumps: map['fixptsjumps'],
//       outinterval: map['outinterval'],
//       segmentonkeyonly: map['segmentonkeyonly'],
//       append: map['append'],
//       goptime: map['goptime'],
//       nogoptime: map['nogoptime'],
//       fixpadding: map['fixpadding'],
//       freqEs15: map['freqEs15'],
//       videoedited: map['videoedited'],
//       usepicorder: map['usepicorder'],
//       myth: map['myth'],
//       nomyth: map['nomyth'],
//       wtvconvertfix: map['wtvconvertfix'],
//       wtvmpeg2: map['wtvmpeg2'],
//       autoprogram: map['autoprogram'],
//       multiprogram: map['multiprogram'],
//       hauppauge: map['hauppauge'],
//       mp4vidtrack: map['mp4vidtrack'],
//       noautotimeref: map['noautotimeref'],
//       noscte20: map['noscte20'],
//       webvttcss: map['webvttcss'],
//       analyzevideo: map['analyzevideo'],
//       notimestamp: map['notimestamp'],
//       nolevdist: map['nolevdist'],
//       minlevdist: map['minlevdist'],
//       maxlevdist: map['maxlevdist'],
//       bom: map['bom'],
//       nobom: map['nobom'],
//       encoder: map['encoder'],
//       nofontcolor: map['nofontcolor'],
//       nohtmlescape: map['nohtmlescape'],
//       notypesetting: map['notypesetting'],
//       trim: map['trim'],
//       defaultcolor: map['defaultcolor'],
//       sentencecap: map['sentencecap'],
//       kf: map['kf'],
//       splitbysentence: map['splitbysentence'],
//       datets: map['datets'],
//       sects: map['sects'],
//       xds: map['xds'],
//       lf: map['lf'],
//       df: map['df'],
//       autodash: map['autodash'],
//       quantmode: map['quantmode'],
//       oem: map['oem'],
//       bufferinput: map['bufferinput'],
//       nobufferinput: map['nobufferinput'],
//       buffersize: map['buffersize'],
//       koc: map['koc'],
//       dru: map['dru'],
//       norollup: map['norollup'],
//       delay: map['delay'],
//       startat: map['startat'],
//       endat: map['endat'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory SettingsModel.fromJson(String source) =>
//       SettingsModel.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'SettingsModel(outputformat: $outputformat, inputformat: $inputformat, outputfilename: $outputfilename, fixptsjumps: $fixptsjumps, outinterval: $outinterval, segmentonkeyonly: $segmentonkeyonly, append: $append, goptime: $goptime, nogoptime: $nogoptime, fixpadding: $fixpadding, freqEs15: $freqEs15, videoedited: $videoedited, usepicorder: $usepicorder, myth: $myth, nomyth: $nomyth, wtvconvertfix: $wtvconvertfix, wtvmpeg2: $wtvmpeg2, autoprogram: $autoprogram, multiprogram: $multiprogram, hauppauge: $hauppauge, mp4vidtrack: $mp4vidtrack, noautotimeref: $noautotimeref, noscte20: $noscte20, webvttcss: $webvttcss, analyzevideo: $analyzevideo, notimestamp: $notimestamp, nolevdist: $nolevdist, minlevdist: $minlevdist, maxlevdist: $maxlevdist, bom: $bom, nobom: $nobom, encoder: $encoder, nofontcolor: $nofontcolor, nohtmlescape: $nohtmlescape, notypesetting: $notypesetting, trim: $trim, defaultcolor: $defaultcolor, sentencecap: $sentencecap, kf: $kf, splitbysentence: $splitbysentence, datets: $datets, sects: $sects, xds: $xds, lf: $lf, df: $df, autodash: $autodash, quantmode: $quantmode, oem: $oem, bufferinput: $bufferinput, nobufferinput: $nobufferinput, buffersize: $buffersize, koc: $koc, dru: $dru, norollup: $norollup, delay: $delay, startat: $startat, endat: $endat)';
//   }
// }
