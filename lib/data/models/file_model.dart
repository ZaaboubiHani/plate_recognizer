import '../Api/globals.dart';

class FileModel {
  final int? id;
  final String? name;
  final String? ext;
  final String? mime;
  final double? size;
  final String? url;

  FileModel(
      {this.id,
      this.name,
      this.ext,
      this.mime,
      this.size,
      this.url,
    });

  factory FileModel.fromStrapiJson(Map<String, dynamic> json) => FileModel(
        id: json['id'],
        name: json['attributes']['name'],
        ext: json['attributes']['ext'],
        mime: json['attributes']['mime'],
        size: json['attributes']['size'],
        url: Globals.baseUrl +
            (json['attributes']['url'] as String?).toString().substring(1),
       
      );

  factory FileModel.fromJson(Map<String, dynamic> json) => FileModel(
        id: json['id'],
        name: json['name'],
        ext: json['ext'],
        mime: json['mime'],
        size: json['size'],
        url: Globals.baseUrl + (json['url'] as String?).toString(),
       
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    if (id != null && id != 0) {
      data['id'] = id;
    }
    return data;
  }
}
