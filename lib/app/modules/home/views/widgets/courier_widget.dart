import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ongkir/app/modules/home/controllers/home_controller.dart';
import 'package:get/state_manager.dart';

class CourierWidget extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: DropdownSearch<Map<String, dynamic>>(
        mode: Mode.BOTTOM_SHEET,
        showClearButton: true,
        showSearchBox: true,
        searchBoxDecoration: InputDecoration(
            labelText: "Cari kurir ...",
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            hintText: "Cari kurir ...",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(50.0))),
        items: [
          {"code": "jne", "name": "Jalur Nugraha Ekakurir (JNE)"},
          {"code": "tiki", "name": "Titipan Kilat (TIKI)"},
          {"code": "pos", "name": "Perusahaan Opsional Surat (POS)"}
        ],
        itemAsString: (item) => item["name"].toString(),
        label: "Kurir",
        onChanged: (item) {
          if (item != null) {
            controller.courierCode.value = item["code"];
          } else {
            controller.courierCode.value = "";
          }

          controller.showCekOngkirButton();
        },
      ),
    );
  }
}
