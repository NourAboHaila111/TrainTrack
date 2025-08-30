class ReportModel {
  final String date;
  final int totalResponded;
  final int opened;
  final int closed;
  final int pending;
  final int reopened;
  final int followups;
  final String? lastDelegationFrom;

  ReportModel({
    required this.date,
    required this.totalResponded,
    required this.opened,
    required this.closed,
    required this.pending,
    required this.reopened,
    required this.followups,
    this.lastDelegationFrom,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      date: json["date"] ?? "",
      totalResponded: json["total_responded"] ?? 0,
      opened: json["opened"] ?? 0,
      closed: json["closed"] ?? 0,
      pending: json["pending"] ?? 0,
      reopened: json["reopened"] ?? 0,
      followups: json["followups"] ?? 0,
      lastDelegationFrom: json["last_delegation_from"],
    );
  }
}
