import 'package:pisso/models/request/create_bien_request.dart';
import 'package:pisso/models/type_bien.dart';
import 'package:pisso/utils/view_state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

import '../repository/bien_repository.dart';



class PublishViewModel extends ChangeNotifier {
  final BienRepository _repository;
  final ImagePicker _imagePicker = ImagePicker();

  ViewState state = ViewState.idle;
  String? errorMessage;

  bool get isLoading => state == ViewState.loading;
  bool get hasError => state == ViewState.error;

  int currentStep = 1;
  bool get isStep1 => currentStep == 1;
  bool get isStep2 => currentStep == 2;

  PublishViewModel(this._repository);

  void nextStep() {
    if (currentStep < 2) {
      currentStep++;
      notifyListeners();
    }
  }

  void previousStep() {
    if (currentStep > 1) {
      currentStep--;
      notifyListeners();
    }
  }

  // Text controllers
  final nomController = TextEditingController();
  final descriptionController = TextEditingController();
  final surfaceController = TextEditingController();
  final etageController = TextEditingController();
  final adresseController = TextEditingController();
  final communeController = TextEditingController();
  final quartierController = TextEditingController();

  // Type de bien
  TypeBienImmobilier? selectedType;
  final List<TypeBienImmobilier> typesBiens = [
    TypeBienImmobilier(id: 1, libelle: "APPARTEMENT", description: ""),
    TypeBienImmobilier(id: 2, libelle: "MAISON", description: ""),
    TypeBienImmobilier(id: 3, libelle: "STUDIO", description: ""),
    TypeBienImmobilier(id: 4, libelle: "TERRAIN", description: ""),
    TypeBienImmobilier(id: 5, libelle: "BUREAU", description: ""),
    TypeBienImmobilier(id: 6, libelle: "PENTHOUSE", description: ""),
    TypeBienImmobilier(id: 7, libelle: "MAGASIN", description: ""),
    TypeBienImmobilier(id: 8, libelle: "ENTREPOT", description: ""),
    TypeBienImmobilier(id: 8, libelle: "HOTEL", description: ""),
    TypeBienImmobilier(id: 8, libelle: "RESIDENCE MEUBLEE", description: ""),
  ];

  void selectType(TypeBienImmobilier type) {
    selectedType = type;
    notifyListeners();
  }

  // Caractéristiques numériques
  int chambres = 0;
  int salons = 0;
  int sallesBain = 0;

  void incrementChambres() => _setChambres(chambres + 1);
  void decrementChambres() => _setChambres(chambres - 1);
  void _setChambres(int v) {
    chambres = v.clamp(0, 20);
    notifyListeners();
  }

  void incrementSalons() => _setSalons(salons + 1);
  void decrementSalons() => _setSalons(salons - 1);
  void _setSalons(int v) {
    salons = v.clamp(0, 20);
    notifyListeners();
  }

  void incrementSallesBain() => _setSallesBain(sallesBain + 1);
  void decrementSallesBain() => _setSallesBain(sallesBain - 1);
  void _setSallesBain(int v) {
    sallesBain = v.clamp(0, 20);
    notifyListeners();
  }

  // Équipements (toggles)
  bool parking = false;
  bool piscine = false;
  bool jardin = false;
  bool meuble = false;
  bool climatisation = false;
  bool ascenseur = false;

  void toggleParking() => _toggle(() => parking = !parking);
  void togglePiscine() => _toggle(() => piscine = !piscine);
  void toggleJardin() => _toggle(() => jardin = !jardin);
  void toggleMeuble() => _toggle(() => meuble = !meuble);
  void toggleClimatisation() => _toggle(() => climatisation = !climatisation);
  void toggleAscenseur() => _toggle(() => ascenseur = !ascenseur);
  void _toggle(VoidCallback mutate) {
    mutate();
    notifyListeners();
  }

  // Localisation
  double? latitude;
  double? longitude;
  bool isLocating = false;

