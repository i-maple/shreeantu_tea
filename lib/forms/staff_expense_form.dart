import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shreeantu_tea/data/usecases/data_local.dart';
import 'package:shreeantu_tea/forms/form_fields.dart';
import 'package:shreeantu_tea/model/staff_model.dart';
import 'package:shreeantu_tea/providers/quality_grade_provider.dart';
import 'package:shreeantu_tea/utils/snackbar_service.dart';
import 'package:shreeantu_tea/widgets/primary_button.dart';
import 'package:velocity_x/velocity_x.dart';

class StaffExpenseForm extends StatefulWidget {
  const StaffExpenseForm({super.key});

  @override
  State<StaffExpenseForm> createState() => _StaffExpenseFormState();
}

class _StaffExpenseFormState extends State<StaffExpenseForm> {
  late TextEditingController _name, _salary, _bonus, _amount;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    _bonus = TextEditingController();
    _salary = TextEditingController();
    _amount = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _name.dispose();
    _bonus.dispose();
    _salary.dispose();
    _amount.dispose();
  }

  Future<void> addFirewoodExpense() async {
    final prov = Provider.of<QualityGrade>(context, listen: false);

    if (prov.date == null) {
      SnackbarService.showFailedSnackbar(context, 'Select a date');
      return;
    }
    if ((!_amount.text.isNotBlank)) {
      SnackbarService.showFailedSnackbar(context, 'You need to enter amount');
      return;
    }

    final Map<String, dynamic> data = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'date': prov.date!.format('y-M-d').toString(),
      'staff': prov.currentStaff!.toMap(),
      'bonus': _bonus.text,
      'salary': _salary.text,
      'amount': _amount.text.isNotBlank ? _amount.text : 0,
    };

    String response =
        await DataLocal.instance.addDataByType('Firewood Expense', data);
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
        'Add a purchase'.text.xl.bold.make(),
        FormFields.pickDate(context),
        FutureBuilder(
            future: DataLocal.instance.getAllStaff(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return FormFields.grayWrapper(
                  FormFields.chooseDropdown<Staff>(
                    context,
                    controller: _name,
                    hint: 'Search Staff',
                    value: Provider.of<QualityGrade>(
                      context,
                    ).currentStaff,
                    items: snapshot.data!
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e!.name!),
                            ))
                        .toList(),
                    onChanged: (p0) =>
                        Provider.of<QualityGrade>(context, listen: false)
                            .currentStaff = p0,
                  ),
                );
              }
              return const CircularProgressIndicator();
            }),
        FormFields.commonTextField(
          controller: _salary,
          labelText: 'Salary',
          onChanged: (value) {
            if (_amount.text.isNotEmpty) {
              double salary = double.tryParse(value ?? '0') ?? 1;
              double bonus = double.tryParse(_bonus.text) ?? 0;
              _amount.text = (salary + bonus).toString();
            }
          },
        ),
        FormFields.commonTextField(
            controller: _bonus,
            labelText: 'Bonus',
            onChanged: (value) {
              if (_salary.text.isNotEmpty) {
                double salary = double.tryParse(_salary.text) ?? 1;
                double bonus = double.tryParse(value ?? '0') ?? 0;
                _amount.text = (salary + bonus).toString();
              }
            }),
        FormFields.commonTextField(
          controller: _amount,
          labelText: 'Amount',
          disabled: true,
        ),
        PrimaryButton(
            onTap: addFirewoodExpense,
            color: Colors.green,
            child: 'Purchase'.text.lg.bold.white.make())
      ],
    ).scrollVertical().expand();
  }
}
