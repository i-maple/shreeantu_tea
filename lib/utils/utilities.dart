import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shreeantu_tea/model/home_item_model.dart';
import 'package:shreeantu_tea/routes/routes.dart';

List<HomeItemModel> listOfObjects = [
  HomeItemModel(
    title: 'Datas',
    icon: const FaIcon(FontAwesomeIcons.database),
    route: AppRouter.allInOneDataRoute,
  ),
  HomeItemModel(
    title: 'Farmers',
    icon: const Icon(Icons.agriculture),
    route: AppRouter.allFarmerRoute,
  ),
  HomeItemModel(
    title: 'Individual Farmers',
    icon: const Icon(Icons.person),
    route: AppRouter.individualFarmerScreen,
  ),
  HomeItemModel(
    title: 'Party',
    icon: const Icon(Icons.person),
    route: AppRouter.individualPartyRoute,
  ),
];

List<String> titles = [
  'Purchase',
  'Sale',
  'Income',
  'Firewood Expense',
  'Diesel Expenses',
  'Electricity Expenses',
  'Staff Expenses',
  'Labour Expenses',
  'TADA Expenses',
  'Custom Expenses',
  'Repair and Maintenance',
  'Insurance',
  'Daily Expenses',
];

Map<String, List<String>> textFieldsForEachTitles = {
  'Purchase': [
    'Bill Number',
    'Quantity',
    'Amount',
  ],
  'Sale': [
    'Invoice Number',
    'Quantity',
    'Amount',
  ],
  'Income': [],
  'Firewood Expense': [
    'Party Name',
    'Vehicle Number',
    'Quantity',
    'Amount',
  ],
  'Diesel Expenses': [
    'Name',
    'Liter',
    'Amount',
  ],
  'Electricity Expenses': [],
  'Staff Expenses': [
    'Name',
    'Monthly Salary',
    'Bonus',
  ],
  'Interest': [
    'Bank Name',
    'Amount',
  ],
  'Labour Expenses': [
    'Name',
    'Hour Worked',
    'Amount',
    'OT',
    'Total Amount',
  ],
  'TADA Expenses': [
    'Name',
    'Amount',
  ],
  'Custom Expenses': [
    'Agent name',
    'Amount',
  ],
  'Repair and Maintenance': [
    'Detail',
    'Amount',
  ],
  'Insurance': [],
  'Daily Expenses': [],
};
