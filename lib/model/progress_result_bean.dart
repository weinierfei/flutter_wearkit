import 'package:json_annotation/json_annotation.dart';

part 'progress_result_bean.g.dart';

@JsonSerializable()
class ProgressResultBean {
  @JsonKey(name: 'progress')
  int progress;

  @JsonKey(name: 'result')
  String? result;

  ProgressResultBean(
    this.progress,
    this.result,
  );

  factory ProgressResultBean.fromJson(Map<String, dynamic> srcJson) =>
      _$ProgressResultBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProgressResultBeanToJson(this);

  @override
  String toString() {
    return 'ProgressResultBean{progress: $progress, result: $result}';
  }
}
