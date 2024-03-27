import 'package:flutter/material.dart';
import 'package:shreeantu_tea/data/usecases/data_local.dart';
import 'package:shreeantu_tea/forms/form_fields.dart';
import 'package:shreeantu_tea/model/farmers_model.dart';
import 'package:shreeantu_tea/screens/purchase_screen.dart';
import 'package:shreeantu_tea/utils/utilities.dart';
import 'package:shreeantu_tea/widgets/ledger_widget.dart';
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

  @override
  void dispose() {
    super.dispose();
    _searchTypeController.dispose();
    _displayTypeController.dispose();
  }

  Future<Widget> getForm() async {
    return switch(displayValue){
      'Purchase' => PurchaseScreen(),
      _ =>const SizedBox(),
    };
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
      right: SizedBox(),
    ).p20();
  }

  Widget _getLedger() {
    return SizedBox(
      width: 900,
      child: Column(
        children: [
          ListTile(
            leading: 'Transaction Type'.text.make(),
            title: FormFields.chooseDropdown<String>(
              context,
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
            headers: [
              ...Farmer.props,
            ],
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
              SizedBox(),
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

  Widget _form({List<Widget>? children}) {
    return Column(
      children: [
        FormFields.grayWrapper(
          DropdownButton(
            items: titles
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: e.text.make(),
                    ))
                .toList(),
            onChanged: (val) {},
          ),
        ),
        ...children ?? []
      ],
    );
  }
}
