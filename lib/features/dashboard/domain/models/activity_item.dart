class ActivityItem {
  final String id;
  final String title;
  final String subtitle;
  final DateTime scheduledAt;
  final String type; // 'payment_due', 'school_visit', 'teacher_assignment'

  const ActivityItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.scheduledAt,
    required this.type,
  });

  factory ActivityItem.fromJson(Map<String, dynamic> json) {
    return ActivityItem(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      scheduledAt: json['scheduled_at'] != null
          ? DateTime.tryParse(json['scheduled_at'] as String) ?? DateTime.now()
          : DateTime.now(),
      type: json['type'] as String? ?? 'general',
    );
  }
}
