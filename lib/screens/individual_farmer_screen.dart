import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shreeantu_tea/data/usecases/data_local.dart';
import 'package:shreeantu_tea/model/data_entry.dart';
import 'package:shreeantu_tea/providers/quality_grade_provider.dart';
import 'package:shreeantu_tea/utils/colors.dart';
import 'package:shreeantu_tea/utils/snackbar_service.dart';
import 'package:shreeantu_tea/widgets/data_entry_form.dart';
import 'package:shreeantu_tea/widgets/farmers_list.dart';
import 'package:velocity_x/velocity_x.dart';

class IndividualFarmerScreen extends StatefulWidget {
  const IndividualFarmerScreen({
    super.key,
  });

  @override
  State<IndividualFarmerScreen> createState() => _IndividualFarmerScreenState();
}

class _IndividualFarmerScreenState extends State<IndividualFarmerScreen> {
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _priceController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _priceController.dispose();
  }

  makePayment() async {
    final prov = Provider.of<QualityGrade>(context, listen: false);
    if (double.tryParse(_priceController.text) == 0 ||
        double.tryParse(_priceController.text) == null) {
      SnackbarService.showFailedSnackbar(
          context, 'Amount should be only number and not empty');
      return;
    }
    if (prov.currentFarmer == null) {
      SnackbarService.showFailedSnackbar(context, 'Please Select A farmer');
      return;
    }
    if (prov.date == null) {
      SnackbarService.showFailedSnackbar(context, 'Please Select A date');
      return;
    }
    String res = await DataLocal.instance.makePaymentToFarmers(
        prov.currentFarmer!, double.parse(_priceController.text), prov.date!);
    if (mounted) {
      if (res == 'success') {
        SnackbarService.showSuccessSnackbar(
            context, 'successfully made payment');
        _priceController.clear();
        prov.reset();
        return;
      } else {
        SnackbarService.showFailedSnackbar(context, res);
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: MediaQuery.sizeOf(context).width > 600
            ? 'Farmer Details'.text.color(AppColors.primaryTextColor).make()
            : null,
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),
      body: size.width > 1190
          ? VxTwoRow(
              left: const SizedBox(
                width: 920,
                child: FarmersList(),
              ),
              right: _dataEntryMethod().expand(),
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
                const SizedBox(
                  width: 920,
                  child: FarmersList(),
                ),
                _dataEntryMethod(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dataEntryMethod() {
    return DataEntryForm(
      fields: [
        DataEntry(
          hint: 'Date',
          needDate: true,
        ),
        DataEntry(
          hint: 'Amount Paid',
          textController: _priceController,
        ),
        DataEntry(
          hint: 'Name',
          searchDropdownType: 'farmer',
        ),
      ],
      onSubmit: makePayment,
    );
  }
}
