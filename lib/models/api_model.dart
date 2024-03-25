//TODO: rename to Base & make it base OR abstract + apply generic!
class ApiModel<TResponse> {
  final int code;
  final dynamic response;
  final String? errorMessage;

  bool get succeed => code == 200;

  ApiModel({required this.code, this.response, this.errorMessage});
}
