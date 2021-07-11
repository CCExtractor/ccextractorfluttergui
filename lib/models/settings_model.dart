class SettingsModel {
  //DROPDOWN
  String out;
  //DROPDOWN
  String inp;
  String outputfilename;
  bool fixptsjumps;
  bool append;

  // output file segmentation
  String outInterval;
  bool segmentonkeyonly;

  // Options that affect how input files will be processed.
  bool goptime;
  bool nogoptime;
  bool fixpadding;

  /// -90090
  bool freqEs15;
  String stream;

  // EXCEPTION
  bool videoedited;
  bool usepicorder;
  bool myth;
  bool nomyth;
  bool wtvconvertfix;
  bool wtvmpeg2;
  String program_number;
  bool autoprogram;
  bool multiprogram;
  String datapid;
  bool hauppauge;
  bool mp4vidtrack;
  bool noautotimeref;
  bool noscte20;
  bool webvttcss;
  bool analyzevideo;
  bool notimestamp;

  // Levenshtein distance:
  bool nolevdist;
  String minlevdist;
  String maxlevdist;

  // Options that affect what kind of output will be produced:
  bool chapters;
  bool bom;
  bool nobom;
  //DROPDOWN EXCEPTION
  String encoder;
  bool nofontcolor;
  bool nohtmlescape;
  bool notypesetting;
  bool trim;
  String defaultcolor;
  bool sentencecap;
  bool kf;
  bool splitbysentence;
  bool datets;
  bool sects;
  bool latrusmap;
  bool xds;
  bool lf;
  bool df;
  bool autodash;
  //DROPDOWN
  String xmltv;
  String xmltvliveinterval;
  String xmltvoutputinterval;
  bool xmltvonlycurrent;
  bool sem;
  //DROPDOWN
  String quantmode;
  String oem;

  // Options that affect how ccextractor reads and writes (buffering):
  bool bufferinput;
  bool nobufferinput;
  String buffersize;
  bool koc;
  bool dru;
  bool norollup;

  // Options that affect timing:
  String delay;
  String startat;
  String endat;

  // Teletext related options: TODO
  String tpage;
  bool teletext;
  bool noteletext;
  SettingsModel({
    this.out = 'auto/default',
    this.inp = 'auto/default',
    this.outputfilename = '',
    this.fixptsjumps = false,
    this.append = false,
    this.outInterval = '',
    this.segmentonkeyonly = false,
    this.goptime = false,
    this.nogoptime = false,
    this.fixpadding = false,
    this.freqEs15 = false,
    this.stream = '',
    this.videoedited = false,
    this.usepicorder = false,
    this.myth = false,
    this.nomyth = false,
    this.wtvconvertfix = false,
    this.wtvmpeg2 = false,
    this.program_number = '',
    this.autoprogram = true,
    this.multiprogram = false,
    this.datapid = '',
    this.hauppauge = false,
    this.mp4vidtrack = false,
    this.noautotimeref = false,
    this.noscte20 = false,
    this.webvttcss = false,
    this.analyzevideo = false,
    this.notimestamp = false,
    this.nolevdist = false,
    this.minlevdist = '',
    this.maxlevdist = '',
    this.chapters = false,
    this.bom = false,
    this.nobom = false,
    this.encoder = 'auto/default',
    this.nofontcolor = false,
    this.nohtmlescape = false,
    this.notypesetting = false,
    this.trim = false,
    this.defaultcolor = '',
    this.sentencecap = false,
    this.kf = false,
    this.splitbysentence = false,
    this.datets = false,
    this.sects = false,
    this.latrusmap = false,
    this.xds = false,
    this.lf = false,
    this.df = false,
    this.autodash = false,
    this.xmltv = 'auto/default',
    this.xmltvliveinterval = '',
    this.xmltvoutputinterval = '',
    this.xmltvonlycurrent = false,
    this.sem = false,
    this.quantmode = 'auto/default',
    this.oem = '',
    this.bufferinput = false,
    this.nobufferinput = false,
    this.buffersize = '',
    this.koc = false,
    this.dru = false,
    this.norollup = false,
    this.delay = '',
    this.startat = '',
    this.endat = '',
    this.tpage = '',
    this.teletext = false,
    this.noteletext = false,
  });

  SettingsModel copyWith({
    String? out,
    String? inp,
    String? outputfilename,
    bool? fixptsjumps,
    bool? append,
    String? outInterval,
    bool? segmentonkeyonly,
    bool? goptime,
    bool? nogoptime,
    bool? fixpadding,
    bool? freqEs15,
    String? stream,
    bool? videoedited,
    bool? usepicorder,
    bool? myth,
    bool? nomyth,
    bool? wtvconvertfix,
    bool? wtvmpeg2,
    String? program_number,
    bool? autoprogram,
    bool? multiprogram,
    String? datapid,
    bool? hauppauge,
    bool? mp4vidtrack,
    bool? noautotimeref,
    bool? noscte20,
    bool? webvttcss,
    bool? analyzevideo,
    bool? notimestamp,
    bool? nolevdist,
    String? minlevdist,
    String? maxlevdist,
    bool? chapters,
    bool? bom,
    bool? nobom,
    String? encoder,
    bool? nofontcolor,
    bool? nohtmlescape,
    bool? notypesetting,
    bool? trim,
    String? defaultcolor,
    bool? sentencecap,
    bool? kf,
    bool? splitbysentence,
    bool? datets,
    bool? sects,
    bool? latrusmap,
    bool? xds,
    bool? lf,
    bool? df,
    bool? autodash,
    String? xmltv,
    String? xmltvliveinterval,
    String? xmltvoutputinterval,
    bool? xmltvonlycurrent,
    bool? sem,
    String? quantmode,
    String? oem,
    bool? bufferinput,
    bool? nobufferinput,
    String? buffersize,
    bool? koc,
    bool? dru,
    bool? norollup,
    String? delay,
    String? startat,
    String? endat,
    String? tpage,
    bool? teletext,
    bool? noteletext,
  }) {
    return SettingsModel(
      out: out ?? this.out,
      inp: inp ?? this.inp,
      outputfilename: outputfilename ?? this.outputfilename,
      fixptsjumps: fixptsjumps ?? this.fixptsjumps,
      append: append ?? this.append,
      outInterval: outInterval ?? this.outInterval,
      segmentonkeyonly: segmentonkeyonly ?? this.segmentonkeyonly,
      goptime: goptime ?? this.goptime,
      nogoptime: nogoptime ?? this.nogoptime,
      fixpadding: fixpadding ?? this.fixpadding,
      freqEs15: freqEs15 ?? this.freqEs15,
      stream: stream ?? this.stream,
      videoedited: videoedited ?? this.videoedited,
      usepicorder: usepicorder ?? this.usepicorder,
      myth: myth ?? this.myth,
      nomyth: nomyth ?? this.nomyth,
      wtvconvertfix: wtvconvertfix ?? this.wtvconvertfix,
      wtvmpeg2: wtvmpeg2 ?? this.wtvmpeg2,
      program_number: program_number ?? this.program_number,
      autoprogram: autoprogram ?? this.autoprogram,
      multiprogram: multiprogram ?? this.multiprogram,
      datapid: datapid ?? this.datapid,
      hauppauge: hauppauge ?? this.hauppauge,
      mp4vidtrack: mp4vidtrack ?? this.mp4vidtrack,
      noautotimeref: noautotimeref ?? this.noautotimeref,
      noscte20: noscte20 ?? this.noscte20,
      webvttcss: webvttcss ?? this.webvttcss,
      analyzevideo: analyzevideo ?? this.analyzevideo,
      notimestamp: notimestamp ?? this.notimestamp,
      nolevdist: nolevdist ?? this.nolevdist,
      minlevdist: minlevdist ?? this.minlevdist,
      maxlevdist: maxlevdist ?? this.maxlevdist,
      chapters: chapters ?? this.chapters,
      bom: bom ?? this.bom,
      nobom: nobom ?? this.nobom,
      encoder: encoder ?? this.encoder,
      nofontcolor: nofontcolor ?? this.nofontcolor,
      nohtmlescape: nohtmlescape ?? this.nohtmlescape,
      notypesetting: notypesetting ?? this.notypesetting,
      trim: trim ?? this.trim,
      defaultcolor: defaultcolor ?? this.defaultcolor,
      sentencecap: sentencecap ?? this.sentencecap,
      kf: kf ?? this.kf,
      splitbysentence: splitbysentence ?? this.splitbysentence,
      datets: datets ?? this.datets,
      sects: sects ?? this.sects,
      latrusmap: latrusmap ?? this.latrusmap,
      xds: xds ?? this.xds,
      lf: lf ?? this.lf,
      df: df ?? this.df,
      autodash: autodash ?? this.autodash,
      xmltv: xmltv ?? this.xmltv,
      xmltvliveinterval: xmltvliveinterval ?? this.xmltvliveinterval,
      xmltvoutputinterval: xmltvoutputinterval ?? this.xmltvoutputinterval,
      xmltvonlycurrent: xmltvonlycurrent ?? this.xmltvonlycurrent,
      sem: sem ?? this.sem,
      quantmode: quantmode ?? this.quantmode,
      oem: oem ?? this.oem,
      bufferinput: bufferinput ?? this.bufferinput,
      nobufferinput: nobufferinput ?? this.nobufferinput,
      buffersize: buffersize ?? this.buffersize,
      koc: koc ?? this.koc,
      dru: dru ?? this.dru,
      norollup: norollup ?? this.norollup,
      delay: delay ?? this.delay,
      startat: startat ?? this.startat,
      endat: endat ?? this.endat,
      tpage: tpage ?? this.tpage,
      teletext: teletext ?? this.teletext,
      noteletext: noteletext ?? this.noteletext,
    );
  }

  static Map<String, String> get paramsLookUpMap {
    return {
      'out': '-out=',
      'in': '-in=',
      'outputfilename': '-o',
      'fixptsjumps': '-fixptsjumps',
      'append': '--append',
      'outInterval': '--outinterval',
      'segmentonkeyonly': '--segmentonkeyonly',
      'goptime': '--goptime',
      'nogoptime': '--nogoptime',
      'fixpadding': '--fixpadding',
      'freqEs15': '-90090',
      'stream': '--stream',
      'videoedited': '--videoedited',
      'usepicorder': '--usepicorder',
      'myth': '-myth',
      'nomyth': '-nomyth',
      'wtvconvertfix': '-wtvconvertfix',
      'wtvmpeg2': '-wtvmpeg2',
      'program_number': '--program-number',
      'autoprogram': '-autoprogram',
      'multiprogram': '-multiprogram',
      'datapid': '-datapid',
      'hauppauge': '--hauppauge',
      'mp4vidtrack': '-mp4vidtrack',
      'noautotimeref': '-noautotimeref',
      'noscte20': '--noscte20',
      'webvttcss': '--webvtt-create-css',
      'analyzevideo': '--analyzevideo',
      'notimestamp': '--no-timestamp-map',
      'nolevdist': '-nolevdist',
      'minlevdist': '-levdistmincnt',
      'maxlevdist': '-levdistmaxpct',
      'chapters': '-chapters',
      'bom': '-bom',
      'nobom': '-nobom',
      'nofontcolor': '--nofontcolor',
      'nohtmlescape': '--nohtmlescape',
      'notypesetting': '--notypesetting',
      'trim': '-trim',
      'defaultcolor': '--defaultcolor',
      'sentencecap': '--sentencecap',
      'kf': '--kf',
      'splitbysentence': '--splitbysentence',
      'datets': '-datets',
      'sects': '-sects',
      'latrusmap': '-latrusmap',
      'xds': '=xds',
      'lf': '-lf',
      'df': '-df',
      'autodash': '-  autodash',
      'xmltv': '-xmltv',
      'xmltvliveinterval': '-xmltvliveinterval',
      'xmltvoutputinterval': '-xmltvoutputinterval',
      'xmltvonlycurrent': '-xmltvonlycurrent',
      'sem': '-sem',
      'quantmode': '-quant',
      'oem': '-oem',
      'bufferinput': '--bufferinput',
      'nobufferinput': '-nobufferinput',
      'buffersize': '--buffersize',
      'koc': '-koc',
      'dru': '-dru',
      'norollup': '--norollup',
      'delay': '-delay',
      'startat': '-startat',
      'endat': '-endat',
      'tpage': '-tpage',
      'teletext': '-teletext',
      'noteletext': '-noteletext',
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'out': out,
      'inp': inp,
      'outputfilename': outputfilename,
      'fixptsjumps': fixptsjumps,
      'append': append,
      'outInterval': outInterval,
      'segmentonkeyonly': segmentonkeyonly,
      'goptime': goptime,
      'nogoptime': nogoptime,
      'fixpadding': fixpadding,
      'freqEs15': freqEs15,
      'stream': stream,
      'videoedited': videoedited,
      'usepicorder': usepicorder,
      'myth': myth,
      'nomyth': nomyth,
      'wtvconvertfix': wtvconvertfix,
      'wtvmpeg2': wtvmpeg2,
      'program_number': program_number,
      'autoprogram': autoprogram,
      'multiprogram': multiprogram,
      'datapid': datapid,
      'hauppauge': hauppauge,
      'mp4vidtrack': mp4vidtrack,
      'noautotimeref': noautotimeref,
      'noscte20': noscte20,
      'webvttcss': webvttcss,
      'analyzevideo': analyzevideo,
      'notimestamp': notimestamp,
      'nolevdist': nolevdist,
      'minlevdist': minlevdist,
      'maxlevdist': maxlevdist,
      'chapters': chapters,
      'bom': bom,
      'nobom': nobom,
      'encoder': encoder,
      'nofontcolor': nofontcolor,
      'nohtmlescape': nohtmlescape,
      'notypesetting': notypesetting,
      'trim': trim,
      'defaultcolor': defaultcolor,
      'sentencecap': sentencecap,
      'kf': kf,
      'splitbysentence': splitbysentence,
      'datets': datets,
      'sects': sects,
      'latrusmap': latrusmap,
      'xds': xds,
      'lf': lf,
      'df': df,
      'autodash': autodash,
      'xmltv': xmltv,
      'xmltvliveinterval': xmltvliveinterval,
      'xmltvoutputinterval': xmltvoutputinterval,
      'xmltvonlycurrent': xmltvonlycurrent,
      'sem': sem,
      'quantmode': quantmode,
      'oem': oem,
      'bufferinput': bufferinput,
      'nobufferinput': nobufferinput,
      'buffersize': buffersize,
      'koc': koc,
      'dru': dru,
      'norollup': norollup,
      'delay': delay,
      'startat': startat,
      'endat': endat,
      'tpage': tpage,
      'teletext': teletext,
      'noteletext': noteletext,
    };
  }

  static SettingsModel fromJson(Map<String, dynamic> map) {
    return SettingsModel(
      out: map['out'],
      inp: map['inp'],
      outputfilename: map['outputfilename'],
      fixptsjumps: map['fixptsjumps'],
      append: map['append'],
      outInterval: map['outInterval'],
      segmentonkeyonly: map['segmentonkeyonly'],
      goptime: map['goptime'],
      nogoptime: map['nogoptime'],
      fixpadding: map['fixpadding'],
      freqEs15: map['freqEs15'],
      stream: map['stream'],
      videoedited: map['videoedited'],
      usepicorder: map['usepicorder'],
      myth: map['myth'],
      nomyth: map['nomyth'],
      wtvconvertfix: map['wtvconvertfix'],
      wtvmpeg2: map['wtvmpeg2'],
      program_number: map['program_number'],
      autoprogram: map['autoprogram'],
      multiprogram: map['multiprogram'],
      datapid: map['datapid'],
      hauppauge: map['hauppauge'],
      mp4vidtrack: map['mp4vidtrack'],
      noautotimeref: map['noautotimeref'],
      noscte20: map['noscte20'],
      webvttcss: map['webvttcss'],
      analyzevideo: map['analyzevideo'],
      notimestamp: map['notimestamp'],
      nolevdist: map['nolevdist'],
      minlevdist: map['minlevdist'],
      maxlevdist: map['maxlevdist'],
      chapters: map['chapters'],
      bom: map['bom'],
      nobom: map['nobom'],
      encoder: map['encoder'],
      nofontcolor: map['nofontcolor'],
      nohtmlescape: map['nohtmlescape'],
      notypesetting: map['notypesetting'],
      trim: map['trim'],
      defaultcolor: map['defaultcolor'],
      sentencecap: map['sentencecap'],
      kf: map['kf'],
      splitbysentence: map['splitbysentence'],
      datets: map['datets'],
      sects: map['sects'],
      latrusmap: map['latrusmap'],
      xds: map['xds'],
      lf: map['lf'],
      df: map['df'],
      autodash: map['autodash'],
      xmltv: map['xmltv'],
      xmltvliveinterval: map['xmltvliveinterval'],
      xmltvoutputinterval: map['xmltvoutputinterval'],
      xmltvonlycurrent: map['xmltvonlycurrent'],
      sem: map['sem'],
      quantmode: map['quantmode'],
      oem: map['oem'],
      bufferinput: map['bufferinput'],
      nobufferinput: map['nobufferinput'],
      buffersize: map['buffersize'],
      koc: map['koc'],
      dru: map['dru'],
      norollup: map['norollup'],
      delay: map['delay'],
      startat: map['startat'],
      endat: map['endat'],
      tpage: map['tpage'],
      teletext: map['teletext'],
      noteletext: map['noteletext'],
    );
  }

  @override
  String toString() {
    return 'SettingsModel(out: $out, inp: $inp, outputfilename: $outputfilename, fixptsjumps: $fixptsjumps, append: $append, outInterval: $outInterval, segmentonkeyonly: $segmentonkeyonly, goptime: $goptime, nogoptime: $nogoptime, fixpadding: $fixpadding, freqEs15: $freqEs15, stream: $stream, videoedited: $videoedited, usepicorder: $usepicorder, myth: $myth, nomyth: $nomyth, wtvconvertfix: $wtvconvertfix, wtvmpeg2: $wtvmpeg2, program_number: $program_number, autoprogram: $autoprogram, multiprogram: $multiprogram, datapid: $datapid, hauppauge: $hauppauge, mp4vidtrack: $mp4vidtrack, noautotimeref: $noautotimeref, noscte20: $noscte20, webvttcss: $webvttcss, analyzevideo: $analyzevideo, notimestamp: $notimestamp, nolevdist: $nolevdist, minlevdist: $minlevdist, maxlevdist: $maxlevdist, chapters: $chapters, bom: $bom, nobom: $nobom, encoder: $encoder, nofontcolor: $nofontcolor, nohtmlescape: $nohtmlescape, notypesetting: $notypesetting, trim: $trim, defaultcolor: $defaultcolor, sentencecap: $sentencecap, kf: $kf, splitbysentence: $splitbysentence, datets: $datets, sects: $sects, latrusmap: $latrusmap, xds: $xds, lf: $lf, df: $df, autodash: $autodash, xmltv: $xmltv, xmltvliveinterval: $xmltvliveinterval, xmltvoutputinterval: $xmltvoutputinterval, xmltvonlycurrent: $xmltvonlycurrent, sem: $sem, quantmode: $quantmode, oem: $oem, bufferinput: $bufferinput, nobufferinput: $nobufferinput, buffersize: $buffersize, koc: $koc, dru: $dru, norollup: $norollup, delay: $delay, startat: $startat, endat: $endat, tpage: $tpage, teletext: $teletext, noteletext: $noteletext)';
  }

  /// returns all toggeles which are enabled (excluding textfields)
  List<String> get enabledSettings {
    List<String> enabledSettings = [];
    toJson().forEach((key, value) {
      if (value == true) {
        enabledSettings.add(key);
      }
    });
    return enabledSettings;
  }

  /// return all textfields and dropdowns which are not empty or not set to default
  List<Map<String, String>> get enabledtextfields {
    List<Map<String, String>> enabledtextfields = [];
    toJson().forEach(
      (key, value) {
        Map<String, String> textfield = {};
        if (value is String && value.isNotEmpty && value != 'auto/default') {
          textfield[key] = value;
          enabledtextfields.add(textfield);
        }
      },
    );
    return enabledtextfields;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SettingsModel &&
        other.out == out &&
        other.inp == inp &&
        other.outputfilename == outputfilename &&
        other.fixptsjumps == fixptsjumps &&
        other.append == append &&
        other.outInterval == outInterval &&
        other.segmentonkeyonly == segmentonkeyonly &&
        other.goptime == goptime &&
        other.nogoptime == nogoptime &&
        other.fixpadding == fixpadding &&
        other.freqEs15 == freqEs15 &&
        other.stream == stream &&
        other.videoedited == videoedited &&
        other.usepicorder == usepicorder &&
        other.myth == myth &&
        other.nomyth == nomyth &&
        other.wtvconvertfix == wtvconvertfix &&
        other.wtvmpeg2 == wtvmpeg2 &&
        other.program_number == program_number &&
        other.autoprogram == autoprogram &&
        other.multiprogram == multiprogram &&
        other.datapid == datapid &&
        other.hauppauge == hauppauge &&
        other.mp4vidtrack == mp4vidtrack &&
        other.noautotimeref == noautotimeref &&
        other.noscte20 == noscte20 &&
        other.webvttcss == webvttcss &&
        other.analyzevideo == analyzevideo &&
        other.notimestamp == notimestamp &&
        other.nolevdist == nolevdist &&
        other.minlevdist == minlevdist &&
        other.maxlevdist == maxlevdist &&
        other.chapters == chapters &&
        other.bom == bom &&
        other.nobom == nobom &&
        other.encoder == encoder &&
        other.nofontcolor == nofontcolor &&
        other.nohtmlescape == nohtmlescape &&
        other.notypesetting == notypesetting &&
        other.trim == trim &&
        other.defaultcolor == defaultcolor &&
        other.sentencecap == sentencecap &&
        other.kf == kf &&
        other.splitbysentence == splitbysentence &&
        other.datets == datets &&
        other.sects == sects &&
        other.latrusmap == latrusmap &&
        other.xds == xds &&
        other.lf == lf &&
        other.df == df &&
        other.autodash == autodash &&
        other.xmltv == xmltv &&
        other.xmltvliveinterval == xmltvliveinterval &&
        other.xmltvoutputinterval == xmltvoutputinterval &&
        other.xmltvonlycurrent == xmltvonlycurrent &&
        other.sem == sem &&
        other.quantmode == quantmode &&
        other.oem == oem &&
        other.bufferinput == bufferinput &&
        other.nobufferinput == nobufferinput &&
        other.buffersize == buffersize &&
        other.koc == koc &&
        other.dru == dru &&
        other.norollup == norollup &&
        other.delay == delay &&
        other.startat == startat &&
        other.endat == endat &&
        other.tpage == tpage &&
        other.teletext == teletext &&
        other.noteletext == noteletext;
  }

  @override
  int get hashCode {
    return out.hashCode ^
        inp.hashCode ^
        outputfilename.hashCode ^
        fixptsjumps.hashCode ^
        append.hashCode ^
        outInterval.hashCode ^
        segmentonkeyonly.hashCode ^
        goptime.hashCode ^
        nogoptime.hashCode ^
        fixpadding.hashCode ^
        freqEs15.hashCode ^
        stream.hashCode ^
        videoedited.hashCode ^
        usepicorder.hashCode ^
        myth.hashCode ^
        nomyth.hashCode ^
        wtvconvertfix.hashCode ^
        wtvmpeg2.hashCode ^
        program_number.hashCode ^
        autoprogram.hashCode ^
        multiprogram.hashCode ^
        datapid.hashCode ^
        hauppauge.hashCode ^
        mp4vidtrack.hashCode ^
        noautotimeref.hashCode ^
        noscte20.hashCode ^
        webvttcss.hashCode ^
        analyzevideo.hashCode ^
        notimestamp.hashCode ^
        nolevdist.hashCode ^
        minlevdist.hashCode ^
        maxlevdist.hashCode ^
        chapters.hashCode ^
        bom.hashCode ^
        nobom.hashCode ^
        encoder.hashCode ^
        nofontcolor.hashCode ^
        nohtmlescape.hashCode ^
        notypesetting.hashCode ^
        trim.hashCode ^
        defaultcolor.hashCode ^
        sentencecap.hashCode ^
        kf.hashCode ^
        splitbysentence.hashCode ^
        datets.hashCode ^
        sects.hashCode ^
        latrusmap.hashCode ^
        xds.hashCode ^
        lf.hashCode ^
        df.hashCode ^
        autodash.hashCode ^
        xmltv.hashCode ^
        xmltvliveinterval.hashCode ^
        xmltvoutputinterval.hashCode ^
        xmltvonlycurrent.hashCode ^
        sem.hashCode ^
        quantmode.hashCode ^
        oem.hashCode ^
        bufferinput.hashCode ^
        nobufferinput.hashCode ^
        buffersize.hashCode ^
        koc.hashCode ^
        dru.hashCode ^
        norollup.hashCode ^
        delay.hashCode ^
        startat.hashCode ^
        endat.hashCode ^
        tpage.hashCode ^
        teletext.hashCode ^
        noteletext.hashCode;
  }
}
