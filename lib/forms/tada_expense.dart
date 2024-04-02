import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shreeantu_tea/data/usecases/data_local.dart';
import 'package:shreeantu_tea/forms/form_fields.dart';
import 'package:shreeantu_tea/providers/quality_grade_provider.dart';
import 'package:shreeantu_tea/utils/snackbar_service.dart';
import 'package:shreeantu_tea/widgets/primary_button.dart';
import 'package:velocity_x/velocity_x.dart';

class FirewoodExpenseForm extends StatefulWidget {
  const FirewoodExpenseForm({super.key});

  @override
  State<FirewoodExpenseForm> createState() => _FirewoodExpenseFormState();
}

class _FirewoodExpenseFormState extends State<FirewoodExpenseForm> {
  late TextEditingController _name, _amount;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    _amount = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _name.dispose();
    _amount.dispose();
  }

  Future<void> addFirewoodExpense() async {
    final prov = Provider.of<QualityGrade>(context, listen: false);

    if (prov.date == null) {
      SnackbarService.showFailedSnackbar(context, 'Select a date');
      return;
    }
    if (prov.date == null) {
      SnackbarService.showFailedSnackbar(context, 'Enter name please');
      return;
    }

    if ((!_amount.text.isNotBlank)) {
      SnackbarService.showFailedSnackbar(context, 'You need to enter amount');
      return;
    }

    final Map<String, dynamic> data = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'date': prov.date!.format('y-M-d').toString(),
      'name': _name.text,
      'amount': _amount.text.isNotBlank ? _amount.text : 0,
    };

    String response = await DataLocal.instance.addDataByType('Tada Expenses', data);
    if (response == 'success' && mounted) {
      SnackbarService.showSuccessSnackbar(context, 'Done');
      prov.reset();
      _name.clear();
      _amount.clear();
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
        'Add a purchase'.text.xl.bold.make(),
        FormFields.pickDate(context),
        FormFields.commonTextField(
          controller: _name,
          labelText: 'Name',
        ),
        FormFields.commonTextField(
          controller: _amount,
          labelText: 'Amount',
        ),
        PrimaryButton(
            onTap: addFirewoodExpense,
            color: Colors.green,
            child: 'Purchase'.text.lg.bold.white.make())
      ],
    ).scrollVertical().expand();
  }
}