  Future<void> fetchCurrentLocation() async {
    isLocating = true;
    notifyListeners();
    try {
      final permission = await Geolocator.checkPermission();
      var effectivePermission = permission;
      if (effectivePermission == LocationPermission.denied) {
        effectivePermission = await Geolocator.requestPermission();
      }
      if (effectivePermission == LocationPermission.denied ||
          effectivePermission == LocationPermission.deniedForever) {
        print('Autorisation de localisation refusée.');
        return;
      }
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print("Le service de localisation est désactivé.");
        return;
      }
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print("Impossible de récupérer votre position : $e");
    } finally {
      isLocating = false;
      notifyListeners();
    }
  }

  // Centres d'intérêt
  final Set<String> selectedCentresInteret = {};
  void toggleCentreInteret(String label) {
    if (selectedCentresInteret.contains(label)) {
      selectedCentresInteret.remove(label);
    } else {
      selectedCentresInteret.add(label);
    }
    notifyListeners();
  }

  // Médias
  final List<String> imagePaths = [];
  final List<String> videoPaths = [];
  final List<PlatformFile> documents = [];

  Future<void> pickImages() async {
    try {
      final picked = await _imagePicker.pickMultiImage(imageQuality: 85);
      if (picked.isNotEmpty) {
        imagePaths.addAll(picked.map((x) => x.path));
        notifyListeners();
      }
    } catch (e) {
      print("Impossible de sélectionner les images : $e");
    }
  }

  void removeImageAt(int index) {
    imagePaths.removeAt(index);
    notifyListeners();
  }

  Future<void> pickVideo() async {
    try {
      final picked = await _imagePicker.pickVideo(source: ImageSource.gallery);
      if (picked != null) {
        videoPaths.add(picked.path);
        notifyListeners();
      }
    } catch (e) {
      print("Impossible de sélectionner la vidéo : $e");
    }
  }

  void removeVideoAt(int index) {
    videoPaths.removeAt(index);
    notifyListeners();
  }

  Future<void> pickDocuments() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'png'],
      );
      if (result != null) {
        documents.addAll(result.files);
        notifyListeners();
      }
    } catch (e) {
      print("Impossible de sélectionner les documents : $e");
    }
  }

  void removeDocumentAt(int index) {
    documents.removeAt(index);
    notifyListeners();
  }

  // Validation + soumission
  String? validate() {
    if (selectedType == null) return "Sélectionnez un type de bien.";
    if (nomController.text.trim().isEmpty) return "Le nom du bien est requis.";
    if (adresseController.text.trim().isEmpty) return "L'adresse est requise.";
    if (communeController.text.trim().isEmpty) return "La commune est requise.";
    if (surfaceController.text.trim().isEmpty) return "La surface est requise.";
    if (imagePaths.isEmpty) return "Ajoutez au moins une photo du bien.";
    return null;
  }

  bool publishSuccess = false;

  Future<void> submit() async {
    final validationError = validate();
    if (validationError != null) {
      errorMessage = validationError;
      state = ViewState.error;
      notifyListeners();
      return;
    }

    state = ViewState.loading;
    errorMessage = null;
    notifyListeners();

    try {
      final request = CreateBienRequest(
        type: selectedType!,
        nom: nomController.text.trim(),
        description: descriptionController.text.trim(),
        chambres: chambres,
        salons: salons,
        sallesBain: sallesBain,
        surface: double.tryParse(surfaceController.text.trim()) ?? 0,
        etage: int.tryParse(etageController.text.trim()) ?? 0,
        parking: parking,
        piscine: piscine,
        jardin: jardin,
        meuble: meuble,
        climatisation: climatisation,
        ascenseur: ascenseur,
        adresse: adresseController.text.trim(),
        commune: communeController.text.trim(),
        quartier: quartierController.text.trim(),
        latitude: latitude,
        longitude: longitude,
        centresInteret: selectedCentresInteret.toList(),
        imagePaths: imagePaths,
        videoPaths: videoPaths,
        documentPaths: documents.map((f) => f.path ?? f.name).toList(),
      );

      final id = await _repository.createBien(request);
      publishSuccess = id != null;
      state = ViewState.loaded;
      notifyListeners();
    } catch (e) {
      errorMessage = 'Une erreur est survenue lors de la publication.';
      state = ViewState.error;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    nomController.dispose();
    descriptionController.dispose();
    surfaceController.dispose();
    etageController.dispose();
    adresseController.dispose();
    communeController.dispose();
    quartierController.dispose();
    super.dispose();
  }
}

