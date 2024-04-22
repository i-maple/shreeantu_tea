import 'package:flutter/material.dart';
import 'package:shreeantu_tea/data/usecases/data_local.dart';
import 'package:shreeantu_tea/forms/form_fields.dart';
import 'package:shreeantu_tea/utils/colors.dart';
import 'package:shreeantu_tea/utils/snackbar_service.dart';
import 'package:velocity_x/velocity_x.dart';

class PartySearchScreen extends StatefulWidget {
  const PartySearchScreen({super.key});

  @override
  State<PartySearchScreen> createState() => _PartySearchScreenState();
}

class _PartySearchScreenState extends State<PartySearchScreen> {
  late TextEditingController _searchController;
  Map? foundResult;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  handleSearch() async {
    if (_searchController.text.isEmpty) {
      SnackbarService.showFailedSnackbar(
          context, 'Please Enter some search text');
      return;
    }
    final allSales = await DataLocal.instance.getDataByType('Sale');
    setState(() {
      foundResult = allSales.singleWhere(
        (element) =>
            (element['Party Name'] as String).contains(_searchController.text),
        orElse: () => {'Party Name': 'No Party Found'},
      );
    });
    print(foundResult);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: 'Party'.text.make(),
      ),
      body: Column(
        children: [
          ListTile(
            title: FormFields.commonTextField(
                controller: _searchController, hint: 'Enter Party Name'),
            trailing: IconButton(
              onPressed: handleSearch,
              icon: const Icon(Icons.search),
              color: AppColors.primaryColor,
            ),
          ).py20(),
          foundResult != null
              ? ListTile(
                  title: Text( foundResult!['Party Name']),
                )
              : 'Please Enter a Search Text'.text.make()
        ],
      ).scrollVertical(),
    );
  }
}
