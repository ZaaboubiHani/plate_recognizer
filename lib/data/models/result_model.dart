class ResultModel {
  String? url;
  String? number;
  String? path;

  ResultModel({
    this.url,
    this.number,
  });

  factory ResultModel.fromJson(Map<String,dynamic> json){
    return ResultModel(
      url: json['cropped_im_url'],
      number:  json['license_plate_number'],
    );
  }
}
