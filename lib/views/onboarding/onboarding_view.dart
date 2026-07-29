import 'package:flutter/material.dart';
import '../../ressources/app_colors.dart';
import '../../ressources/app_strings.dart';
import '../../ressources/app_text_styles.dart';
import '../auth/login_view.dart';
import '../widgets/buttons/primary_button.dart';

class _OnboardData {
  final String image;
  final String title;
  final String desc;
  const _OnboardData(this.image, this.title, this.desc);
}

/// Vue — Onboarding en 3 écrans avec pagination fluide.
class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final _controller = PageController();
  int _index = 0;

  final _pages = const [
    _OnboardData(
      'https://lh3.googleusercontent.com/aida-public/AB6AXuAxZIpOxVjpbctTG0wCzRV7VOfx9wCncBafQl7lluuLfCDEqMyuUGHqiFeyGC6AXidBV7qEJUCUf_qSTgq_ie0-jxaP6FBzybeZdIGBtpIa185hOJv2WDRsCKBqlkYe2eaWN_XvJlzl09iOsCux0AUKxryQFHVnz-Wzf_e31SyOuwDjByzK51sOH0TW0cntv_8kurPAZtI1227Q2yN5N9HKqPJv2a9iifisge2fUYyJyrKnx0nRWsr59K3yb3q3Z-x17vgMmUt1wvqC',
      AppStrings.onboarding1Title,
      AppStrings.onboarding1Desc,
    ),
    _OnboardData(
      'https://images.unsplash.com/photo-1560184897-ae75f418493e?q=80&w=900&auto=format&fit=crop',
      AppStrings.onboarding2Title,
      AppStrings.onboarding2Desc,
    ),
    _OnboardData(
      'https://images.unsplash.com/photo-1524230572899-a752b3835840?q=80&w=900&auto=format&fit=crop',
      AppStrings.onboarding3Title,
      AppStrings.onboarding3Desc,
    ),
  ];

  void _next() {
    if (_index < _pages.length - 1) {
      _controller.nextPage(duration: const Duration(milliseconds: 350), curve: Curves.easeOut);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (i) => setState(() => _index = i),
                itemBuilder: (context, i) {
                  final data = _pages[i];
                  return Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.48,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(data.image, fit: BoxFit.cover,
                                errorBuilder: (c, e, s) => Container(color: AppColors.tertiary)),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [AppColors.primary.withOpacity(0.05), Colors.white.withOpacity(0.98)],
                                  stops: const [0.0, 0.96],
                                ),
                              ),
                            ),
                            if (i < _pages.length - 1)
                              Positioned(
                                top: 20,
                                right: 20,
                                child: GestureDetector(
                                  onTap: () => Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (_) => const LoginView()),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                    decoration: BoxDecoration(color: Colors.black.withOpacity(0.28), borderRadius: BorderRadius.circular(100)),
                                    child: const Text('Passer', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700)),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(28, 8, 28, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              Text(data.title, style: AppTextStyles.h2),
                              const SizedBox(height: 10),
                              Text(data.desc, style: AppTextStyles.bodySm.copyWith(fontSize: 13.5)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 0, 28, 30),
              child: Row(
                children: [
                  Row(
                    children: List.generate(_pages.length, (i) {
                      final active = i == _index;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.only(right: 6),
                        width: active ? 20 : 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: active ? AppColors.primary : AppColors.tertiary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 3,
                    child: PrimaryButton(
                      title: _index == _pages.length - 1 ? AppStrings.start : 'Suivant',
                      onPressed: _next,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
