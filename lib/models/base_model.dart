// TODO: replace inheritance w/ composition, cuz:
// 1) model shouldn't know about error (mb in Flutter it should?)
// 2) fields init could be difficult, like dateTime or collections (actually named C-tor may help)
// 3) !!! when one model contains other(s) - child sub models shouldn't have errors & etc.
base class BaseModel {
  final String? error;
  get hasError => error != null;

  BaseModel({this.error});
}
