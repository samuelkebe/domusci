import 'package:flutter/material.dart';
import 'package:pisso/models/annonce.dart';
import 'package:pisso/models/enum/statut_annonce.dart';

import '../../resources/color.dart';
import '../../utils/format_amount.dart';

class DetailAnnonceView extends StatefulWidget {
  final Annonce annonce;

  const DetailAnnonceView({super.key, required this.annonce});

  @override
  State<DetailAnnonceView> createState() => _DetailAnnonceViewState();
}

class _DetailAnnonceViewState extends State<DetailAnnonceView> with SingleTickerProviderStateMixin {
  int _currentImage = 0;
  late PageController _pageController;
  late AnimationController _heartAnimationController;
  bool _isFavorite = false;

  static const double _imageHeight = 380;
  static const _primaryDark = Color(0xFF1E2022);
  static const _gradientStart = Color(0xFF7BC96F);
  static const _gradientEnd = Color(0xFF3E8E41);

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _heartAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _heartAnimationController.dispose();
    super.dispose();
  }

  List<String> get _images {
    final annonceImages = widget.annonce.images;
    if (annonceImages != null && annonceImages.isNotEmpty) {
      return annonceImages;
    }
    final bienPhotos = widget.annonce.bienImmobilier?.photos;
    if (bienPhotos != null && bienPhotos.isNotEmpty) {
      return bienPhotos;
    }
    final fallback = widget.annonce.bienImmobilier?.imageUrl;
    return [
      if (fallback != null) fallback,
      if (fallback == null)
          'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=1200&q=80',
    ];
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: _primaryDark,
            ),
          ),
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
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
            // Image header
            Stack(
              children: [
                SizedBox(
                  height: _imageHeight,
                  width: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      PageView.builder(
                        controller: _pageController,
                        itemCount: _images.length,
                        onPageChanged: (i) => setState(() => _currentImage = i),
                        itemBuilder: (context, index) {
                          return Image.network(
                            _images[index],
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                color: Colors.grey[200],
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: _gradientStart,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                      // Gradient overlay
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        height: 120,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.3),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Page indicators
                      if (_images.length > 1)
                        Positioned(
                          bottom: 16,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(_images.length, (i) {
                              final active = i == _currentImage;
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.symmetric(horizontal: 3),
                                width: active ? 20 : 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: active ? _gradientStart : Colors.white.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              );
                            }),
                          ),
                        ),
                    ],
                  ),
                ),
                // Navigation buttons overlay
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
            // Details panel
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 20,
                      offset: Offset(0, -4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title and price
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.annonce.libelle ?? 'Annonce',
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  formatAmount(widget.annonce.bienImmobilier?.prix),
                                  maxLines: 1,
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            // Type and status
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: _gradientStart.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    widget.annonce.typeOffre?.name ?? 'Non spécifié',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: _gradientStart,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: widget.annonce.statutAnnonce == StatutAnnonce.VALABLE
                                        ? Colors.green.withOpacity(0.1)
                                        : Colors.red.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    widget.annonce.statutAnnonce?.name.replaceAll('_', '-') ?? 'Non spécifié',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: widget.annonce.statutAnnonce == StatutAnnonce.VALABLE
                                          ? Colors.green
                                          : Colors.red,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            // Address
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  size: 18,
                                  color: AppColors.black,
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    widget.annonce.bienImmobilier?.adresse ?? 'Adresse non spécifiée',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: AppColors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            // Stats
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF5F7FA),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.bed_outlined,
                                          size: 18,
                                          color: AppColors.black,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          widget.annonce.bienImmobilier?.chambres ?? '-',
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.black,
                                          ),
                                        ),
                                        Text(
                                          'Chambres',
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            color: AppColors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF5F7FA),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.bathtub_outlined,
                                          size: 18,
                                          color: Colors.grey[600],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          widget.annonce.bienImmobilier?.sallesDeBain ?? '-',
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xFF1E2022),
                                          ),
                                        ),
                                        Text(
                                          'SDB',
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            color: AppColors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF5F7FA),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.local_parking_outlined,
                                          size: 18,
                                          color: Colors.grey[600],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '${widget.annonce.bienImmobilier?.parking ?? '-'}',
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xFF1E2022),
                                          ),
                                        ),
                                        Text(
                                          'Parking',
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            color: AppColors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF5F7FA),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.square_foot_outlined,
                                          size: 18,
                                          color: Colors.grey[600],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '${widget.annonce.bienImmobilier?.surface ?? '-'}m²',
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xFF1E2022),
                                          ),
                                        ),
                                        Text(
                                          'Surface',
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            color: AppColors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            // Description
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8FAFE),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: const Color(0xFFEEF2F7),
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.description_outlined,
                                        size: 20,
                                        color: AppColors.black,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Description',
                                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: _primaryDark,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    widget.annonce.description ?? 'Aucune description disponible',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: Colors.grey[700],
                                      height: 1.6,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Additional info
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8FAFE),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: const Color(0xFFEEF2F7),
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.info_outline,
                                        size: 20,
                                        color: AppColors.black,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Informations supplémentaires',
                                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: _primaryDark,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  _buildInfoRow('Type de bien', widget.annonce.typeBienImmobilier?.libelle ?? '-'),
                                  _buildInfoRow('Négociable', widget.annonce.negociable == true ? 'Oui' : 'Non'),
                                  _buildInfoRow('Disponible', widget.annonce.disponible == true ? 'Oui' : 'Non'),
                                  if (widget.annonce.dateLiberation != null)
                                    _buildInfoRow('Date de libération', _formatDate(widget.annonce.dateLiberation!)),
                                  if (widget.annonce.dateCreation != null)
                                    _buildInfoRow('Date de création', _formatDate(widget.annonce.dateCreation!)),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey[200],
                                      foregroundColor: Colors.black,
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text('Retour'),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Action pour contacter
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: _gradientStart,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text('Contacter'),
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
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
  }
}
