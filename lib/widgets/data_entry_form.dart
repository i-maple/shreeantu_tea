import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
import 'package:provider/provider.dart';
import 'package:shreeantu_tea/model/data_entry.dart';
import 'package:shreeantu_tea/providers/quality_grade_provider.dart';
import 'package:shreeantu_tea/utils/colors.dart';
import 'package:shreeantu_tea/widgets/primary_button.dart';
import 'package:shreeantu_tea/widgets/search_dropdown.dart';
import 'package:velocity_x/velocity_x.dart';

class DataEntryForm extends StatelessWidget {
  const DataEntryForm(
      {super.key, required this.fields, required this.onSubmit});

  final List<DataEntry> fields;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<QualityGrade>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        'Data Entry'.text.bold.size(16).make().py20(),
        ...fields.map(
          (e) {
            if (e.textController != null) {
              return VxTextField(
                hint: e.hint,
                contentPaddingLeft: 20,
                controller: e.textController,
              ).py8();
            } else if (e.needDate) {
              return ListTile(
                title: (prov.date == null
                        ? 'Select Date'
                        : prov.date!.format('y/M/d'))
                    .text
                    .semiBold
                    .size(16)
                    .make(),
                onTap: () async {
                  picker.NepaliDateTime? pickedDate =
                      await picker.showMaterialDatePicker(
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
            } else if (e.searchDropdown) {
              return const SearchDropdown();
            } else {
              return ListTile(
                title: DropdownButton(
                  hint: Text(e.hint),
                  value: prov.currentValue,
                  items: e.dropdownValues
                      ?.map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (value) {
                    prov.currentValue = value;
                  },
                ),
              ).py8().color(Colors.grey.shade300.withOpacity(0.8));
            }
          },
        ),
        PrimaryButton(
          onTap: onSubmit,
          color: Colors.green,
          child:
              'Add'.text.size(16).bold.color(AppColors.primaryTextColor).make(),
        ).py12()
      ],
    ).p20().scrollVertical();
  }
}
