import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shreeantu_tea/providers/quality_grade_provider.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:shreeantu_tea/data/usecases/data_local.dart';
import 'package:shreeantu_tea/model/purchase_model.dart';
import 'package:shreeantu_tea/utils/colors.dart';
import 'package:shreeantu_tea/utils/snackbar_service.dart';

import '../model/data_entry.dart';
import '../widgets/data_entry_form.dart';
import '../widgets/main.dart';

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

  resetFields() {
    _nameController.clear();
    _quantityController.clear();
    _billNumberController.clear();
    _amountController.clear();
    Provider.of<QualityGrade>(context).date = null;
    Provider.of<QualityGrade>(context).currentValue = null;
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

  addPurchase() async {
    final prov = Provider.of<QualityGrade>(context, listen: false);
    if (_nameController.text.isNotEmptyAndNotNull &&
        _quantityController.text.isNotEmptyAndNotNull &&
        _billNumberController.text.isNotEmptyAndNotNull &&
        _amountController.text.isNotEmptyAndNotNull &&
        prov.currentValue != null &&
        prov.date != null) {
      if (double.tryParse(_quantityController.text) == null ||
          double.tryParse(_amountController.text) == null) {
        SnackbarService.showFailedSnackbar(
          context,
          'Amount or quantity should be number',
        );
        return;
      }
      Purchase data = Purchase(
        name: _nameController.text,
        date: prov.date!,
        quantity: double.parse(_quantityController.text),
        amount: double.parse(_amountController.text),
        billNumber: _billNumberController.text,
        qualityGrade: prov.currentValue!,
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

  get fields => [
        DataEntry(
          hint: 'Date',
          needDate: true,
        ),
        DataEntry(
          hint: 'Bill Number',
          textController: _billNumberController,
        ),
        DataEntry(
          hint: 'Name',
          textController: _nameController,
        ),
        DataEntry(
          hint: 'Quantity',
          textController: _quantityController,
        ),
        DataEntry(
          hint: 'Amount',
          textController: _amountController,
        ),
        DataEntry(
          hint: 'Quality Grade',
          dropdownValues: ['A', 'B', 'C'],
        )
      ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: MediaQuery.sizeOf(context).width > 600
            ? 'Purchase'.text.color(AppColors.primaryTextColor).make()
            : null,
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),
      body: size.width > 1190
          ? VxTwoRow(
              left: SizedBox(
                width: 920,
                child: LedgerWidget(
                  future: DataLocal.instance.getAllPurchases(),
                  headers: [
                    ...Purchase.props,
                    'Total',
                  ],
                ),
              ),
              right: DataEntryForm(
                fields: fields,
                onSubmit: addPurchase,
              ).expand(),
            )
          : _tabbed(),
    );
  }

  _tabbed() {
    return DefaultTabController(
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
                SizedBox(
                  width: 920,
                  child: LedgerWidget(
                    future: DataLocal.instance.getAllPurchases(),
                    headers: [
                      ...Purchase.props,
                      'Total',
                    ],
                  ),
                ),
                DataEntryForm(
                  fields: fields,
                  onSubmit: addPurchase,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
