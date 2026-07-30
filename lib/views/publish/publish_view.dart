import 'package:domusci/views-models/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import '../../../components/input.dart';
import '../../../components/primary_button.dart';
import '../../../components/secondary_button.dart';
import '../../resources/color.dart';

class PublishView extends StatefulWidget {
  const PublishView({super.key});

  @override
  State<PublishView> createState() => _PublishViewState();
}

class _PublishViewState extends State<PublishView> with SingleTickerProviderStateMixin {
  final ImagePicker _picker = ImagePicker();
  late PageController _pageController;
  int _currentStep = 0;
  static const int totalSteps = 2;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = Provider.of<HomeViewModel>(context, listen: false);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> pickFromGallery(bool isRecto, HomeViewModel vm) async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      if (isRecto) {
        vm.setRecto(file);
      } else {
        vm.setVerso(file);
      }
    }
  }

  Future<void> pickMainImage(HomeViewModel vm) async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      vm.setPrincipalePicture(file);
    }
  }

  Future<void> takePhoto(bool isRecto, HomeViewModel vm) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      final file = File(image.path);
      if (isRecto) {
        vm.setRecto(file);
      } else {
        vm.setVerso(file);
      }
    }
  }

  Future<void> takeMainPhoto(HomeViewModel vm) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      final file = File(image.path);
      vm.setPrincipalePicture(file);
    }
  }

  void showChoiceDialog(BuildContext context, bool isRecto, HomeViewModel vm) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Text(
                  "Choisir une option",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Ajoutez une photo depuis votre appareil",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.camera_alt, color: Colors.blue.shade700),
                  ),
                  title: const Text("Prendre une photo"),
                  subtitle: Text(
                    "Utilisez votre appareil photo",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    takePhoto(isRecto, vm);
                  },
                ),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.photo_library, color: Colors.green.shade700),
                  ),
                  title: const Text("Choisir depuis la galerie"),
                  subtitle: Text(
                    "Sélectionnez une photo existante",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    pickFromGallery(isRecto, vm);
                  },
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }

  void showMainImageChoiceDialog(BuildContext context, HomeViewModel vm) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Text(
                  "Photo principale",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Choisissez la photo qui mettra en valeur votre bien",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.camera_alt, color: Colors.blue.shade700),
                  ),
                  title: const Text("Prendre une photo"),
                  subtitle: Text(
                    "Utilisez votre appareil photo",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    takeMainPhoto(vm);
                  },
                ),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.photo_library, color: Colors.green.shade700),
                  ),
                  title: const Text("Choisir depuis la galerie"),
                  subtitle: Text(
                    "Sélectionnez une photo existante",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    pickMainImage(vm);
                  },
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageCard({
    required String label,
    required bool isRecto,
    required File? file,
    required HomeViewModel vm,
  }) {
    return GestureDetector(
      onTap: () => showChoiceDialog(context, isRecto, vm),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: file != null ? AppColors.primaryColor : Colors.grey.shade200,
            width: file != null ? 2 : 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: file != null
            ? ClipRRect(
          borderRadius: BorderRadius.circular(13),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.file(file, fit: BoxFit.cover),
              Positioned(
                top: 6,
                right: 6,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    size: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_photo_alternate_outlined,
              size: 28,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainImageCard({
    required File? file,
    required HomeViewModel vm,
  }) {
    return GestureDetector(
      onTap: () => showMainImageChoiceDialog(context, vm),
      child: Container(
        width: double.infinity,
        height: 220,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: file != null ? AppColors.primaryColor : Colors.grey.shade200,
            width: file != null ? 2 : 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: file != null
            ? ClipRRect(
          borderRadius: BorderRadius.circular(19),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.file(file, fit: BoxFit.cover),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.star,
                        size: 14,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "Photo principale",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add_a_photo_outlined,
                size: 36,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Ajouter une photo principale",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Cette photo sera la première affichée",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Étape ${_currentStep + 1}",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "${_currentStep + 1}/$totalSteps",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  _currentStep == 0 ? "Informations du bien" : "Photos du bien",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              // Skip à l'étape suivante si toutes les conditions sont remplies
            },
            child: Text(
              "Passer",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      height: 4,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(2),
      ),
      child: Row(
        children: List.generate(totalSteps, (index) {
          final isActive = index <= _currentStep;
          return Expanded(
            child: Container(
              margin: EdgeInsets.only(
                right: index < totalSteps - 1 ? 4 : 0,
              ),
              decoration: BoxDecoration(
                color: isActive ? AppColors.primaryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFEAF5DE), // Fond dégradé verdâtre doux en haut
                    Color(0xFFF7FAF2),
                  ],
                ),
              ),

              child: Column(
                children: [
                  // Header avec back button personnalisé
                  Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child:  Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.03),
                                          blurRadius: 10,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      color: const Color(0xFF1E2022),
                                      size: 48 * 0.45,
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                  // Titre + étape
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Je m’inscris",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                              "Renseignez tous les champs pour vous enrôler",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "Étape 1/2",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Barre de progression
                  LinearProgressIndicator(
                    value: 1 / 2, // 50% de progression
                    backgroundColor: Colors.grey[300],
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),

                  const SizedBox(height: 20),
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentStep = index;
                        });
                      },
                      children: [
                        // Étape 1: Formulaire du bien
                        _buildStep1(vm),
                        // Étape 2: Photos du bien
                        _buildStep2(vm),
                      ],
                    ),
                  ),
                  // Bottom Navigation Bar
                  Container(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 16,
                          offset: const Offset(0, -4),
                        ),
                      ],
                    ),
                    child: SafeArea(
                      child: Row(
                        children: [
                          if (_currentStep == 0)
                            Expanded(
                              child: SecondaryButton(
                                title: "Annuler",
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                          if (_currentStep > 0)
                            Expanded(
                              child: SecondaryButton(
                                title: "Retour",
                                onPressed: () {
                                  setState(() {
                                    _currentStep--;
                                    _pageController.previousPage(
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  });
                                },
                              ),
                            ),
                          if (_currentStep > 0) const SizedBox(width: 12),
                          Expanded(
                            flex: _currentStep == 0 ? 2 : 1,
                            child: PrimaryButton(
                              title: _currentStep == 1 ? "Publier" : "Continuer",
                              onPressed: () {
                                if (_currentStep == 0) {
                                  // Vérifier les champs obligatoires
                                  // if (vm.titreController.text.isEmpty ||
                                  //     vm.adresseController.text.isEmpty ||
                                  //     vm.prixController.text.isEmpty) {
                                  //   ScaffoldMessenger.of(context).showSnackBar(
                                  //     const SnackBar(
                                  //       content: Text('Veuillez remplir tous les champs obligatoires'),
                                  //       backgroundColor: Colors.red,
                                  //     ),
                                  //   );
                                  //   return;
                                  // }
                                  setState(() {
                                    _currentStep++;
                                    _pageController.nextPage(
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  });
                                } else {
                                  // Publier le bien
                                  // Logique de publication
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStep1(HomeViewModel vm) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputText(
            // controller: vm.titreController,
            labelText: "Titre du bien",
            hintext: "Ex: Magnifique appartement 3 pièces",
          ),
          const SizedBox(height: 20),

          InputText(
            // controller: vm.adresseController,
            labelText: "Adresse",
            hintext: "Saisissez l'adresse complète",
          ),
          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: InputText(
                  // controller: vm.prixController,
                  labelText: "Prix (FCFA)",
                  hintext: "Ex: 25 000 000",
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: InputText(
                  // controller: vm.surfaceController,
                  labelText: "Surface (m²)",
                  hintext: "Ex: 120",
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: InputText(
                  // controller: vm.chambresController,
                  labelText: "Chambres",
                  hintext: "Ex: 3",
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: InputText(
                  // controller: vm.sdbController,
                  labelText: "Salles de bain",
                  hintext: "Ex: 2",
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: InputText(
                  // controller: vm.parkingController,
                  labelText: "Parking",
                  hintext: "Ex: 1",
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          InputText(
            // controller: vm.descriptionController,
            labelText: "Description",
            hintext: "Décrivez votre bien en détail",
            // maxLines: 4,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildStep2(HomeViewModel vm) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMainImageCard(
            file: vm.principalePicture,
            vm: vm,
          ),
          const SizedBox(height: 24),

          Text(
            "Photos supplémentaires",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Ajoutez jusqu'à 4 photos pour compléter votre annonce",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              _buildImageCard(
                label: "Photo 1",
                isRecto: true,
                file: vm.rectoFile,
                vm: vm,
              ),
              const SizedBox(width: 12),
              _buildImageCard(
                label: "Photo 2",
                isRecto: false,
                file: vm.versoFile,
                vm: vm,
              ),
              const SizedBox(width: 12),
              _buildImageCard(
                label: "Photo 3",
                isRecto: false,
                file: null,
                vm: vm,
              ),
              const SizedBox(width: 12),
              _buildImageCard(
                label: "Photo 4",
                isRecto: false,
                file: null,
                vm: vm,
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Conseil UX
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.blue.shade100),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.lightbulb_outline,
                  color: Colors.blue.shade700,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Conseil photo",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.blue.shade700,
                        ),
                      ),
                      Text(
                        "Des photos claires et lumineuses attirent plus de visiteurs. N'hésitez pas à en ajouter plusieurs !",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.blue.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}