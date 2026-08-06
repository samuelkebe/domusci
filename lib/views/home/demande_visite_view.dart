import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pisso/models/bien_immobilier_model.dart';
import 'package:pisso/models/enum/type_visite.dart';
import 'package:pisso/resources/color.dart';
import 'package:pisso/resources/app_theme.dart';
import 'package:pisso/views-models/home_view_model.dart';
import 'package:provider/provider.dart';

import '../../components/section_card.dart';
import '../../components/primary_button.dart';
import '../../utils/app_utils.dart';

class DemandeVisiteView extends StatefulWidget {
  final BienImmobilier? bienImmobilier;

  const DemandeVisiteView({super.key, this.bienImmobilier});

  @override
  State<DemandeVisiteView> createState() => _DemandeVisiteViewState();
}

class _DemandeVisiteViewState extends State<DemandeVisiteView> {
  // Controllers
  final TextEditingController _heureController = TextEditingController();

  // Variables d'état
  TypeVisite? _selectedTypeVisite;
  DateTime? _selectedDate;
  TimeOfDay? _selectedHeure;
  bool _isLoading = false;
  bool _isPaid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HomeViewModel>(builder: (context, value, child) {
         return Container(
           decoration: const BoxDecoration(
             gradient: LinearGradient(
               begin: Alignment.topCenter,
               end: Alignment.bottomCenter,
               colors: [Color(0xFFEAF5DE), Color(0xFFF7FAF2)],
             ),
           ),
           child: SafeArea(
             child: Column(
               children: [
                 AppBar(
                   backgroundColor: Colors.transparent,
                   elevation: 0,
                   leading: IconButton(
                     icon: Container(
                       padding: const EdgeInsets.all(8),
                       decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.circular(12),
                         boxShadow: [
                           BoxShadow(
                             color: Colors.black.withOpacity(0.05),
                             blurRadius: 10,
                             offset: const Offset(0, 4),
                           ),
                         ],
                       ),
                       child: const Icon(Icons.arrow_back_ios_new, size: 18),
                     ),
                     onPressed: () => Navigator.pop(context),
                   ),
                   title: Text(
                     'Demande de Visite',
                     style: Theme.of(context).textTheme.titleMedium?.copyWith(
                       fontWeight: FontWeight.w700,
                       color: AppColors.black,
                     ),
                   ),
                 ),
                 Expanded(
                   child: SingleChildScrollView(
                     padding: const EdgeInsets.fromLTRB(20, 16, 20, 140),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Container(
                           padding: const EdgeInsets.all(20),
                           decoration: BoxDecoration(
                             gradient: const LinearGradient(
                               begin: Alignment.topLeft,
                               end: Alignment.bottomRight,
                               colors: [Color(0xFF7BC96F), Color(0xFF3E8E41)],
                             ),
                             borderRadius: BorderRadius.circular(20),
                             boxShadow: [
                               BoxShadow(
                                 color: const Color(0xFF7BC96F).withOpacity(0.3),
                                 blurRadius: 20,
                                 offset: const Offset(0, 8),
                               ),
                             ],
                           ),
                           child: Row(
                             children: [
                               Container(
                                 padding: const EdgeInsets.all(12),
                                 decoration: BoxDecoration(
                                   color: AppColors.white.withOpacity(0.2),
                                   borderRadius: BorderRadius.circular(16),
                                 ),
                                 child: const Icon(
                                   Icons.home_work_outlined,
                                   color: AppColors.white,
                                   size: 28,
                                 ),
                               ),
                               const SizedBox(width: 16),
                               Expanded(
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Text(
                                       value.selectedBienImmobilier?.titre ?? 'Bien immobilier',
                                       style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                         color: AppColors.white,
                                         fontWeight: FontWeight.w600,
                                       ),
                                       maxLines: 1,
                                       overflow: TextOverflow.ellipsis,
                                     ),
                                     const SizedBox(height: 4),
                                     Text(
                                       value.selectedBienImmobilier?.adresse ?? 'Adresse non spécifiée',
                                       style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                         color: AppColors.white.withOpacity(0.8),
                                       ),
                                       maxLines: 1,
                                       overflow: TextOverflow.ellipsis,
                                     ),
                                   ],
                                 ),
                               ),
                             ],
                           ),
                         ),
                         const SizedBox(height: 24),
                         Column(
                           children: [
                             if (value.selectedBienImmobilier != null)
                               SectionCard(
                                 title: 'Bien sélectionné',
                                 icon: Icons.apartment_outlined,
                                 // subtitle: bien.adresse,
                                 child: Container(
                                   padding: const EdgeInsets.all(16),
                                   decoration: BoxDecoration(
                                     color: const Color(0xFFF7F9F5),
                                     borderRadius: BorderRadius.circular(14),
                                     border: Border.all(
                                       color: const Color(0xFF8FBF3F).withOpacity(0.5),
                                     ),
                                   ),
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Text(
                                         value.selectedBienImmobilier?.titre ?? 'Bien immobilier',
                                         style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                           fontWeight: FontWeight.w600,
                                           color: const Color(0xFF1E2022),
                                         ),
                                       ),
                                       const SizedBox(height: 8),
                                       Row(
                                         children: [
                                           Icon(
                                             Icons.location_on_outlined,
                                             size: 16,
                                             color: const Color(0xFF1E2022),
                                           ),
                                           const SizedBox(width: 4),
                                           Expanded(
                                             child: Text(
                                               value.selectedBienImmobilier?.adresse ?? 'Adresse non spécifiée',
                                               style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                 color: const Color(0xFF1E2022),
                                               ),
                                             ),
                                           ),
                                         ],
                                       ),
                                       const SizedBox(height: 8),
                                       Row(
                                         children: [
                                           Icon(
                                             Icons.attach_money_outlined,
                                             size: 16,
                                             color: const Color(0xFF7BC96F),
                                           ),
                                           const SizedBox(width: 4),
                                           Text(
                                             formatAmount(value.selectedBienImmobilier?.prix),
                                             style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                               fontWeight: FontWeight.w700,
                                               color: const Color(0xFF7BC96F),
                                             ),
                                           ),
                                         ],
                                       ),
                                     ],
                                   ),
                                 ),
                               ),
                             SectionCard(
                               title: 'Type de visite',
                               icon: Icons.visibility_outlined,
                               // subtitle: 'Choisissez le mode de visite',
                               child: Container(
                                 padding: const EdgeInsets.symmetric(horizontal: 16),
                                 decoration: BoxDecoration(
                                   color: const Color(0xFFF7F9F5),
                                   borderRadius: BorderRadius.circular(14),
                                   border: Border.all(
                                     color: const Color(0xFF8FBF3F).withOpacity(0.5),
                                   ),
                                 ),
                                 child: DropdownButtonHideUnderline(
                                   child: DropdownButton<TypeVisite>(
                                     value: _selectedTypeVisite,
                                     hint: Text(
                                       'Sélectionnez une option',
                                       style: TextStyle(
                                         color: Colors.grey[400],
                                         fontSize: 15,
                                       ),
                                     ),
                                     isExpanded: true,
                                     icon: Icon(
                                       Icons.keyboard_arrow_down_rounded,
                                       color: const Color(0xFF7BC96F),
                                     ),
                                     style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                       color: const Color(0xFF1E2022),
                                       fontSize: 15,
                                       fontWeight: FontWeight.w500,
                                     ),
                                     items: TypeVisite.values.map((TypeVisite type) {
                                       return DropdownMenuItem<TypeVisite>(
                                         value: type,
                                         child: Text(type.label),
                                       );
                                     }).toList(),
                                     onChanged: (TypeVisite? value) {
                                       setState(() {
                                         _selectedTypeVisite = value;
                                         if (value != TypeVisite.SUR_SITE) {
                                           _selectedDate = null;
                                           _selectedHeure = null;
                                         }
                                       });
                                     },
                                   ),
                                 ),
                               ),
                             ),
                             if (_selectedTypeVisite == TypeVisite.SUR_SITE)
                               SectionCard(
                                 title: 'Planification',
                                 icon: Icons.calendar_today_outlined,
                                 // subtitle: 'Sélectionnez date et heure',
                                 child: Column(
                                   children: [
                                     // date
                                     InkWell(
                                       onTap: _selectDate,
                                       borderRadius: BorderRadius.circular(14),
                                       child: Container(
                                         width: double.infinity,
                                         padding: const EdgeInsets.symmetric(vertical: 13),
                                         decoration: BoxDecoration(
                                           color: const Color(0xFFF7F9F5),
                                           borderRadius: BorderRadius.circular(14),
                                           border: Border.all(
                                             color: const Color(0xFF8FBF3F).withOpacity(0.5),
                                           ),
                                         ),
                                         child: Row(
                                           mainAxisAlignment: MainAxisAlignment.center,
                                           children: [
                                             Icon(
                                               Icons.calendar_today_outlined,
                                               color: _selectedDate != null
                                                   ? const Color(0xFF7BC96F)
                                                   : Colors.grey[400],
                                               size: 17,
                                             ),
                                             const SizedBox(width: 8),
                                             Text(
                                               _selectedDate != null
                                                   ? DateFormat('EEEE d MMMM yyyy', 'fr').format(_selectedDate!)
                                                   : 'Sélectionnez une date',
                                               style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                 fontSize: 13,
                                                 fontWeight: FontWeight.w700,
                                                 color: const Color(0xFF1E2022),
                                               ),
                                             ),
                                           ],
                                         ),
                                       ),
                                     ),
                                     const SizedBox(height: 16),
                                     // heure
                                     InkWell(
                                       onTap: _selectTime,
                                       borderRadius: BorderRadius.circular(14),
                                       child: Container(
                                         width: double.infinity,
                                         padding: const EdgeInsets.symmetric(vertical: 13),
                                         decoration: BoxDecoration(
                                           color: const Color(0xFFF7F9F5),
                                           borderRadius: BorderRadius.circular(14),
                                           border: Border.all(
                                             color: const Color(0xFF8FBF3F).withOpacity(0.5),
                                           ),
                                         ),
                                         child: Row(
                                           mainAxisAlignment: MainAxisAlignment.center,
                                           children: [
                                             Icon(
                                               Icons.access_time_outlined,
                                               color: _selectedHeure != null
                                                   ? const Color(0xFF7BC96F)
                                                   : Colors.grey[400],
                                               size: 17,
                                             ),
                                             const SizedBox(width: 8),
                                             Text(
                                               _selectedHeure != null
                                                   ? _selectedHeure!.format(context)
                                                   : 'Sélectionnez une heure',
                                               style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                 fontSize: 13,
                                                 fontWeight: FontWeight.w700,
                                                 color: const Color(0xFF1E2022),
                                               ),
                                             ),
                                           ],
                                         ),
                                       ),
                                     ),
                                   ],
                                 ),
                               ),
                             if (_selectedTypeVisite == TypeVisite.VIRTUELLE)
                               SectionCard(
                                 title: 'Visite virtuelle',
                                 icon: Icons.videocam_outlined,
                                 // subtitle: 'Disponible immédiatement',
                                 child: Container(
                                   padding: const EdgeInsets.all(16),
                                   decoration: BoxDecoration(
                                     color: const Color(0xFFF7F9F5),
                                     borderRadius: BorderRadius.circular(14),
                                     border: Border.all(
                                       color: const Color(0xFF8FBF3F).withOpacity(0.5),
                                     ),
                                   ),
                                   child: Row(
                                     children: [
                                       Icon(
                                         Icons.videocam_outlined,
                                         color: const Color(0xFF1E2022),
                                       ),
                                       const SizedBox(width: 12),
                                       Expanded(
                                         child: Text(
                                           'La visite virtuelle sera disponible immédiatement après validation',
                                           style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                             color: const Color(0xFF1E2022),
                                           ),
                                         ),
                                       ),
                                     ],
                                   ),
                                 ),
                               ),
                           ],
                         ),
                         const SizedBox(height: 24),
                         SectionCard(
                           title: 'Récapitulatif',
                           icon: Icons.receipt_long_outlined,
                           // subtitle: 'Frais de visite',
                           child: Column(
                             children: [
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Text(
                                     'Frais de visite',
                                     style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                       color: const Color(0xFF1E2022),
                                     ),
                                   ),
                                   Row(
                                     children: [
                                       Text(
                                         '15 000',
                                         style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                           fontWeight: FontWeight.w700,
                                           color: const Color(0xFF7BC96F),
                                         ),
                                       ),
                                       const SizedBox(width: 4),
                                       Text(
                                         'FCFA',
                                         style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                           color: Colors.grey[500],
                                           fontWeight: FontWeight.w500,
                                         ),
                                       ),
                                     ],
                                   ),
                                 ],
                               ),
                               const SizedBox(height: 12),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Text(
                                     'Statut',
                                     style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                       color: const Color(0xFF1E2022),
                                     ),
                                   ),
                                   Container(
                                     padding: const EdgeInsets.symmetric(
                                       horizontal: 12,
                                       vertical: 4,
                                     ),
                                     decoration: BoxDecoration(
                                       color: _isPaid
                                           ? const Color(0xFFE1F57A).withOpacity(0.5)
                                           : AppColors.red.withOpacity(0.1),
                                       borderRadius: BorderRadius.circular(20),
                                     ),
                                     child: Text(
                                       _isPaid ? 'Payé' : 'En attente de paiement',
                                       style: TextStyle(
                                         fontSize: 13,
                                         fontWeight: FontWeight.w600,
                                         color: _isPaid ? const Color(0xFF2E7D32) : AppColors.red,
                                       ),
                                     ),
                                   ),
                                 ],
                               ),
                             ],
                           ),
                         )
                       ],
                     ),
                   ),
                 ),
               ],
             ),
           ),
         );
      },),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              onPressed: _isLoading ? null : _validateRequest,
              title: _isLoading ? 'Chargement...' : (_isPaid ? 'Valider la demande' : 'Payer et valider'),
            ),
          ),
        ),
      ),
    );
  }


  // Méthodes
  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
      locale: const Locale('fr', 'FR'),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF7BC96F),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Color(0xFF1E2022),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF7BC96F),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Color(0xFF1E2022),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedHeure = picked;
      });
    }
  }

  void _validateRequest() {
    final bien = widget.bienImmobilier;
    if (bien == null) {
      _showSnackBar('Aucun bien sélectionné');
      return;
    }
    if (_selectedTypeVisite == null) {
      _showSnackBar('Veuillez sélectionner une option de visite');
      return;
    }
    if (_selectedTypeVisite == TypeVisite.SUR_SITE) {
      if (_selectedDate == null) {
        _showSnackBar('Veuillez sélectionner une date');
        return;
      }
      if (_selectedHeure == null) {
        _showSnackBar('Veuillez sélectionner une heure');
        return;
      }
    }

    setState(() {
      _isLoading = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
        _isPaid = true;
      });
      _showSuccessDialog();
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.warning_amber_rounded, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: const Color(0xFF7BC96F),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFE1F57A).withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_outline,
                  color: Color(0xFF2E7D32),
                  size: 48,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Demande validée !',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1E2022),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Votre demande de visite a été enregistrée avec succès',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF7BC96F).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Référence: #VST-${DateTime.now().millisecondsSinceEpoch.toString().substring(7, 12)}',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF7BC96F),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7BC96F),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text('Retour à l\'accueil'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _heureController.dispose();
    super.dispose();
  }
}
