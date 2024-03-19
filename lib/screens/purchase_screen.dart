import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
import 'package:shreeantu_tea/data/usecases/data_local.dart';
import 'package:shreeantu_tea/model/purchase_model.dart';
import 'package:shreeantu_tea/utils/colors.dart';
import 'package:shreeantu_tea/utils/snackbar_service.dart';
import 'package:shreeantu_tea/widgets/primary_button.dart';
import 'package:velocity_x/velocity_x.dart';

class PurchaseScreen extends StatefulWidget {
  const PurchaseScreen({super.key});

  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  late TextEditingController _nameController,
      _quantityController,
      _billNumberController,
      _amountController;

  picker.NepaliDateTime? dateController;

  resetFields() {
    _nameController.clear();
    _quantityController.clear();
    _billNumberController.clear();
    _amountController.clear();
    setState(() {
      dateController = null;
    });
  }

  addPurchase() async {
    if (_nameController.text.isNotEmptyAndNotNull ||
        _quantityController.text.isNotEmptyAndNotNull ||
        _billNumberController.text.isNotEmptyAndNotNull ||
        _amountController.text.isNotEmptyAndNotNull ||
        dateController != null) {
      if (double.tryParse(_quantityController.text) == null ||
          double.tryParse(_amountController.text) == null) {
        SnackbarService.showFailedSnackbar(
          context,
          'Amount or quantity should be number',
        );
        return;
      }
      Purchase data = Purchase(
        id: '1',
        name: _nameController.text,
        date: dateController!,
        quantity: double.parse(_quantityController.text),
        amount: double.parse(_amountController.text),
        billNumber: _billNumberController.text,
      );

      String response = await DataLocal.instance.addPurchase(data: data);
      if (mounted) {
        if (response == 'success') {
          SnackbarService.showSuccessSnackbar(
              context, 'Successfully Added Purchase');
          resetFields();
        } else {
          SnackbarService.showFailedSnackbar(context, response);
        }
      }
    }
    if (mounted) {
      SnackbarService.showFailedSnackbar(context, 'No fields can be empty');
    }
    return;
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _quantityController = TextEditingController();
    _billNumberController = TextEditingController();
    _amountController = TextEditingController();
  }

  @override
  dispose() {
    super.dispose();
    _nameController.dispose();
    _quantityController.dispose();
    _amountController.dispose();
    _billNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MediaQuery.sizeOf(context).width > 600
            ? 'Purchase'.text.color(AppColors.primaryTextColor).make()
            : null,
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),
      body: VxResponsive(
        medium: VxTwoRow(
          left: _dataTableColumn(),
          right: _dataEntryForm().expand(),
        ),
        xsmall: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              const TabBar(
                tabs: [
                  Tab(
                    text: 'View Data Table',
                  ),
                  Tab(
                    text: 'Add New Entry',
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _dataTableColumn(),
                    _dataEntryForm(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dataEntryForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        'Please Add Your Expense'.text.bold.size(16).make().py20(),
        ListTile(
          title: (dateController == null
                  ? 'Select Date'
                  : dateController!.format('y/M/d'))
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
              setState(() {
                dateController = pickedDate;
              });
            }
          },
        ).color(Colors.grey.shade300.withOpacity(0.8)).py8(),
        VxTextField(
          hint: 'Bill Number',
          contentPaddingLeft: 20,
          controller: _billNumberController,
        ).py8(),
        VxTextField(
          hint: 'Name Of Farmer',
          contentPaddingLeft: 20,
          controller: _nameController,
        ).py8(),
        VxTextField(
          hint: 'Quantity',
          contentPaddingLeft: 20,
          controller: _quantityController,
        ).py8(),
        VxTextField(
          hint: 'Amount',
          contentPaddingLeft: 20,
          controller: _amountController,
        ).py8(),
        PrimaryButton(
          onTap: addPurchase,
          color: Colors.green,
          child:
              'Add'.text.size(16).bold.color(AppColors.primaryTextColor).make(),
        ).py12()
      ],
    ).p20();
  }

  Widget _dataTableColumn() {
    return FutureBuilder(
        future: DataLocal.instance.getAllPurchases(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              var datas = snapshot.data;
              List<List<String>> lists = [];
              for (var data in datas!) {
                List<String> subList = [];
                subList.add(data['id']);
                subList.add(data['name']);
                subList.add(data['date'].toString());
                subList.add(data['quantity'].toString());
                subList.add(data['amount'].toString());
                subList.add((data['amount'] * data['quantity']).toString());
                subList.add(data['billNumber'] ?? '');
                lists.add(subList);
              }
              return DataTable(
                columns: [...Purchase.props, 'Total', 'Action']
                    .map(
                      (e) => DataColumn(
                        label: Text(e.toUpperCase()),
                        tooltip: e,
                      ),
                    )
                    .toList(),
                rows: lists
                    .map((e) => DataRow(
                          cells: e
                              .map(
                                (e) => DataCell(
                                  Text(e.toString()),
                                ),
                              )
                              .toList(),
                        ))
                    .toList(),
              ).scrollHorizontal().scrollVertical().p20();
            } else {
              return 'No Datas Yet'.text.make();
            }
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
