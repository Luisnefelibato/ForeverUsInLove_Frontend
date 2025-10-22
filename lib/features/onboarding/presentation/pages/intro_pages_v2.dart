import 'package:flutter/material.dart';
import '../widgets/onboarding_theme.dart';

/// Intro screens exactly matching wireframes
/// 3 screens with image placeholder, title, and dot indicator
class IntroPagesScreenV2 extends StatefulWidget {
  const IntroPagesScreenV2({super.key});

  @override
  State<IntroPagesScreenV2> createState() => _IntroPagesScreenV2State();
}

class _IntroPagesScreenV2State extends State<IntroPagesScreenV2> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<IntroPageDataV2> _pages = [
    IntroPageDataV2(
      title: 'Where meaningful\nconnections begin\nagain',
      backgroundImage: null, // Optional: Add background image path here
    ),
    IntroPageDataV2(
      title: 'Verified profiles.\nFeel safe being\nyourself.',
      backgroundImage: null, // Optional: Add background image path here
    ),
    IntroPageDataV2(
      title: 'However You Identify\nYourself, you\'re\nAlways Welcome Here',
      backgroundImage: null, // Optional: Add background image path here
    ),
  ];

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _skip() {
    // Navigate to permissions screen
    Navigator.of(context).pushReplacementNamed('/permissions');
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OnboardingTheme.backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            // PageView
            PageView.builder(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: _pages.length,
              itemBuilder: (context, index) {
                return IntroPageWidgetV2(data: _pages[index]);
              },
            ),
            // Skip button - Top right
            Positioned(
              top: 16,
              right: 16,
              child: TextButton(
                onPressed: _skip,
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
                child: Text(
                  'skip',
                  style: TextStyle(
                    color: OnboardingTheme.skipButtonColor,
                    fontSize: OnboardingTheme.skipFontSize,
                    fontFamily: OnboardingTheme.fontFamily,
                  ),
                ),
              ),
            ),
            // Dot indicator - Center bottom
            Positioned(
              bottom: OnboardingTheme.bottomPadding,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (index) => _buildDot(index),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDot(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index
            ? OnboardingTheme.activeDotColor
            : OnboardingTheme.inactiveDotColor,
      ),
    );
  }
}

/// Data model for intro page v2
class IntroPageDataV2 {
  final String title;
  final String? backgroundImage;

  IntroPageDataV2({
    required this.title,
    this.backgroundImage,
  });
}

/// Individual intro page widget matching wireframe exactly
class IntroPageWidgetV2 extends StatelessWidget {
  final IntroPageDataV2 data;

  const IntroPageWidgetV2({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: OnboardingTheme.backgroundColor,
        // Optional: Add background image
        image: data.backgroundImage != null
            ? DecorationImage(
                image: AssetImage(data.backgroundImage!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: OnboardingTheme.horizontalPadding,
        ),
        child: Column(
          children: [
            const Spacer(flex: 1),
            // Image placeholder icon (centered)
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: OnboardingTheme.iconPlaceholderColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: OnboardingTheme.iconBorderColor,
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.image_outlined,
                size: 40,
                color: OnboardingTheme.iconBorderColor.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 48),
            // Title text (centered)
            Text(
              data.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: OnboardingTheme.titleFontSize,
                fontWeight: OnboardingTheme.titleFontWeight,
                color: OnboardingTheme.titleColor,
                fontFamily: OnboardingTheme.fontFamily,
                height: 1.2,
              ),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
