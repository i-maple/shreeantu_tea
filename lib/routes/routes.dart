import 'package:flutter/material.dart';
import 'package:shreeantu_tea/screens/all_farmer_screen.dart';
import 'package:shreeantu_tea/screens/all_in_one_data_screen.dart';
import 'package:shreeantu_tea/screens/home_screen.dart';
import 'package:shreeantu_tea/screens/individual_farmer_screen.dart';
import 'package:shreeantu_tea/screens/login_screen.dart';
import 'package:shreeantu_tea/screens/onboarding_screen.dart';
import 'package:shreeantu_tea/screens/party_screen.dart';
import 'package:shreeantu_tea/screens/party_search.dart';
import 'package:shreeantu_tea/screens/purchase_screen.dart';

class AppRouter {
  static String homeRoute = '/home';
  static String loginRoute = '/login';
  static String onboardingRoute = '/onboarding';
  static String purchaseRoute = '/purchase';
  static String allFarmerRoute = '/farmers';
  static String partyRoute = '/party';
  static String individualFarmerScreen = '/individual-farmer';
  static String allInOneDataRoute = '/allInOneData';
  static String individualPartyRoute = '/individualParty';
  static get initialRoute => onboardingRoute;

  static Map<String, Widget Function(BuildContext)> routes = {
    homeRoute: (context) => const HomeScreen(),
    loginRoute: (context) => const LoginScreen(),
    onboardingRoute: (context) => const OnboardingScreen(),
    purchaseRoute: (context) => const PurchaseScreen(),
    allFarmerRoute: (context) => const AllFarmerScreen(),
    partyRoute: (context) => const PartyScreen(),
    individualFarmerScreen: (context) => const IndividualFarmerScreen(),
    allInOneDataRoute: (context) => const AllInOneDataScreen(),
    individualPartyRoute: (context) => const PartySearchScreen(),
  };
}
