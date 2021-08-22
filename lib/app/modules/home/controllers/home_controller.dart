import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ongkir/app/modules/home/courier_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  var hiddenCityOrigin = true.obs;
  var hiddenCityDestination = true.obs;

  var selectedProvinceIdOrigin = 0.obs;
  var selectedProvinceIdDestination = 0.obs;

  var selectedCityIdOrigin = 0.obs;
  var selectedCityIdDestination = 0.obs;

  var courierCode = "".obs;

  double weightOfThings = 0.0;
  String satuanBerat = "gram";

  late TextEditingController weightController;

  var hiddenCekOngkirButton = true.obs;

  void changeWeightOfThings(String weight) {
    weightOfThings = double.tryParse(weight) ?? 0.0;

    String currentSatuan = satuanBerat;

    switch (currentSatuan) {
      case "ton":
        weightOfThings = weightOfThings * 1000000;
        break;
      case "kwintal":
        weightOfThings = weightOfThings * 100000;
        break;
      case "ons":
        weightOfThings = weightOfThings * 100;
        break;
      case "lbs":
        weightOfThings = weightOfThings * 2204.62;
        break;
      case "pound":
        weightOfThings = weightOfThings * 2204.62;
        break;
      case "kg":
        weightOfThings = weightOfThings * 1000;
        break;
      case "hg":
        weightOfThings = weightOfThings * 100;
        break;
      case "dag":
        weightOfThings = weightOfThings * 10;
        break;
      case "gram":
        weightOfThings = weightOfThings;
        break;
      case "dg":
        weightOfThings = weightOfThings / 10;
        break;
      case "cg":
        weightOfThings = weightOfThings / 100;
        break;
      case "mg":
        weightOfThings = weightOfThings / 1000;
        break;
      default:
        weightOfThings = weightOfThings;
    }

    print(weightOfThings);
  }

  void changeSatuanBerat(String? satuanBerat) {
    weightOfThings = double.tryParse(weightController.text) ?? 0.0;

    switch (satuanBerat) {
      case "ton":
        weightOfThings = weightOfThings * 1000000;
        break;
      case "kwintal":
        weightOfThings = weightOfThings * 100000;
        break;
      case "ons":
        weightOfThings = weightOfThings * 100;
        break;
      case "lbs":
        weightOfThings = weightOfThings * 2204.62;
        break;
      case "pound":
        weightOfThings = weightOfThings * 2204.62;
        break;
      case "kg":
        weightOfThings = weightOfThings * 1000;
        break;
      case "hg":
        weightOfThings = weightOfThings * 100;
        break;
      case "dag":
        weightOfThings = weightOfThings * 10;
        break;
      case "gram":
        weightOfThings = weightOfThings;
        break;
      case "dg":
        weightOfThings = weightOfThings / 10;
        break;
      case "cg":
        weightOfThings = weightOfThings / 100;
        break;
      case "mg":
        weightOfThings = weightOfThings / 1000;
        break;
      default:
        weightOfThings = weightOfThings;
    }

    this.satuanBerat = satuanBerat!;

    print(weightOfThings);
  }

  void showCekOngkirButton() {
    if (selectedProvinceIdOrigin != 0 &&
        selectedProvinceIdDestination != 0 &&
        selectedCityIdOrigin != 0 &&
        selectedCityIdDestination != 0 &&
        weightOfThings > 0.0 &&
        courierCode != "") {
      hiddenCekOngkirButton.value = false;
    } else {
      hiddenCekOngkirButton.value = true;
    }
  }

  void getOngkir() async {
    Uri url = Uri.parse("https://api.rajaongkir.com/starter/cost");

    try {
      final response = await http.post(url, body: {
        "origin": "${this.selectedCityIdOrigin}",
        "destination": "${this.selectedCityIdDestination}",
        "weight": "${this.weightOfThings}",
        "courier": "${this.courierCode}"
      }, headers: {
        "key": "3d1df54e61885b04a6baec75fa1c15de",
        "content-type": "application/x-www-form-urlencoded"
      });

      var responseData = json.decode(response.body) as Map<String, dynamic>;

      var results = responseData["rajaongkir"]["results"];

      var listOfCourierServices = CourierModel.fromJsonList(results);

      var courier = listOfCourierServices![0];

      Random random = Random();

      Get.defaultDialog(
          title: courier.name!,
          content: Column(
              children: courier.costs!
                  .map((e) => ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Color.fromARGB(
                              random.nextInt(256),
                              random.nextInt(256),
                              random.nextInt(256),
                              random.nextInt(256)),
                        ),
                        title: Text("${e.service}"),
                        subtitle:
                            courier.code == "jne" || courier.code == "tiki"
                                ? Text("${e.cost![0].etd} HARI")
                                : Text("${e.cost![0].etd}"),
                        trailing: Text("Rp ${e.cost![0].value}"),
                      ))
                  .toList()));
    } catch (error) {
      print(error);

      Get.defaultDialog(title: "Error", middleText: error.toString());
    }
  }

  @override
  void onInit() {
    weightController = TextEditingController(text: "$weightOfThings");
    super.onInit();
  }

  @override
  void onClose() {
    weightController.dispose();
    super.onClose();
  }
}
