import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shreeantu_tea/data/usecases/data_local.dart';
import 'package:shreeantu_tea/forms/form_fields.dart';
import 'package:shreeantu_tea/model/farmers_model.dart';
import 'package:shreeantu_tea/providers/quality_grade_provider.dart';
import 'package:shreeantu_tea/utils/snackbar_service.dart';
import 'package:shreeantu_tea/widgets/primary_button.dart';
import 'package:velocity_x/velocity_x.dart';

class PurchaseForm extends StatefulWidget {
  const PurchaseForm({super.key});

  @override
  State<PurchaseForm> createState() => _PurchaseFormState();
}

class _PurchaseFormState extends State<PurchaseForm> {
  late TextEditingController _farmerSearch,
      _billNumber,
      _quantity,
      _amount,
      _rateController,
      _qualityGrade;

  @override
  void initState() {
    super.initState();
    _farmerSearch = TextEditingController();
    _billNumber = TextEditingController();
    _quantity = TextEditingController();
    _amount = TextEditingController();
    _rateController = TextEditingController();
    _qualityGrade = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _farmerSearch = TextEditingController();
    _billNumber.dispose();
    _qualityGrade.dispose();
    _quantity.dispose();
    _amount.dispose();
    _rateController.dispose();
  }

  Future<void> addPurchase() async {
    final prov = Provider.of<QualityGrade>(context, listen: false);

    if (prov.currentFarmer == null) {
      SnackbarService.showFailedSnackbar(context, 'Select a farmer');
      return;
    }
    if (prov.date == null) {
      SnackbarService.showFailedSnackbar(context, 'Select a date');
      return;
    }
    if ((!_billNumber.text.isNotBlank)) {
      SnackbarService.showFailedSnackbar(context, 'Enter a bill Number');
      return;
    }
    if ((!_amount.text.isNotBlank) && !(_quantity.text.isNotBlank)) {
      SnackbarService.showFailedSnackbar(context, 'Enter amount and quantity');
      return;
    }
    if (!(_qualityGrade.text.isNotBlank)) {
      SnackbarService.showFailedSnackbar(context, 'Enter quality grade');
      return;
    }

    final Map<String, dynamic> data = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'date': prov.date!.format('y-M-d').toString(),
      'name': prov.currentFarmer!.toMap(),
      'billNumber': _billNumber.text,
      'quantity': _quantity.text.isNotBlank ? _quantity.text : 0,
      'rate': _rateController.text,
      'amount': _amount.text.isNotBlank ? _amount.text : 0,
      'qualityGrade': _qualityGrade.text,
    };

    String response= await DataLocal.instance.addDataByType('Purchase', data);
    if(response == 'success' && mounted){
      SnackbarService.showSuccessSnackbar(context, 'Done');
    }
    else{
      if(mounted){
      SnackbarService.showFailedSnackbar(context, response);   
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        'Add a purchase'.text.xl.bold.make(),
        FormFields.pickDate(context),
        FormFields.commonTextField(
            controller: _billNumber, labelText: 'Bill Number'),
        FutureBuilder(
            future: DataLocal.instance.getAllFarmers(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return FormFields.grayWrapper(
                  FormFields.chooseDropdown<Farmer>(
                    context,
                    controller: _farmerSearch,
                    hint: 'Search Farmer',
                    value: Provider.of<QualityGrade>(
                      context,
                    ).currentFarmer,
                    items: snapshot.data!
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e!.name),
                            ))
                        .toList(),
                    onChanged: (p0) =>
                        Provider.of<QualityGrade>(context, listen: false)
                            .currentFarmer = p0,
                  ),
                );
              }
              return const CircularProgressIndicator();
            }),
        FormFields.commonTextField(
          controller: _quantity,
          labelText: 'Quantity',
          onChanged: (value) {
            if (_amount.text.isNotEmpty) {
              double qty = double.tryParse(value ?? '') ?? 1;
              double amt = double.tryParse(_amount.text) ?? 0;
              _rateController.text = (amt / qty).toString();
            }
          },
        ),
        FormFields.commonTextField(
            controller: _amount,
            labelText: 'Amount',
            onChanged: (value) {
              if (_quantity.text.isNotEmpty) {
                double qty = double.tryParse(_quantity.text) ?? 1;
                double amt = double.tryParse(value ?? '0') ?? 0;
                _rateController.text = (amt / qty).toString();
              }
            }),
        FormFields.commonTextField(
          controller: _qualityGrade,
          labelText: 'Quality Grade',
        ),
        FormFields.commonTextField(
          controller: _rateController,
          labelText: 'Rate',
          disabled: true,
        ),
        PrimaryButton(
            onTap: addPurchase,
            color: Colors.green,
            child: 'Purchase'.text.lg.bold.white.make())
      ],
    ).scrollVertical().expand();
  }
}
