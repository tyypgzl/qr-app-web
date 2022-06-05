class OneSignalNotification {
  String? appId;
  List<String>? includedSegments;
  Headings? headings;
  Headings? contents;

  OneSignalNotification(
      {this.appId, this.includedSegments, this.headings, this.contents});

  OneSignalNotification.fromJson(Map<String, dynamic> json) {
    appId = json['app_id'];
    includedSegments = json['included_segments'].cast<String>();
    headings =
        json['headings'] != null ? Headings.fromJson(json['headings']) : null;
    contents =
        json['contents'] != null ? Headings.fromJson(json['contents']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['app_id'] = appId;
    data['included_segments'] = includedSegments;

    if (headings != null) {
      data['headings'] = headings!.toJson();
    }
    if (contents != null) {
      data['contents'] = contents!.toJson();
    }
    return data;
  }
}

class Headings {
  String? en;
  String? tr;

  Headings({this.en, this.tr});

  Headings.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    tr = json['tr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['en'] = en;
    data['tr'] = tr;
    return data;
  }
}
