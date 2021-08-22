class ProvinceModel {
  String? provinceId;
  String? province;

  ProvinceModel({this.provinceId, this.province});

  ProvinceModel.fromJson(Map<String, dynamic> json) {
    provinceId = json['province_id'];
    province = json['province'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['province_id'] = provinceId;
    data['province'] = province;
    return data;
  }

  static List<ProvinceModel>? fromJsonList(List? list) {
    if (list == null) return null;

    if (list.length == 0) return List<ProvinceModel>.empty();

    return list.map((item) => ProvinceModel.fromJson(item)).toList();
  }
}
