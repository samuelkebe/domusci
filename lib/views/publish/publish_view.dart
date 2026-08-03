import 'dart:io';

import 'package:domusci/components/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/SectionCard.dart';
import '../../components/count_stepper.dart';
import '../../components/error_banner.dart';
import '../../components/map_placeholder.dart';
import '../../components/media_button.dart';
import '../../components/publish_header.dart';
import '../../components/publish_text_field.dart';
import '../../components/selectable_chip.dart';
import '../../models/centre_interet.dart';
import '../../models/type_bien.dart';
import '../../repository/bien_repository.dart';
import '../../views-models/publish_view_model.dart';
import '../../web-services/bien_service.dart';

class PublishView extends StatelessWidget {
  const PublishView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PublishViewModel(BienRepository(BienService())),
      child: const _PublishScaffold(),
    );
  }
}

class _PublishScaffold extends StatelessWidget {
  const _PublishScaffold();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PublishViewModel>();

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFEAF5DE), Color(0xFFF7FAF2)],
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    const PublishHeader(),
                    if (vm.hasError)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
                        child: ErrorBanner(message: vm.errorMessage!),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          _buildStepIndicator(1, vm.currentStep,context),
                          const SizedBox(width: 8),
                          Expanded(child: _buildStepLine(vm.currentStep >= 1)),
                          const SizedBox(width: 8),
                          _buildStepIndicator(2, vm.currentStep,context),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(20, 6, 20, 140),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (vm.isStep1) ...[
                              SectionCard(
                                title: 'Type de bien',
                                icon: Icons.category_rounded,
                                subtitle:
                                    'Sélectionnez la catégorie de votre propriété',
                                child: Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: vm.typesBiens.map((type) {
                                    return SelectableChip(
                                      label: type.libelle ?? '',
                                      icon: Icons.category_rounded,
                                      selected: vm.selectedType == type,
                                      onTap: () => vm.selectType(type),
                                    );
                                  }).toList(),
                                ),
                              ),
                              SectionCard(
                                title: 'Informations générales',
                                icon: Icons.description_rounded,
                                subtitle:
                                    'Donnez un nom et décrivez votre bien',
                                child: Column(
                                  children: [
                                    PublishTextField(
                                      controller: vm.nomController,
                                      label: 'Nom du bien',
                                      hint:
                                          'Ex. Villa moderne 4 pièces à Cocody',
                                      required: true,
                                    ),
                                    const SizedBox(height: 14),
                                    PublishTextField(
                                      controller: vm.descriptionController,
                                      label: 'Description',
                                      hint: 'Décrivez le bien...',
                                      maxLines: 4,
                                    ),
                                  ],
                                ),
                              ),
                              SectionCard(
                                title: 'Caractéristiques',
                                icon: Icons.tune_rounded,
                                subtitle: 'Précisez les détails et équipements',
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: CountStepper(
                                            label: 'Chambres',
                                            icon: Icons.bed_rounded,
                                            value: vm.chambres,
                                            onIncrement: vm.incrementChambres,
                                            onDecrement: vm.decrementChambres,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    CountStepper(
                                      label: 'Salons',
                                      icon: Icons.weekend_rounded,
                                      value: vm.salons,
                                      onIncrement: vm.incrementSalons,
                                      onDecrement: vm.decrementSalons,
                                    ),
                                    const SizedBox(height: 10),
                                    CountStepper(
                                      label: 'Salles de bain',
                                      icon: Icons.bathtub_rounded,
                                      value: vm.sallesBain,
                                      onIncrement: vm.incrementSallesBain,
                                      onDecrement: vm.decrementSallesBain,
                                    ),
                                    const SizedBox(height: 14),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: PublishTextField(
                                            controller: vm.surfaceController,
                                            label: 'Surface',
                                            hint: '0',
                                            required: true,
                                            keyboardType: TextInputType.number,
                                            suffixText: 'm²',
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: PublishTextField(
                                            controller: vm.etageController,
                                            label: 'Étage',
                                            hint: '0',
                                            keyboardType: TextInputType.number,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Wrap(
                                      spacing: 10,
                                      runSpacing: 10,
                                      children: [
                                        SelectableChip(
                                          label: 'Parking',
                                          icon: Icons.local_parking_rounded,
                                          selected: vm.parking,
                                          onTap: vm.toggleParking,
                                        ),
                                        SelectableChip(
                                          label: 'Piscine',
                                          icon: Icons.pool_rounded,
                                          selected: vm.piscine,
                                          onTap: vm.togglePiscine,
                                        ),
                                        SelectableChip(
                                          label: 'Jardin',
                                          icon: Icons.grass_rounded,
                                          selected: vm.jardin,
                                          onTap: vm.toggleJardin,
                                        ),
                                        SelectableChip(
                                          label: 'Meublé',
                                          icon: Icons.chair_rounded,
                                          selected: vm.meuble,
                                          onTap: vm.toggleMeuble,
                                        ),
                                        SelectableChip(
                                          label: 'Climatisation',
                                          icon: Icons.ac_unit_rounded,
                                          selected: vm.climatisation,
                                          onTap: vm.toggleClimatisation,
                                        ),
                                        SelectableChip(
                                          label: 'Ascenseur',
                                          icon: Icons.elevator_rounded,
                                          selected: vm.ascenseur,
                                          onTap: vm.toggleAscenseur,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SectionCard(
                                title: 'Localisation',
                                icon: Icons.location_on_rounded,
                                subtitle: 'Indiquez l\'adresse exacte du bien',
                                child: Column(
                                  children: [
                                    PublishTextField(
                                      controller: vm.adresseController,
                                      label: 'Adresse',
                                      hint: 'Ex. Rue des Jardins, lot 12',
                                      required: true,
                                    ),
                                    const SizedBox(height: 14),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: PublishTextField(
                                            controller: vm.communeController,
                                            label: 'Commune',
                                            hint: 'Ex. Cocody',
                                            required: true,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: PublishTextField(
                                            controller: vm.quartierController,
                                            label: 'Quartier',
                                            hint: 'Ex. Angré',
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 14),
                                    InkWell(
                                      onTap: vm.isLocating
                                          ? null
                                          : vm.fetchCurrentLocation,
                                      borderRadius: BorderRadius.circular(14),
                                      child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 13,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF7F9F5),
                                          borderRadius: BorderRadius.circular(
                                            14,
                                          ),
                                          border: Border.all(
                                            color: const Color(
                                              0xFF8FBF3F,
                                            ).withOpacity(0.5),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            if (vm.isLocating)
                                              const SizedBox(
                                                width: 16,
                                                height: 16,
                                                child:
                                                    CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                    ),
                                              )
                                            else
                                              const Icon(
                                                Icons.my_location_rounded,
                                                size: 17,
                                                color: Color(0xFF1E2022),
                                              ),
                                            const SizedBox(width: 8),
                                            Text(
                                              vm.latitude != null
                                                  ? 'Position : ${vm.latitude!.toStringAsFixed(5)}, ${vm.longitude!.toStringAsFixed(5)}'
                                                  : 'Géolocaliser le bien',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w700,
                                                    color: Color(0xFF1E2022),
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 14),
                                    MapPlaceholder(hasPin: vm.latitude != null),
                                  ],
                                ),
                              ),
                            ],
                            if (vm.isStep2) ...[
                              SectionCard(
                                title: "Centres d'intérêt",
                                icon: Icons.explore_rounded,
                                subtitle:
                                    'Sélectionnez les points d\'intérêt à proximité',
                                child: Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: kCentresInteret.map((option) {
                                    return SelectableChip(
                                      label: option.label,
                                      icon: option.icon,
                                      selected: vm.selectedCentresInteret
                                          .contains(option.label),
                                      onTap: () =>
                                          vm.toggleCentreInteret(option.label),
                                    );
                                  }).toList(),
                                ),
                              ),
                              SectionCard(
                                title: 'Galerie photos',
                                icon: Icons.photo_library_rounded,
                                subtitle:
                                    'Ajoutez des photos pour valoriser votre bien',
                                child: Column(
                                  children: [
                                    if (vm.imagePaths.isNotEmpty)
                                      GridView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: vm.imagePaths.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10,
                                            ),
                                        itemBuilder: (context, i) {
                                          return Stack(
                                            fit: StackFit.expand,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                                child: Image.file(
                                                  File(vm.imagePaths[i]),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Positioned(
                                                top: 4,
                                                right: 4,
                                                child: GestureDetector(
                                                  onTap: () =>
                                                      vm.removeImageAt(i),
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(4),
                                                    decoration:
                                                        const BoxDecoration(
                                                          color: Colors.black54,
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                    child: const Icon(
                                                      Icons.close_rounded,
                                                      size: 14,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    if (vm.imagePaths.isNotEmpty)
                                      const SizedBox(height: 14),
                                    if (vm.videoPaths.isNotEmpty)
                                      SizedBox(
                                        height: 64,
                                        child: ListView.separated(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: vm.videoPaths.length,
                                          separatorBuilder: (_, __) =>
                                              const SizedBox(width: 10),
                                          itemBuilder: (context, i) {
                                            final name = vm.videoPaths[i]
                                                .split('/')
                                                .last;
                                            return Container(
                                              width: 150,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFF7F9F5),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                  color: Colors.grey[200]!,
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.videocam_rounded,
                                                    size: 18,
                                                    color: Color(0xFF1E2022),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Expanded(
                                                    child: Text(
                                                      name,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium
                                                          ?.copyWith(
                                                            fontSize: 11.5,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () =>
                                                        vm.removeVideoAt(i),
                                                    child: const Icon(
                                                      Icons.close_rounded,
                                                      size: 16,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    if (vm.videoPaths.isNotEmpty)
                                      const SizedBox(height: 14),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: MediaButton(
                                            icon: Icons
                                                .add_photo_alternate_rounded,
                                            label: 'Ajouter des images',
                                            onTap: vm.pickImages,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: MediaButton(
                                            icon: Icons.video_call_rounded,
                                            label: 'Ajouter des vidéos',
                                            onTap: vm.pickVideo,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SectionCard(
                                title: 'Documents',
                                icon: Icons.folder_rounded,
                                subtitle: 'Joignez les documents pertinents',
                                child: Column(
                                  children: [
                                    if (vm.documents.isNotEmpty)
                                      Column(
                                        children: List.generate(
                                          vm.documents.length,
                                          (i) {
                                            final doc = vm.documents[i];
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                bottom: 8,
                                              ),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 10,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: const Color(
                                                    0xFFF7F9F5,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  border: Border.all(
                                                    color: Colors.grey[200]!,
                                                  ),
                                                ),
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                      Icons
                                                          .insert_drive_file_rounded,
                                                      size: 18,
                                                      color: Color(0xFF1E2022),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Expanded(
                                                      child: Text(
                                                        doc.name,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium
                                                            ?.copyWith(
                                                              fontSize: 12.5,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () => vm
                                                          .removeDocumentAt(i),
                                                      child: const Icon(
                                                        Icons.close_rounded,
                                                        size: 17,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    if (vm.documents.isNotEmpty)
                                      const SizedBox(height: 4),
                                    MediaButton(
                                      icon: Icons.upload_file_rounded,
                                      label: 'Ajouter des documents',
                                      onTap: vm.pickDocuments,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
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
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: vm.isStep1
              ? SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              onPressed: vm.isLoading ? null : vm.nextStep,
              title: "Suivant",
            ),
          )
              : Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: vm.isLoading ? null : vm.previousStep,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    foregroundColor: const Color(0xFF1E2022),
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Précédent',
                    style: Theme.of(context).textTheme.bodyMedium
                        ?.copyWith(
                      fontSize: 15.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                  child: PrimaryButton(
                    title: "Publier",
                    onPressed: () async {

                    },
                  )
              ),
            ],
          ),
        ),
      ),

    );
  }

  Widget _buildStepIndicator(int step, int currentStep, BuildContext context) {
    final isActive = step == currentStep;
    final isCompleted = step < currentStep;
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive || isCompleted
            ? const Color(0xFF6FA83A)
            : Colors.grey[300],
      ),
      child: Center(
        child: isCompleted
            ? const Icon(Icons.check, size: 18, color: Colors.white)
            : Text(
                step.toString(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }

  Widget _buildStepLine(bool isCompleted) {
    return Container(
      height: 3,
      decoration: BoxDecoration(
        color: isCompleted ? const Color(0xFF6FA83A) : Colors.grey[300],
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
