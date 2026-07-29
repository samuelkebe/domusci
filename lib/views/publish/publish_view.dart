import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/lucide.dart';
import 'package:provider/provider.dart';
import '../../models/property.dart';
import '../../ressources/app_colors.dart';
import '../../ressources/app_spacing.dart';
import '../../ressources/app_text_styles.dart';
import '../../views-models/publish_view_model.dart';
import '../widgets/app_bar/domus_app_bar.dart';
import '../widgets/buttons/primary_button.dart';
import '../widgets/buttons/secondary_button.dart';
import '../widgets/chips/category_chip.dart';
import '../widgets/forms/domus_text_field.dart';

const _publishTypes = [
  (type: PropertyType.appartement, label: 'Appartement', icon: Lucide.building_2),
  (type: PropertyType.maison, label: 'Maison', icon: Lucide.home),
  (type: PropertyType.villa, label: 'Villa', icon: Lucide.landmark),
  (type: PropertyType.terrain, label: 'Terrain', icon: Lucide.map),
];

/// Vue — Publier une annonce (photos, localisation, prix, description).
class PublishView extends StatelessWidget {
  const PublishView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PublishViewModel(),
      child: Consumer<PublishViewModel>(
        builder: (context, vm, _) {
          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: DomusAppBar(title: 'Publier un bien'),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Étape ${vm.currentStep + 1}/${PublishViewModel.totalSteps}',
                          style: AppTextStyles.bodySm.copyWith(color: AppColors.primary, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: LinearProgressIndicator(
                      value: (vm.currentStep + 1) / PublishViewModel.totalSteps,
                      minHeight: 6,
                      backgroundColor: AppColors.border,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 6, 20, 24),
                    child: _stepContent(vm),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: Container(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 26),
              decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: AppColors.border))),
              child: Row(
                children: [
                  if (vm.currentStep > 0) ...[
                    Expanded(child: SecondaryButton(label: 'Retour', onPressed: vm.previousStep)),
                    const SizedBox(width: 10),
                  ],
                  Expanded(
                    flex: 2,
                    child: PrimaryButton(
                      title: vm.currentStep == PublishViewModel.totalSteps - 1 ? 'Publier' : 'Continuer',
                      onPressed: () async {
                        if (vm.currentStep == PublishViewModel.totalSteps - 1) {
                          final ok = await vm.submit();
                          if (ok && context.mounted) {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Votre annonce a été publiée avec succès ✅'), backgroundColor: AppColors.success),
                            );
                          } else if (vm.errorMessage != null && context.mounted) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(vm.errorMessage!), backgroundColor: AppColors.error));
                          }
                        } else {
                          vm.nextStep();
                        }
                      },
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

  Widget _stepContent(PublishViewModel vm) {
    switch (vm.currentStep) {
      case 0:
        return _StepPhotosAndType(vm: vm);
      case 1:
        return _StepDetails(vm: vm);
      default:
        return _StepPreview(vm: vm);
    }
  }
}

class _StepPhotosAndType extends StatelessWidget {
  final PublishViewModel vm;
  const _StepPhotosAndType({required this.vm});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Photos du bien', style: AppTextStyles.h4),
        const SizedBox(height: 10),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: AppColors.background,
                  border: Border.all(color: AppColors.secondary, width: 1.4),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Iconify(Lucide.camera, color: AppColors.primary, size: 20),
                    SizedBox(height: 4),
                    Text('Ajouter', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.primary)),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        Text('Type de bien', style: AppTextStyles.h4),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _publishTypes
              .map((t) => DomusChip(
                    label: t.label,
                    icon: t.icon,
                    active: vm.selectedType == t.type,
                    onTap: () => vm.setType(t.type),
                  ))
              .toList(),
        ),
        const SizedBox(height: AppSpacing.lg),
        DomusTextField(
          label: "Titre de l'annonce",
          hint: 'Ex : Belle villa avec piscine à Riviera',
          onChanged: (v) => vm.updateField(title: v),
        ),
      ],
    );
  }
}

class _StepDetails extends StatelessWidget {
  final PublishViewModel vm;
  const _StepDetails({required this.vm});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DomusTextField(
          label: 'Localisation (quartier)',
          hint: 'Ex : Cocody, Riviera Golf',
          suffix: const Iconify(Lucide.map_pin, size: 16, color: AppColors.primary),
          onChanged: (v) => vm.updateField(quartier: v),
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: DomusTextField(
                label: 'Prix (FCFA)',
                hint: '350 000',
                keyboardType: TextInputType.number,
                onChanged: (v) => vm.updateField(price: v),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: DomusTextField(
                label: 'Surface (m²)',
                hint: '120',
                keyboardType: TextInputType.number,
                onChanged: (v) => vm.updateField(surface: v),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        DomusTextField(
          label: 'Description',
          hint: 'Décrivez votre bien : atouts, environnement, sécurité…',
          maxLines: 4,
          onChanged: (v) => vm.updateField(description: v),
        ),
      ],
    );
  }
}

class _StepPreview extends StatelessWidget {
  final PublishViewModel vm;
  const _StepPreview({required this.vm});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Prévisualisation', style: AppTextStyles.h4),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: AppColors.border)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(vm.title.isEmpty ? 'Titre de votre annonce' : vm.title, style: AppTextStyles.h4),
              const SizedBox(height: 4),
              Text(vm.quartier.isEmpty ? 'Quartier' : vm.quartier, style: AppTextStyles.bodySm),
              const SizedBox(height: 10),
              Text(vm.price.isEmpty ? '—' : '${vm.price} FCFA', style: AppTextStyles.priceMd),
              const SizedBox(height: 10),
              Text(vm.description.isEmpty ? 'Aucune description ajoutée.' : vm.description, style: AppTextStyles.bodySm),
            ],
          ),
        ),
      ],
    );
  }
}
