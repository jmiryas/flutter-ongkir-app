import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ongkir/app/modules/home/province_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_ongkir/app/modules/home/controllers/home_controller.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../../utils/province_type.dart';

class ProvinceWidget extends GetView<HomeController> {
  final PROVINCE_TYPE provinceType;

  ProvinceWidget({required this.provinceType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: DropdownSearch<ProvinceModel>(
        label:
            "Provinsi ${provinceType == PROVINCE_TYPE.Origin ? 'Asal' : 'Tujuan'}",
        showClearButton: true,
        showSearchBox: true,
        searchBoxDecoration: InputDecoration(
            hintText:
                "Cari provinsi ${provinceType == PROVINCE_TYPE.Origin ? 'asal' : 'tujuan'} ...",
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(50.0))),
        onFind: (String filter) async {
          Uri url = Uri.parse("https://api.rajaongkir.com/starter/province");

          try {
            var response = await http
                .get(url, headers: {"key": "3d1df54e61885b04a6baec75fa1c15de"});

            var data = json.decode(response.body) as Map<String, dynamic>;

            var statusCode = data["rajaongkir"]["status"]["code"];

            if (statusCode != 200) {
              throw data["rajaongkir"]["status"]["description"];
            }

            var listOfProvince = data["rajaongkir"]["results"] as List<dynamic>;

            var models = ProvinceModel.fromJsonList(listOfProvince);

            return models!;
          } catch (error) {
            print(error);

            return List<ProvinceModel>.empty();
          }
        },
        itemAsString: (ProvinceModel provinceModel) =>
            provinceModel.province.toString(),
        onChanged: (provinceModel) {
          if (provinceModel != null) {
            if (this.provinceType == PROVINCE_TYPE.Origin) {
              controller.hiddenCityOrigin.value = false;
              controller.selectedProvinceIdOrigin.value =
                  int.parse(provinceModel.provinceId!);
            } else {
              controller.hiddenCityDestination.value = false;
              controller.selectedProvinceIdDestination.value =
                  int.parse(provinceModel.provinceId!);
            }
          } else {
            if (this.provinceType == PROVINCE_TYPE.Origin) {
              controller.hiddenCityOrigin.value = true;
              controller.selectedProvinceIdOrigin.value = 0;
            } else {
              controller.hiddenCityDestination.value = true;
              controller.selectedProvinceIdDestination.value = 0;
            }
          }

          controller.showCekOngkirButton();
        },
      ),
    );
  }
}
