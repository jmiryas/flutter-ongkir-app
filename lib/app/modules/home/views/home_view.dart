import 'package:flutter/material.dart';
import 'package:flutter_ongkir/app/modules/home/views/widgets/city_widget.dart';
import 'package:flutter_ongkir/app/modules/home/views/widgets/courier_widget.dart';
import 'package:flutter_ongkir/app/modules/home/views/widgets/province_widget.dart';
import 'package:flutter_ongkir/app/modules/home/views/widgets/weight_widget.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../utils/province_type.dart';
import '../utils/city_type.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ONGKIR INDONESIA'),
        centerTitle: true,
        backgroundColor: Colors.red[900],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(20.0),
          children: [
            ProvinceWidget(
              provinceType: PROVINCE_TYPE.Origin,
            ),
            Obx(() => controller.hiddenCityOrigin.value
                ? SizedBox(
                    width: 0.0,
                    height: 0.0,
                  )
                : CityWidget(
                    provinceId: controller.selectedProvinceIdOrigin.value,
                    cityType: CITY_TYPE.Origin,
                  )),
            ProvinceWidget(
              provinceType: PROVINCE_TYPE.Destination,
            ),
            Obx(() => controller.hiddenCityDestination.value
                ? SizedBox(
                    width: 0.0,
                    height: 0.0,
                  )
                : CityWidget(
                    provinceId: controller.selectedProvinceIdDestination.value,
                    cityType: CITY_TYPE.Destination,
                  )),
            WeightWidget(),
            CourierWidget(),
            Obx(() => controller.hiddenCekOngkirButton.value
                ? SizedBox(
                    width: 0.0,
                    height: 0.0,
                  )
                : ElevatedButton(
                    onPressed: () {
                      controller.getOngkir();
                    },
                    child: Text("CEK ONGKIR"),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.red[900],
                        padding: EdgeInsets.symmetric(vertical: 20.0)),
                  ))
          ],
        ),
      ),
    );
  }
}
