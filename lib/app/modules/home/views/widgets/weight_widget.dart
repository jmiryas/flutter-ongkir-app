import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ongkir/app/modules/home/controllers/home_controller.dart';
import 'package:get/state_manager.dart';

class WeightWidget extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            autocorrect: false,
            controller: controller.weightController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
                labelText: "Berat Barang",
                hintText: "Masukkan berat barang",
                border: OutlineInputBorder()),
            onChanged: (beratBarang) {
              controller.changeWeightOfThings(beratBarang);
              controller.showCekOngkirButton();
            },
          )),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: DropdownSearch<String>(
              mode: Mode.BOTTOM_SHEET,
              showSelectedItem: true,
              showSearchBox: true,
              searchBoxDecoration: InputDecoration(
                  labelText: "Satuan Berat",
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  hintText: "Cari satuan berat ...",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0))),
              items: [
                "ton",
                "kwintal",
                "ons",
                "pound",
                "kg",
                "hg",
                "dag",
                "gram",
                "dg",
                "cg",
                "mg",
                "lbs"
              ],
              label: "Satuan Berat",
              selectedItem: "gram",
              onChanged: (satuanBerat) {
                controller.changeSatuanBerat(satuanBerat);
                controller.showCekOngkirButton();
              },
            ),
          )
        ],
      ),
    );
  }
}
