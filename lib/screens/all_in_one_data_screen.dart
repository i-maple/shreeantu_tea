import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
import 'package:provider/provider.dart';
import 'package:shreeantu_tea/data/usecases/data_local.dart';
import 'package:shreeantu_tea/model/farmers_model.dart';
import 'package:shreeantu_tea/providers/quality_grade_provider.dart';
import 'package:shreeantu_tea/utils/snackbar_service.dart';
import 'package:shreeantu_tea/utils/utilities.dart';
import 'package:shreeantu_tea/widgets/ledger_widget.dart';
import 'package:shreeantu_tea/widgets/primary_button.dart';
import 'package:shreeantu_tea/widgets/search_dropdown.dart';
import 'package:velocity_x/velocity_x.dart';

class AllInOneDataScreen extends StatefulWidget {
  const AllInOneDataScreen({super.key});

  @override
  State<AllInOneDataScreen> createState() => _AllInOneDataScreenState();
}

class _AllInOneDataScreenState extends State<AllInOneDataScreen> {
  final TextEditingController _searchTypeController = TextEditingController();
  final TextEditingController _displayTypeController = TextEditingController();

  Future<List<Map<String, String>>> _futureToGetDatas =
      DataLocal.instance.getDataByType('Purchase');
  String displayValue = 'Purchase';

  late List<TextEditingController> controllers;

  List<TextEditingController> loadTextEditors() {
    final transactionType = Provider.of<QualityGrade>(context).transactionType;
    controllers = [];
    if (transactionType == null &&
        textFieldsForEachTitles[transactionType] == null) {
      SnackbarService.showFailedSnackbar(context, 'Failed selecting type');
      return [];
    }
    for (String field in textFieldsForEachTitles[transactionType]!) {
      controllers.add(TextEditingController(text: field));
    }
    return controllers;
  }

  addTransaction() async {
    final prov = Provider.of<QualityGrade>(context, listen: false);
    if (prov.date == null) {
      SnackbarService.showFailedSnackbar(context, 'Date Cannot Be Empty');
      return;
    }
    if (prov.transactionType == 'Purchase' && prov.currentFarmer == null) {
      SnackbarService.showFailedSnackbar(context, 'Select A Farmer');
      return;
    }
    if (controllers.isEmpty) {
      SnackbarService.showFailedSnackbar(
          context, 'Please Choose a Transaction Type');
      return;
    }
    Map<String, String> data = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'date': picker.NepaliDateTime.now().format('y-M-d'),
      'transactionType': prov.transactionType!,
    };
    for (var i = 0; i < controllers.length; i++) {
      data.addAllT({
        textFieldsForEachTitles[prov.transactionType]![i]: controllers[i].text,
      });
    }
    await DataLocal.instance.addDataByType(prov.transactionType!, data);
  }

  @override
  void dispose() {
    super.dispose();
    _searchTypeController.dispose();
    _displayTypeController.dispose();
    for (var controller in controllers) {
      controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VxResponsive(
        large: _twoRowEntryAndDisplay(),
        xlarge: _twoRowEntryAndDisplay(),
        medium: _twoRowEntryAndDisplay(),
        small: _tabWithSeparateEntryAndDisplay(),
        xsmall: _tabWithSeparateEntryAndDisplay(),
      ),
    );
  }

  _twoRowEntryAndDisplay() {
    return VxTwoRow(
      left: _getLedger(),
      right: _entryForm().expand(),
    ).p20();
  }

  Widget _getLedger() {
    return SizedBox(
      width: 900,
      child: Column(
        children: [
          ListTile(
            leading: 'Transaction Type'.text.make(),
            title: _chooseDropdown<String>(
              hint: 'Choose a Type',
              items: titles
                  .map(
                    (e) => DropdownMenuItem<String>(
                      value: e,
                      child: e.text.make(),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _futureToGetDatas = DataLocal.instance.getDataByType(value!);
                  displayValue = value;
                });
              },
              value: displayValue,
            ),
          ),
          LedgerWidget(
            future: _futureToGetDatas,
            headers: [...Farmer.props, 'jfkk'],
          ).expand(),
        ],
      ),
    );
  }

  _tabWithSeparateEntryAndDisplay() {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(
                text: 'See Details',
              ),
              Tab(
                text: 'Enter Data',
              ),
            ],
          ),
          TabBarView(
            children: [
              _getLedger(),
              _entryForm(),
            ],
          ).expand(),
        ],
      ),
    ).p20();
  }

  _ledger(Future future, List<String> headers) {
    return Column(
      children: [
        LedgerWidget(future: future, headers: headers).expand(),
      ],
    );
  }

  Widget _entryForm() {
    final prov = Provider.of<QualityGrade>(context);
    return Form(
      child: Column(
        children: [
          _pickDate(),
          _chooseDropdown<String>(
            hint: 'Select Transaction Type',
            value: prov.transactionType,
            onChanged: (val) => prov.transactionType = val,
            controller: _searchTypeController,
            items: titles
                .map(
                  (e) => DropdownMenuItem<String>(
                    value: e,
                    child: e.text.make(),
                  ),
                )
                .toList(),
          ),
          const FarmerSearchDropdown(),
          ...(prov.transactionType != null
              ? loadTextEditors()
                  .map(
                    (e) => _commonTextField(
                            controller: e, labelText: e.text, hint: e.text)
                        .py8(),
                  )
                  .toList()
              : [
                  const SizedBox(),
                ]),
          prov.transactionType != null
              ? PrimaryButton(
                  onTap: addTransaction,
                  color: Colors.green,
                  child: 'Add'.text.bold.size(18).white.make(),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  _grayWrapper(Widget widget) {
    return ListTile(
      title: widget,
    ).color(Colors.grey.shade300.withOpacity(0.8)).py8();
  }

  Widget _commonTextField({
    String? labelText,
    String? hint,
    TextEditingController? controller,
  }) {
    print(controllers);
    return VxTextField(
      labelText: labelText,
      hint: hint,
      controller: controller,
      contentPaddingLeft: 15,
    );
  }

  _pickDate() {
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

  _chooseDropdown<T>(
      {String? hint,
      List<DropdownMenuItem<T>>? items,
      T? value,
      void Function(T?)? onChanged,
      TextEditingController? controller}) {
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
