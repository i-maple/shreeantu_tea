import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shreeantu_tea/model/party_model.dart';
import 'package:shreeantu_tea/providers/quality_grade_provider.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:shreeantu_tea/data/usecases/data_local.dart';
import 'package:shreeantu_tea/utils/colors.dart';
import 'package:shreeantu_tea/utils/snackbar_service.dart';

import '../model/data_entry.dart';
import '../widgets/data_entry_form.dart';
import '../widgets/ledger_widget.dart';

class PartyScreen extends StatefulWidget {
  const PartyScreen({super.key});

  @override
  State<PartyScreen> createState() => _PartyScreenState();
}

class _PartyScreenState extends State<PartyScreen> {
  late TextEditingController _nameController,
      _phoneController,
      _countryController;

  resetFields() {
    _nameController.clear();
    _phoneController.clear();
    _countryController.clear();
    Provider.of<QualityGrade>(context, listen: false).reset();
  }

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _countryController = TextEditingController();
  }

  @override
  dispose() {
    super.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _countryController.dispose();
  }

  Future future = DataLocal.instance.getAllPartyAsMap();

  addParty() async {
    if (_nameController.text.isNotEmptyAndNotNull) {
      Party data = Party(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        country: _countryController.text,
        phone: _phoneController.text,
      );

      String response = await DataLocal.instance.addParty(party: data);
      if (mounted) {
        if (response == 'success') {
          SnackbarService.showSuccessSnackbar(
              context, 'Successfully Added Purchase');
          resetFields();
          setState(() {
            future = DataLocal.instance.getAllPartyAsMap();
          });
          return;
        } else {
          SnackbarService.showFailedSnackbar(context, response);
          return;
        }
      }
    }
    if (mounted) {
      SnackbarService.showFailedSnackbar(context, 'Name cannot be empty');
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: MediaQuery.sizeOf(context).width > 600
            ? 'Party'.text.color(AppColors.primaryTextColor).make()
            : null,
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),
      body: size.width > 1190
          ? VxTwoRow(
              left: SizedBox(
                width: 920,
                child: LedgerWidget(
                  future: future,
                  headers: Party.props,
                ),
              ),
              right: _dataEntryMethod(),
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
                    future: future,
                    headers: Party.props,
                  ),
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
          hint: 'Name',
          textController: _nameController,
        ),
        DataEntry(
          hint: 'Phone',
          textController: _phoneController,
        ),
        DataEntry(
          hint: 'Country',
          textController: _countryController,
        ),
      ],
      onSubmit: addParty,
    ).expand();
  }
}
