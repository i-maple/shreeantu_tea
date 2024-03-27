import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
import 'package:provider/provider.dart';
import 'package:shreeantu_tea/providers/quality_grade_provider.dart';
import 'package:velocity_x/velocity_x.dart';

class FormFields {
  FormFields._();

  static Widget grayWrapper(Widget widget) {
    return ListTile(
      title: widget,
    ).color(Colors.grey.shade300.withOpacity(0.8)).py8();
  }

  static Widget commonTextField({
    String? labelText,
    String? hint,
    TextEditingController? controller,
  }) {
    return VxTextField(
      labelText: labelText,
      hint: hint,
      controller: controller,
      contentPaddingLeft: 15,
    );
  }

  static Widget pickDate(BuildContext context) {
    final prov = Provider.of<QualityGrade>(context);
    return ListTile(
      title: (prov.date == null ? 'Select Date' : prov.date!.format('y/M/d'))
          .text
          .semiBold
          .size(16)
          .make(),
      onTap: () async {
        picker.NepaliDateTime? pickedDate = await picker.showMaterialDatePicker(
          context: context,
          initialDate: picker.NepaliDateTime.now(),
          firstDate: picker.NepaliDateTime(2078),
          lastDate: picker.NepaliDateTime(2085),
        );
        if (pickedDate != null) {
          prov.date = pickedDate;
        }
      },
    ).color(Colors.grey.shade300.withOpacity(0.8)).py8();
  }

  static Widget chooseDropdown<T>(
    BuildContext context, {
    String? hint,
    List<DropdownMenuItem<T>>? items,
    T? value,
    void Function(T?)? onChanged,
    TextEditingController? controller,
  }) {
    return ListTile(
      title: DropdownButtonHideUnderline(
        child: DropdownButton2<T>(
          hint: Text(
            hint ?? '',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).hintColor,
            ),
          ),
          items: items,
          value: value,
          onChanged: onChanged,
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
            searchController: controller,
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
                controller: controller,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  hintText: hint,
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
              controller?.clear();
            }
          },
        ),
      ),
    );
  }
}
