import 'package:flutter/material.dart';

class CentreInteretOption {
  final String label;
  final IconData icon;

  const CentreInteretOption(this.label, this.icon);
}

/// Static catalogue of points of interest a property can be located near.
/// Extend this list as needed — it's plain data, not an enum, so new
/// entries don't require a code migration.
const List<CentreInteretOption> kCentresInteret = [
  CentreInteretOption('École', Icons.school_rounded),
  CentreInteretOption('Supermarché', Icons.local_grocery_store_rounded),
  CentreInteretOption('Hôpital', Icons.local_hospital_rounded),
  CentreInteretOption('Transport', Icons.directions_bus_filled_rounded),
  CentreInteretOption('Marché', Icons.storefront_rounded),
  CentreInteretOption('Pharmacie', Icons.local_pharmacy_rounded),
  CentreInteretOption('Banque', Icons.account_balance_rounded),
  CentreInteretOption('Restaurant', Icons.restaurant_rounded),
  CentreInteretOption('Parc', Icons.park_rounded),
  CentreInteretOption('Lieu de culte', Icons.mosque_rounded),
];
