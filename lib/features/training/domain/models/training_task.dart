/// 训练任务的完成状态。
enum TrainingTaskStatus { pending, completed, skipped }

extension TrainingTaskStatusX on TrainingTaskStatus {
  String get label {
    switch (this) {
      case TrainingTaskStatus.pending:
        return '待完成';
      case TrainingTaskStatus.completed:
        return '已完成';
      case TrainingTaskStatus.skipped:
        return '已跳过';
    }
  }
}

/// 训练任务（由周计划生成，或由其他模块手动创建）。
class TrainingTask {
  final String id;
  final String title;
  final String type;
  final DateTime? date;
  final int? distanceKm;
  final int? durationMin;
  final String description;
  final String? guidance;
  final TrainingTaskStatus status;

  /// 关联的跑步记录 ID，由 ANNO-8 的跑步链路写入。
  final String? runRecordId;

  const TrainingTask({
    required this.id,
    required this.title,
    required this.type,
    this.date,
    this.distanceKm,
    this.durationMin,
    required this.description,
    this.guidance,
    this.status = TrainingTaskStatus.pending,
    this.runRecordId,
  });

  bool get completed => status == TrainingTaskStatus.completed;

  bool get skipped => status == TrainingTaskStatus.skipped;

  bool get isPending => status == TrainingTaskStatus.pending;

  TrainingTask copyWith({
    String? id,
    String? title,
    String? type,
    DateTime? date,
    int? distanceKm,
    int? durationMin,
    String? description,
    String? guidance,
    TrainingTaskStatus? status,
    String? runRecordId,
  }) {
    return TrainingTask(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      date: date ?? this.date,
      distanceKm: distanceKm ?? this.distanceKm,
      durationMin: durationMin ?? this.durationMin,
      description: description ?? this.description,
      guidance: guidance ?? this.guidance,
      status: status ?? this.status,
      runRecordId: runRecordId ?? this.runRecordId,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'type': type,
        'date': date?.toIso8601String(),
        'distanceKm': distanceKm,
        'durationMin': durationMin,
        'description': description,
        'guidance': guidance,
        'status': status.name,
        'runRecordId': runRecordId,
      };

  factory TrainingTask.fromJson(Map<String, dynamic> json) {
    return TrainingTask(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      type: json['type'] as String? ?? 'easy',
      date: json['date'] == null
          ? null
          : DateTime.tryParse(json['date'] as String),
      distanceKm: (json['distanceKm'] as num?)?.toInt(),
      durationMin: (json['durationMin'] as num?)?.toInt(),
      description: json['description'] as String? ?? '',
      guidance: json['guidance'] as String?,
      status: TrainingTaskStatus.values.firstWhere(
        (TrainingTaskStatus value) => value.name == json['status'],
        orElse: () => TrainingTaskStatus.pending,
      ),
      runRecordId: json['runRecordId'] as String?,
    );
  }
}
