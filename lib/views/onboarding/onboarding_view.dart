import 'package:flutter/material.dart';

import '../../components/primary_button.dart';
import '../../resources/color.dart';
import '../auth/login_view.dart';

class OnboardData {
  final String image;
  final String title;
  final String description;

  const OnboardData({
    required this.image,
    required this.title,
    required this.description,
  });
}

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();

  int currentPage = 0;

  final pages = const [
    OnboardData(
      image:
      'https://lh3.googleusercontent.com/aida-public/AB6AXuAxZIpOxVjpbctTG0wCzRV7VOfx9wCncBafQl7lluuLfCDEqMyuUGHqiFeyGC6AXidBV7qEJUCUf_qSTgq_ie0-jxaP6FBzybeZdIGBtpIa185hOJv2WDRsCKBqlkYe2eaWN_XvJlzl09iOsCux0AUKxryQFHVnz-Wzf_e31SyOuwDjByzK51sOH0TW0cntv_8kurPAZtI1227Q2yN5N9HKqPJv2a9iifisge2fUYyJyrKnx0nRWsr59K3yb3q3Z-x17vgMmUt1wvqC',
      title: "Trouvez votre futur logement facilement.",
      description: "Parcourez une sélection exclusive d'appartements et de studios au cœur d'Abidjan.",
    ),
    OnboardData(
      image:
      "https://images.unsplash.com/photo-1484154218962-a197022b5858?q=80&w=1200",
      title: "Achetez votre maison en toute sécurité.",
      description: "Des transactions accompagnées et des biens vérifiés par nos équipes.",
    ),
    OnboardData(
      image:
      "https://images.unsplash.com/photo-1512917774080-9991f1c4c750?q=80&w=1200",
      title: "Publiez votre bien gratuitement.",
      description: "Mettez votre bien en ligne en quelques minutes et touchez des milliers d'acheteurs.",
    ),
  ];

  void nextPage() {
    if (currentPage == pages.length - 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginView()),
      );
      return;
    }

    _pageController.nextPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  void skip() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: pages.length,
        onPageChanged: (value) {
          setState(() {
            currentPage = value;
          });
        },
        itemBuilder: (context, index) {
          final page = pages[index];

          return Stack(
            fit: StackFit.expand,
            children: [

              /// Image
              Image.network(
                page.image,
                fit: BoxFit.cover,
              ),

              /// Dégradé sombre
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black26,
                      Colors.black87,
                    ],
                  ),
                ),
              ),

              /// Bouton Ignorer
              SafeArea(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextButton(
                      onPressed: skip,
                      child: const Text(
                        "Ignorer",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),

              /// Contenu
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const Spacer(),

                      Text(
                        page.title,
                        style: Theme.of(context).textTheme.titleLarge
                            ?.copyWith(
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 16),

                      Text(
                        page.description,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                          color: Colors.white70,
                        ),
                      ),

                      const SizedBox(height: 40),

                      /// Indicateur
                      Row(
                        children: List.generate(
                          pages.length,
                              (i) => AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            margin: const EdgeInsets.only(right: 8),
                            width: currentPage == i ? 28 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: currentPage == i
                                  ? AppColors.green2
                                  : Colors.white30,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      PrimaryButton(
                        title: currentPage == pages.length - 1
                            ? "Commencer"
                            : "Suivant",
                        onPressed: nextPage,
                      ),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
