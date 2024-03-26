import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shreeantu_tea/model/home_item_model.dart';
import 'package:shreeantu_tea/routes/routes.dart';

List<HomeItemModel> listOfObjects = [
  HomeItemModel(
    title: 'Farmer Details',
    icon: const FaIcon(FontAwesomeIcons.tree),
    route: AppRouter.allFarmerRoute,
  ),
  HomeItemModel(
    title: 'Purchase',
    icon: const FaIcon(FontAwesomeIcons.cartArrowDown),
    route: AppRouter.purchaseRoute,
  ),
  HomeItemModel(
    title: 'Party',
    icon: const FaIcon(FontAwesomeIcons.teamspeak),
    route: AppRouter.partyRoute,
  ),
  HomeItemModel(
    title: 'Sale',
    icon: const FaIcon(FontAwesomeIcons.fileExport),
    route: '/sale',
  ),
  HomeItemModel(
    title: 'Income',
    icon: const FaIcon(FontAwesomeIcons.moneyCheck),
    route: '/income',
  ),
  HomeItemModel(
    title: 'Firewood Expense',
    icon: const FaIcon(FontAwesomeIcons.fire),
    route: '/firewood-expense',
  ),
  HomeItemModel(
    title: 'Diesel Expenses',
    icon: const FaIcon(FontAwesomeIcons.oilCan),
    route: '/diesel-expenses',
  ),
  HomeItemModel(
    title: 'Electricity Expenses',
    icon: const FaIcon(FontAwesomeIcons.lightbulb),
    route: '/electricity-expenses',
  ),
  HomeItemModel(
    title: 'Staff Expenses',
    icon: const FaIcon(FontAwesomeIcons.peopleGroup),
    route: '/staff-expense',
  ),
  HomeItemModel(
    title: 'Labour Expenses',
    icon: const FaIcon(FontAwesomeIcons.peopleCarryBox),
    route: '/labour-expenses',
  ),
  HomeItemModel(
    title: 'TADA Expenses',
    icon: const FaIcon(FontAwesomeIcons.moneyBillTransfer),
    route: '/tada-expenses',
  ),
  HomeItemModel(
    title: 'Custom Expenses',
    icon: const FaIcon(FontAwesomeIcons.moneyBill1Wave),
    route: '/custom-expenses',
  ),
  HomeItemModel(
    title: 'Repair and Maintenance',
    icon: const FaIcon(FontAwesomeIcons.toolbox),
    route: '/repair-and-maintenance',
  ),
  HomeItemModel(
    title: 'Insurance',
    icon: const FaIcon(FontAwesomeIcons.userLock),
    route: '/insurance',
  ),
  HomeItemModel(
    title: 'Daily Expenses',
    icon: const FaIcon(FontAwesomeIcons.dailymotion),
    route: '/daily-expenses',
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
