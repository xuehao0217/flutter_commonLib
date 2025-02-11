
class BaseEntity {
  final int code;
  final String msg;
  final dynamic data;  // 使用 dynamic 以支持 Map 和 List

  const BaseEntity({
    required this.code,
    required this.msg,
    this.data,
  });

  bool isSuccess() => code == 0;

  // 基础解析方法
  factory BaseEntity.fromJson(Map<String, dynamic> json) {
    return BaseEntity(
      code: json['errorCode'] as int? ?? -1,
      msg: json['errorMsg'] as String? ?? '',
      data: json['data'],
    );
  }
}