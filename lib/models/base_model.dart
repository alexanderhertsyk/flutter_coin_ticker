base class BaseModel {
  final String? error;
  get hasError => error != null;

  BaseModel({this.error});
}
