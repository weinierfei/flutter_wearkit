import 'package:equatable/equatable.dart';

class WomenHealthConfig extends Equatable {
  final int mode;
  final bool remindDevice;
  final int remindTime;
  final int remindAdvance;
  final int remindType;
  final int cycle;
  final int duration;
  final DateTime latest;

  const WomenHealthConfig({
    required this.mode,
    this.remindDevice = true,
    this.remindTime = 21 * 60,
    this.remindAdvance = 1,
    this.remindType = 0, // Corresponds to PREGNANCY_DAYS
    this.cycle = 28,
    this.duration = 7,
    required this.latest,
  });

  // copyWith 方法可以方便地创建对象的副本，同时修改某些字段
  WomenHealthConfig copyWith({
    int? mode,
    bool? remindDevice,
    int? remindTime,
    int? remindAdvance,
    int? remindType,
    int? cycle,
    int? duration,
    DateTime? latest,
  }) {
    return WomenHealthConfig(
      mode: mode ?? this.mode,
      remindDevice: remindDevice ?? this.remindDevice,
      remindTime: remindTime ?? this.remindTime,
      remindAdvance: remindAdvance ?? this.remindAdvance,
      remindType: remindType ?? this.remindType,
      cycle: cycle ?? this.cycle,
      duration: duration ?? this.duration,
      latest: latest ?? this.latest,
    );
  }

  // 将对象转换为 JSON Map
  Map<String, dynamic> toJson() {
    return {
      'mode': mode,
      'remindDevice': remindDevice,
      'remindTime': remindTime,
      'remindAdvance': remindAdvance,
      'remindType': remindType,
      'cycle': cycle,
      'duration': duration,
      'latest': latest.millisecondsSinceEpoch,
    };
  }

  // 从 JSON Map 创建对象
  factory WomenHealthConfig.fromJson(Map<String, dynamic> json) {
    return WomenHealthConfig(
      mode: json['mode'] as int,
      remindDevice: json['remindDevice'] as bool? ?? true,
      remindTime: json['remindTime'] as int? ?? 21 * 60,
      remindAdvance: json['remindAdvance'] as int? ?? 1,
      remindType: json['remindType'] as int? ?? 0,
      cycle: json['cycle'] as int? ?? 28,
      duration: json['duration'] as int? ?? 7,
      latest: DateTime.fromMillisecondsSinceEpoch(json['latest'] as int),
    );
  }

  @override
  List<Object?> get props => [
    mode,
    remindDevice,
    remindTime,
    remindAdvance,
    remindType,
    cycle,
    duration,
    latest,
  ];

  @override
  String toString() {
    return "WomenHealthConfig(mode=$mode,remindDevice=$remindAdvance, remindTime=$remindTime,remindAdvance=$remindAdvance,remindType=$remindType,cycle=$cycle,duration=$duration,latest=$latest)";
  }
}

// 对应 WomenHealthMode
class WomenHealthMode {
  static const int NONE = 0;
  static const int MENSTRUATION = 1;
  static const int PREGNANCY_PREPARE = 2;
  static const int PREGNANCY = 3;
}

// 对应 WKWomenHealthConfig.RemindType
class WKRemindType {
  static const int PREGNANCY_DAYS = 0;
  static const int DUE_DAYS = 1;
}
