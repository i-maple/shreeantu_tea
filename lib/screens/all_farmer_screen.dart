import 'package:flutter/material.dart';
import 'package:shreeantu_tea/data/usecases/data_local.dart';
import 'package:shreeantu_tea/model/data_entry.dart';
import 'package:shreeantu_tea/model/farmers_model.dart';
import 'package:shreeantu_tea/routes/routes.dart';
import 'package:shreeantu_tea/utils/colors.dart';
import 'package:shreeantu_tea/utils/snackbar_service.dart';
import 'package:shreeantu_tea/widgets/data_entry_form.dart';
import 'package:shreeantu_tea/widgets/ledger_widget.dart';
import 'package:velocity_x/velocity_x.dart';

class AllFarmerScreen extends StatefulWidget {
  const AllFarmerScreen({super.key});

  @override
  State<AllFarmerScreen> createState() => _AllFarmerScreenState();
}

class _AllFarmerScreenState extends State<AllFarmerScreen> {
  late TextEditingController _nameController, _phoneController;

  Future future = DataLocal.instance.getAllFarmersAsMap();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _phoneController.dispose();
  }

  addFarmer() async {
    if (_nameController.text.isEmptyOrNull) {
      if (mounted) {
        SnackbarService.showFailedSnackbar(context, 'Name Cannot be empty');
      }
      return;
    }
    Farmer farmer = Farmer(
      name: _nameController.text,
      uid: DateTime.now().millisecondsSinceEpoch.toString(),
      phone: _phoneController.text,
    );
    String response = await DataLocal.instance.addFarmer(farmer: farmer);
    if (mounted) {
      if (response == 'success') {
        SnackbarService.showSuccessSnackbar(
            context, 'Successfully Added Farmer. Refresh to see changes');
        setState(() {
          future = DataLocal.instance.getAllFarmersAsMap();
        });
        _nameController.clear();
        return;
      } else {
        SnackbarService.showFailedSnackbar(context, response);
        return;
      }
    }
  }

  get fields => [
        DataEntry(
          hint: 'Name of Farmer',
          textController: _nameController,
        ),
        DataEntry(
          hint: 'Phone of Farmer',
          textController: _phoneController,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: MediaQuery.sizeOf(context).width > 600
            ? 'Farmers'.text.color(AppColors.primaryTextColor).make()
            : null,
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        actions: [
          ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(
                  context, AppRouter.individualFarmerScreen),
              icon: const Icon(Icons.travel_explore_outlined),
              label: 'All Farmers Details'.text.make())
        ],
      ),
      body: size.width > 1190
          ? VxTwoRow(
              left: SizedBox(
                width: 920,
                child: LedgerWidget(
                  future: future,
                  headers: Farmer.props,
                ),
              ),
              right: DataEntryForm(
                fields: fields,
                onSubmit: addFarmer,
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
                    future: future,
                    headers: Farmer.props,
                  ),
                ),
                DataEntryForm(
                  fields: fields,
                  onSubmit: addFarmer,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
