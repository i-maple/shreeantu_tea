import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shreeantu_tea/data/usecases/data_local.dart';
import 'package:shreeantu_tea/forms/form_fields.dart';
import 'package:shreeantu_tea/model/party_model.dart';
import 'package:shreeantu_tea/providers/quality_grade_provider.dart';
import 'package:shreeantu_tea/utils/snackbar_service.dart';
import 'package:shreeantu_tea/widgets/primary_button.dart';
import 'package:velocity_x/velocity_x.dart';

class SaleForm extends StatefulWidget {
  const SaleForm({super.key});

  @override
  State<SaleForm> createState() => _SaleFormState();
}

class _SaleFormState extends State<SaleForm> {
  late TextEditingController _partySearch,
      _invoiceNumber,
      _quantity,
      _amount,
      _rateController;

  @override
  void initState() {
    super.initState();
    _partySearch = TextEditingController();
    _invoiceNumber = TextEditingController();
    _quantity = TextEditingController();
    _amount = TextEditingController();
    _rateController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _partySearch.dispose();
    _invoiceNumber.dispose();
    _quantity.dispose();
    _amount.dispose();
    _rateController.dispose();
  }

  Future<void> addSale() async {
    final prov = Provider.of<QualityGrade>(context, listen: false);

    if (_partySearch.text.isEmpty) {
      SnackbarService.showFailedSnackbar(context, 'Select a party');
      return;
    }
    if (prov.date == null) {
      SnackbarService.showFailedSnackbar(context, 'Select a date');
      return;
    }
    if ((!_invoiceNumber.text.isNotBlank)) {
      SnackbarService.showFailedSnackbar(context, 'Enter a invoice Number');
      return;
    }
    if ((!_amount.text.isNotBlank) && !(_quantity.text.isNotBlank)) {
      SnackbarService.showFailedSnackbar(context, 'Enter amount and quantity');
      return;
    }

    final Map<String, dynamic> data = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'date': prov.date!.format('y-M-d').toString(),
      'Party Name': _partySearch.text,
      'invoiceNumber': _invoiceNumber.text,
      'quantity': _quantity.text.isNotBlank ? _quantity.text : 0,
      'rate': _rateController.text,
      'amount': _amount.text.isNotBlank ? _amount.text : 0,
    };

    String response = await DataLocal.instance.addDataByType('Sale', data);
    if (response == 'success' && mounted) {
      SnackbarService.showSuccessSnackbar(context, 'Done');
      final double preAmount = await DataLocal.instance.getAmount();
      double newAmt = preAmount + (double.tryParse(_amount.text) ?? 0);
      await DataLocal.instance.updateAmount(newAmt);
      prov.reset();
      _partySearch.clear();
      _amount.clear();
      _rateController.clear();
      _quantity.clear();
      _invoiceNumber.clear();
    } else {
      if (mounted) {
        SnackbarService.showFailedSnackbar(context, response);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        'Add a Sale'.text.xl.bold.make(),
        FormFields.pickDate(context),
        FormFields.commonTextField(
            controller: _invoiceNumber, labelText: 'Bill Number'),
        FormFields.commonTextField(
          controller: _partySearch,
          hint: 'Party Name',
        ),
        FormFields.commonTextField(
          controller: _quantity,
          labelText: 'Quantity',
          onChanged: (value) {
            if (_amount.text.isNotEmpty) {
              double qty = double.tryParse(value ?? '') ?? 1;
              double rate = double.tryParse(_rateController.text) ?? 0;
              _amount.text = (rate * qty).toString();
            }
          },
        ),
        FormFields.commonTextField(
          controller: _rateController,
          labelText: 'Rate',
          onChanged: (value) {
              if (_quantity.text.isNotEmpty) {
                double qty = double.tryParse(_quantity.text) ?? 1;
                double rate = double.tryParse(value ?? '0') ?? 0;
                _amount.text = (rate * qty).toString();
              }
            }
        ),
        FormFields.commonTextField(
            controller: _amount,
            labelText: 'Amount',
            disabled : true,
            ),
        PrimaryButton(
            onTap: addSale,
            color: Colors.green,
            child: 'Purchase'.text.lg.bold.white.make())
      ],
    ).scrollVertical().expand();
  }
}
