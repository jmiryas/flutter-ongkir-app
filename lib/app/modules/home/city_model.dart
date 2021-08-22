class CityModel {
  String? cityId;
  String? provinceId;
  String? province;
  String? type;
  String? cityName;
  String? postalCode;

  CityModel(
      {this.cityId,
      this.provinceId,
      this.province,
      this.type,
      this.cityName,
      this.postalCode});

  CityModel.fromJson(Map<String, dynamic> json) {
    cityId = json['city_id'];
    provinceId = json['province_id'];
    province = json['province'];
    type = json['type'];
    cityName = json['city_name'];
    postalCode = json['postal_code'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    data['city_id'] = cityId;
    data['province_id'] = provinceId;
    data['province'] = province;
    data['type'] = type;
    data['city_name'] = cityName;
    data['postal_code'] = postalCode;

    return data;
  }

  static List<CityModel>? fromJsonList(List? list) {
    if (list == null) return null;

    if (list.length == 0) return List<CityModel>.empty();

    return list.map((item) => CityModel.fromJson(item)).toList();
  }
}
