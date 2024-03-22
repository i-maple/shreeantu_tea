import 'package:flutter/material.dart';
import 'package:shreeantu_tea/model/data_entry.dart';
import 'package:shreeantu_tea/utils/colors.dart';
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
  late TextEditingController _priceController, _nameSearchController;

  @override
  void initState() {
    super.initState();
    _priceController = TextEditingController();
    _nameSearchController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _priceController.dispose();
    _nameSearchController.dispose();
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
                SizedBox(
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
          hint: 'Bill Number',
          textController: _priceController,
        ),
        DataEntry(
          hint: 'Name',
          searchDropdownType: 'farmer',
        ),
      ],
      onSubmit: () {},
    );
  }
}
