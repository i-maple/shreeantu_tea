import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shreeantu_tea/data/usecases/data_local.dart';
import 'package:shreeantu_tea/forms/firewood_expense_form.dart';
import 'package:shreeantu_tea/forms/form_fields.dart';
import 'package:shreeantu_tea/forms/purchase_form.dart';
import 'package:shreeantu_tea/forms/sale.dart';
import 'package:shreeantu_tea/forms/staff_expense_form.dart';
import 'package:shreeantu_tea/model/purchase_model.dart';
import 'package:shreeantu_tea/providers/quality_grade_provider.dart';
import 'package:shreeantu_tea/screens/all_farmer_screen.dart';
import 'package:shreeantu_tea/screens/party_screen.dart';
import 'package:shreeantu_tea/utils/colors.dart';
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

  Future<List<Map<String, dynamic>>> _futureToGetDatas =
      DataLocal.instance.getDataByType('Purchase');
  String displayValue = 'Purchase';

  @override
  void dispose() {
    super.dispose();
    _searchTypeController.dispose();
    _displayTypeController.dispose();
  }

  Widget getForm() {
    String? type = Provider.of<QualityGrade>(context).transactionType;
    return switch (type) {
      'Purchase' => const PurchaseForm(),
      'Sale' => const SaleForm(),
      'Firewood Expense' => const FirewoodExpenseForm(),
      'Staff Expenses' => const StaffExpenseForm(),
      _ => 'Select a Transaction Type'.text.make(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Shree Antu Tea'.text.white.make(),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              child: Placeholder(
                fallbackHeight: 200,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.agriculture),
              title: 'Farmers'.text.make(),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AllFarmerScreen(),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.support_agent),
              title: 'Party'.text.make(),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PartyScreen(),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(FontAwesomeIcons.peopleCarryBox),
              title: 'Labour'.text.make(),
            ),
            ListTile(
              leading: const Icon(FontAwesomeIcons.peopleGroup),
              title: 'Staff'.text.make(),
            ),
            ListTile(
              leading: const FaIcon(Icons.money),
              title: 'Bank'.text.make(),
            ),
          ],
        ).scrollVertical(),
      ),
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
      right: _form().expand(),
    ).p20();
  }

  Widget _getLedger() {
    return SizedBox(
      width: 900,
      child: Column(
        children: [
          ListTile(
            tileColor: AppColors.primaryColor,
            leading: 'Transaction Type'.text.white.make(),
            trailing: FutureBuilder(
                future: DataLocal.instance.getAmount(),
                builder: (context, snap) {
                  if (snap.hasData &&
                      snap.connectionState == ConnectionState.done) {
                    return Text(
                      'Balance: ${snap.data.toString()}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    );
                  }
                  return const CircularProgressIndicator.adaptive();
                }),
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
              ...Purchase.props,
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
              _form(),
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

  Widget _form() {
    return Column(
      children: [
        FormFields.grayWrapper(
          DropdownButton(
            hint: 'Transaction Type'.text.make(),
            items: titles
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: e.text.make(),
                    ))
                .toList(),
            onChanged: (val) {
              Provider.of<QualityGrade>(context, listen: false)
                  .transactionType = val;
            },
            value: Provider.of<QualityGrade>(context, listen: false)
                .transactionType,
          ),
        ),
        getForm()
      ],
    );
  }
}
