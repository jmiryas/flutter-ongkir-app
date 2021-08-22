import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ongkir/app/modules/home/city_model.dart';
import 'package:flutter_ongkir/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';

import '../../utils/city_type.dart';

class CityWidget extends GetView<HomeController> {
  final provinceId;
  final CITY_TYPE cityType;

  CityWidget({required this.provinceId, required this.cityType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: DropdownSearch<CityModel>(
        label: "Kota ${cityType == CITY_TYPE.Origin ? 'Asal' : 'Tujuan'}",
        showClearButton: true,
        showSearchBox: true,
        searchBoxDecoration: InputDecoration(
            hintText:
                "Cari kabupaten / kota ${cityType == CITY_TYPE.Origin ? 'asal' : 'tujuan'} ...",
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(50.0))),
        onFind: (String filter) async {
          Uri url = Uri.parse(
              "https://api.rajaongkir.com/starter/city?province=$provinceId");

          try {
            var response = await http
                .get(url, headers: {"key": "3d1df54e61885b04a6baec75fa1c15de"});

            var data = json.decode(response.body) as Map<String, dynamic>;

            var statusCode = data["rajaongkir"]["status"]["code"];

            if (statusCode != 200) {
              throw data["rajaongkir"]["status"]["description"];
            }

            var listOfCity = data["rajaongkir"]["results"] as List<dynamic>;

            var models = CityModel.fromJsonList(listOfCity);

            return models!;
          } catch (error) {
            print(error);

            return List<CityModel>.empty();
          }
        },
        itemAsString: (CityModel cityModel) =>
            "${cityModel.type} - ${cityModel.cityName}",
        onChanged: (CityModel? cityModel) {
          if (cityModel != null) {
            if (this.cityType == CITY_TYPE.Origin) {
              controller.selectedCityIdOrigin.value =
                  int.parse(cityModel.cityId!);
              print("City id origin: ${controller.selectedCityIdOrigin.value}");
            } else {
              controller.selectedCityIdDestination.value =
                  int.parse(cityModel.cityId!);
              print(
                  "City id destination: ${controller.selectedCityIdDestination.value}");
            }
          } else {
            if (this.cityType == CITY_TYPE.Origin) {
              controller.selectedCityIdOrigin.value = 0;
            } else {
              controller.selectedCityIdDestination.value = 0;
            }
          }

          controller.showCekOngkirButton();
        },
      ),
    );
  }
}
