import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:pisso/models/bien_immobilier_model.dart';

class Immersive3DView extends StatefulWidget {
  final BienImmobilier bienImmobilier;

  const Immersive3DView({super.key, required this.bienImmobilier});

  @override
  State<Immersive3DView> createState() => _Immersive3DViewState();
}

class _Immersive3DViewState extends State<Immersive3DView> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late WebViewController _webViewController;
  
  bool _showControls = true;
  bool _showRoomIndicators = true;
  String _currentRoom = 'Salon';
  bool _isLoading = true;
  
  final List<String> _rooms = ['Salon', 'Cuisine', 'Chambre principale', 'Salle de bain', 'Terrasse'];
  final List<String> _roomModels = [
    'https://modelviewer.dev/shared-assets/models/Astronaut.glb',
    'https://modelviewer.dev/shared-assets/models/Astronaut.glb',
    'https://modelviewer.dev/shared-assets/models/Astronaut.glb',
    'https://modelviewer.dev/shared-assets/models/Astronaut.glb',
    'https://modelviewer.dev/shared-assets/models/Astronaut.glb',
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
    );
    
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFF1a1a1a))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => setState(() => _isLoading = true),
          onPageFinished: (_) => setState(() => _isLoading = false),
        ),
      )
      ..loadHtmlString(_getModelViewerHtml(_roomModels[_rooms.indexOf(_currentRoom)]));
    
    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });
    HapticFeedback.lightImpact();
  }

  void _toggleRoomIndicators() {
    setState(() {
      _showRoomIndicators = !_showRoomIndicators;
    });
    HapticFeedback.lightImpact();
  }

  void _navigateToRoom(int index) {
    setState(() {
      _currentRoom = _rooms[index];
      _isLoading = true;
    });
    _webViewController.loadHtmlString(_getModelViewerHtml(_roomModels[index]));
    HapticFeedback.mediumImpact();
  }

  String _getModelViewerHtml(String modelUrl) {
    return '''
    <!DOCTYPE html>
    <html>
    <head>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <script type="module" src="https://ajax.googleapis.com/ajax/libs/model-viewer/3.3.0/model-viewer.js"></script>
      <style>
        body {
          margin: 0;
          padding: 0;
          background-color: #1a1a1a;
          overflow: hidden;
        }
        model-viewer {
          width: 100vw;
          height: 100vh;
        }
      </style>
    </head>
    <body>
      <model-viewer
        src="$modelUrl"
        alt="Modèle 3D"
        auto-rotate
        camera-controls
        disable-zoom="false"
        touch-action="pan-y"
        style="width: 100%; height: 100%;">
      </model-viewer>
    </body>
    </html>
    ''';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            color: const Color(0xFF1a1a1a),
            child: WebViewWidget(controller: _webViewController),
          ),
          if (_isLoading)
            Container(
              color: const Color(0xFF1a1a1a),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF7BC96F),
                ),
              ),
            ),
          
          AnimatedBuilder(
            animation: _fadeAnimation,
            builder: (context, child) {
              return Opacity(
                opacity: _fadeAnimation.value,
                child: child,
              );
            },
            child: _buildHeader(),
          ),
          
          AnimatedBuilder(
            animation: _fadeAnimation,
            builder: (context, child) {
              return Opacity(
                opacity: _fadeAnimation.value,
                child: child,
              );
            },
            child: _buildRoomIndicators(),
          ),
          
          if (_showControls)
            AnimatedBuilder(
              animation: _slideAnimation,
              builder: (context, child) {
                return SlideTransition(
                  position: _slideAnimation,
                  child: child,
                );
              },
              child: _buildControls(),
            ),
          
          _buildInfoButton(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  Navigator.pop(context);
                },
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.view_in_ar_rounded,
                        color: Color(0xFF7BC96F),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.bienImmobilier.titre ?? 'Bien immobilier',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              _currentRoom,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: _toggleControls,
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
                  ),
                  child: Icon(
                    _showControls ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoomIndicators() {
    if (!_showRoomIndicators) return const SizedBox.shrink();
    
    return Positioned(
      top: 100,
      right: 16,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.6),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(_rooms.length, (index) {
            final isSelected = _rooms[index] == _currentRoom;
            return GestureDetector(
              onTap: () => _navigateToRoom(index),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF7BC96F).withOpacity(0.3) : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                      color: isSelected ? const Color(0xFF7BC96F) : Colors.white.withOpacity(0.5),
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _rooms[index],
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.white.withOpacity(0.7),
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildControls() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.8),
              ],
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildControlButton(
                    icon: Icons.explore,
                    label: 'Explorer',
                    onTap: () {
                      HapticFeedback.lightImpact();
                    },
                  ),
                  _buildControlButton(
                    icon: Icons.camera_alt,
                    label: 'Photo',
                    onTap: () {
                      HapticFeedback.lightImpact();
                    },
                  ),
                  _buildControlButton(
                    icon: Icons.fullscreen,
                    label: 'Plein écran',
                    onTap: () {
                      HapticFeedback.lightImpact();
                    },
                  ),
                  _buildControlButton(
                    icon: Icons.info_outline,
                    label: 'Info',
                    onTap: () {
                      HapticFeedback.lightImpact();
                      _showInfoSheet();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildNavigationPad(),
                  ),
                  const SizedBox(width: 16),
                  _buildJoystick(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationPad() {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildNavButton(Icons.keyboard_arrow_up, () => HapticFeedback.lightImpact()),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildNavButton(Icons.keyboard_arrow_left, () => HapticFeedback.lightImpact()),
              const SizedBox(width: 40),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF7BC96F).withOpacity(0.3),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF7BC96F), width: 2),
                ),
                child: const Icon(
                  Icons.navigation,
                  color: Color(0xFF7BC96F),
                  size: 20,
                ),
              ),
              const SizedBox(width: 40),
              _buildNavButton(Icons.keyboard_arrow_right, () => HapticFeedback.lightImpact()),
            ],
          ),
          const SizedBox(height: 8),
          _buildNavButton(Icons.keyboard_arrow_down, () => HapticFeedback.lightImpact()),
        ],
      ),
    );
  }

  Widget _buildNavButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
        ),
        child: Icon(icon, color: Colors.white, size: 24),
      ),
    );
  }

  Widget _buildJoystick() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
      ),
      child: Center(
        child: Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF7BC96F), Color(0xFF3E8E41)],
            ),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.pan_tool,
            color: Colors.white,
            size: 24,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoButton() {
    return Positioned(
      bottom: 200,
      left: 16,
      child: GestureDetector(
        onTap: _toggleRoomIndicators,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
          ),
          child: Icon(
            _showRoomIndicators ? Icons.layers : Icons.layers_outlined,
            color: Colors.white,
            size: 22,
          ),
        ),
      ),
    );
  }

  void _showInfoSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Color(0xFF1a1a1a),
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF7BC96F).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.info_outline,
                    color: Color(0xFF7BC96F),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                const Text(
                  'Informations sur la visite',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildInfoItem(
              icon: Icons.touch_app,
              title: 'Navigation tactile',
              description: 'Glissez pour faire pivoter la vue',
            ),
            const SizedBox(height: 12),
            _buildInfoItem(
              icon: Icons.zoom_in,
              title: 'Zoom',
              description: 'Pincez pour zoomer ou dézoomer',
            ),
            const SizedBox(height: 12),
            _buildInfoItem(
              icon: Icons.explore,
              title: 'Pièces',
              description: 'Sélectionnez une pièce dans le menu',
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7BC96F),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Fermer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

