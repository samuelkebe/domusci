import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/lucide.dart';
import 'package:provider/provider.dart';
import '../../ressources/app_colors.dart';
import '../../ressources/app_spacing.dart';
import '../../ressources/app_text_styles.dart';
import '../../views-models/auth_view_model.dart';
import '../home/home_shell_view.dart';
import '../widgets/buttons/primary_button.dart';

/// Vue — Vérification OTP (mot de passe oublié / inscription téléphone).
class OtpView extends StatefulWidget {
  const OtpView({super.key});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  final List<TextEditingController> _controllers = List.generate(4, (_) => TextEditingController());

  String get _code => _controllers.map((c) => c.text).join();

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthViewModel(),
      child: Consumer<AuthViewModel>(
        builder: (context, vm, _) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).maybePop(),
                      child: Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
                        child: const Iconify(Lucide.chevron_left, size: 18),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    Text('Vérification OTP', style: AppTextStyles.h1),
                    const SizedBox(height: 8),
                    Text('Entrez le code à 4 chiffres envoyé au +225 07 12 34 56 78', style: AppTextStyles.bodySm),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(4, (i) {
                        return SizedBox(
                          width: 64,
                          height: 64,
                          child: TextField(
                            controller: _controllers[i],
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            style: AppTextStyles.h2,
                            decoration: const InputDecoration(counterText: ''),
                            onChanged: (v) {
                              if (v.isNotEmpty && i < 3) FocusScope.of(context).nextFocus();
                              setState(() {});
                            },
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 28),
                    PrimaryButton(
                      title: 'Vérifier',
                      onPressed: _code.length == 4
                          ? () async {
                              final ok = await vm.verifyOtp(phone: '0712345678', code: _code);
                              if (!mounted) return;
                              if (ok) {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(builder: (_) => const HomeShellView()), (route) => false);
                              }
                            }
                          : null,
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Text.rich(
                        TextSpan(
                          style: AppTextStyles.bodySm,
                          children: const [
                            TextSpan(text: "Vous n'avez rien reçu ? "),
                            TextSpan(text: 'Renvoyer le code', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
