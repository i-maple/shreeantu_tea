import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:provider/provider.dart';
import 'package:shreeantu_tea/data/usecases/data_local.dart';
import 'package:shreeantu_tea/model/farmers_model.dart';
import 'package:shreeantu_tea/providers/quality_grade_provider.dart';
import 'package:velocity_x/velocity_x.dart';

class FarmerSearchDropdown extends StatefulWidget {
  const FarmerSearchDropdown({
    super.key,
  });

  @override
  State<FarmerSearchDropdown> createState() => FarmerSearchDropdownState();
}

class FarmerSearchDropdownState extends State<FarmerSearchDropdown> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<QualityGrade>(context);
    return FutureBuilder(
      future: DataLocal.instance.getAllFarmers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print(snapshot.data);
          if (snapshot.hasData) {
            var data = snapshot.data;
            return ListTile(
              leading: 'Farmer'.text.make(),
              title: DropdownButtonHideUnderline(
                child: DropdownButton2<Farmer>(
                  hint: Text(
                    'Select Item',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: data!
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: e!.name.text.make(),
                        ),
                      )
                      .toList(),
                  value: prov.currentFarmer,
                  onChanged: (value) {
                    prov.currentFarmer = value;
                  },
                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    height: 40,
                    width: 200,
                  ),
                  dropdownStyleData: const DropdownStyleData(
                    maxHeight: 200,
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                  ),
                  dropdownSearchData: DropdownSearchData(
                    searchController: textEditingController,
                    searchInnerWidgetHeight: 50,
                    searchInnerWidget: Container(
                      height: 50,
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 4,
                        right: 8,
                        left: 8,
                      ),
                      child: TextFormField(
                        expands: true,
                        maxLines: null,
                        controller: textEditingController,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          hintText: 'Select Farmer',
                          hintStyle: const TextStyle(fontSize: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    searchMatchFn: (item, searchValue) {
                      return item.value
                          .toString()
                          .toLowerCase()
                          .contains(searchValue.toLowerCase());
                    },
                  ),
                  onMenuStateChange: (isOpen) {
                    if (!isOpen) {
                      textEditingController.clear();
                    }
                  },
                ),
              ),
            );
          } else {
            return 'No farmers registered'.text.make();
          }
        }
        return const CircularProgressIndicator();
      },
    ).py8().color(
          Colors.grey.shade300.withOpacity(0.8),
        );
  }}
