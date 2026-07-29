import 'package:flutter/foundation.dart';
import '../exception/app_exception.dart';
import '../models/property.dart';
import '../utils/validators.dart';
import '../utils/view_state.dart';
import '../web-services/property_service.dart';

/// ViewModel — Publier une annonce (formulaire multi-étapes).
class PublishViewModel extends ChangeNotifier {
  final PropertyService _service;
  PublishViewModel({PropertyService? service}) : _service = service ?? PropertyService();

  ViewState state = ViewState.idle;
  String? errorMessage;
  int currentStep = 0;
  static const int totalSteps = 3;

  PropertyType selectedType = PropertyType.appartement;
  String title = '';
  String quartier = '';
  String price = '';
  String surface = '';
  String description = '';
  final List<String> photoUrls = [];

  bool get isLoading => state == ViewState.loading;

  void setType(PropertyType type) {
    selectedType = type;
    notifyListeners();
  }

  void updateField({String? title, String? quartier, String? price, String? surface, String? description}) {
    if (title != null) this.title = title;
    if (quartier != null) this.quartier = quartier;
    if (price != null) this.price = price;
    if (surface != null) this.surface = surface;
    if (description != null) this.description = description;
    notifyListeners();
  }

  void nextStep() {
    if (currentStep < totalSteps - 1) {
      currentStep++;
      notifyListeners();
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      currentStep--;
      notifyListeners();
    }
  }

  Future<bool> submit() async {
    state = ViewState.loading;
    notifyListeners();
    try {
      Validators.validateRequired(title, "Le titre de l'annonce");
      Validators.validateRequired(quartier, 'La localisation');
      Validators.validatePrice(price);

      await _service.publishListing(
        title: title,
        type: selectedType,
        quartier: quartier,
        price: price,
        surface: surface,
        description: description,
      );
      state = ViewState.loaded;
      notifyListeners();
      return true;
    } on AppException catch (e) {
      errorMessage = e.message;
      state = ViewState.error;
      notifyListeners();
      return false;
    }
  }
}
