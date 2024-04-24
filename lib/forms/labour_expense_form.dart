import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shreeantu_tea/data/usecases/data_local.dart';
import 'package:shreeantu_tea/forms/form_fields.dart';
import 'package:shreeantu_tea/model/labour_model.dart';
import 'package:shreeantu_tea/providers/quality_grade_provider.dart';
import 'package:shreeantu_tea/utils/snackbar_service.dart';
import 'package:shreeantu_tea/widgets/primary_button.dart';
import 'package:velocity_x/velocity_x.dart';

class LabourExpenseForm extends StatefulWidget {
  const LabourExpenseForm({super.key});

  @override
  State<LabourExpenseForm> createState() => _LabourExpenseFormState();
}

class _LabourExpenseFormState extends State<LabourExpenseForm> {
  late TextEditingController _name, _hourWorked, _amount, _ot, _totalAmount;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    _hourWorked = TextEditingController();
    _ot = TextEditingController();
    _amount = TextEditingController();
    _totalAmount = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _name.dispose();
    _hourWorked.dispose();
    _ot.dispose();
    _amount.dispose();
    _totalAmount.dispose();
  }

  Future<void> addFirewoodExpense() async {
    final prov = Provider.of<QualityGrade>(context, listen: false);

    if (prov.date == null) {
      SnackbarService.showFailedSnackbar(context, 'Select a date');
      return;
    }
    if(prov.currentLabour == null){
      SnackbarService.showFailedSnackbar(context, 'Please choose a labour');
      return;
    }
    if ((!_amount.text.isNotBlank)) {
      SnackbarService.showFailedSnackbar(context, 'You need to enter amount');
      return;
    }

    final Map<String, dynamic> data = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'date': prov.date!.format('y-M-d').toString(),
      'Labor Name': prov.currentLabour!.name,
      'Labor Id': prov.currentLabour!.id,
      'amount': _amount.text,
      'ot': _ot.text,
      'totalAmount': _totalAmount.text.isNotBlank ? _totalAmount.text : 0,
    };

    String response =
        await DataLocal.instance.addDataByType('Labour Expenses',data["id"], data);
    if (response == 'success' && mounted) {
      SnackbarService.showSuccessSnackbar(context, 'Done');
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
        'Labour Expense'.text.xl.bold.make(),
        FormFields.pickDate(context),
        FutureBuilder(
            future: DataLocal.instance.getAllLabour(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return FormFields.grayWrapper(
                  FormFields.chooseDropdown<Labour>(
                    context,
                    controller: _name,
                    hint: 'Search Staff',
                    value: Provider.of<QualityGrade>(
                      context,
                    ).currentLabour,
                    items: snapshot.data!
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e!.name),
                            ))
                        .toList(),
                    onChanged: (p0) =>
                        Provider.of<QualityGrade>(context, listen: false)
                            .currentLabour = p0,
                  ),
                );
              }
              return const CircularProgressIndicator();
            }),
        FormFields.commonTextField(
          controller: _amount,
          labelText: 'Amount',
          onChanged: (value) {
            if (_ot.text.isNotEmpty) {
              double amount = double.tryParse(value ?? '0') ?? 1;
              double ot = double.tryParse(_ot.text) ?? 0;
              _totalAmount.text = (amount + ot).toString();
            }
          },
        ),
        FormFields.commonTextField(
            controller: _ot,
            labelText: 'OT',
            onChanged: (value) {
              if (_amount.text.isNotEmpty) {
                double amount = double.tryParse(_amount.text) ?? 1;
                double ot = double.tryParse(value ?? '0') ?? 0;
                _totalAmount.text = (amount + ot).toString();
              }
            }),
        FormFields.commonTextField(
          controller: _totalAmount,
          labelText: 'Total Amount',
          disabled: true,
        ),
        PrimaryButton(
            onTap: addFirewoodExpense,
            color: Colors.green,
            child: 'Add Labour Expense'.text.lg.bold.white.make())
      ],
    ).scrollVertical().expand();
  }
}
