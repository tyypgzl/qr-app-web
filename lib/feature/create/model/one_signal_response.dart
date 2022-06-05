class OneSignalNotificationResponse {
  String? id;
  int? recipients;

  OneSignalNotificationResponse({
    this.id,
    this.recipients,
  });

  OneSignalNotificationResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    recipients = json['recipients'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['recipients'] = recipients;
    return data;
  }
}
