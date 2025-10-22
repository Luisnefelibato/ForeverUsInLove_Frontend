import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/// Intro screens with page indicator
/// Shows 3 introduction screens with key messages
class IntroPagesScreen extends StatefulWidget {
  const IntroPagesScreen({super.key});

  @override
  State<IntroPagesScreen> createState() => _IntroPagesScreenState();
}

class _IntroPagesScreenState extends State<IntroPagesScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<IntroPageData> _pages = [
    IntroPageData(
      title: 'Where meaningful\nconnections begin again',
      description:
          'Find authentic relationships based on shared values and genuine connections',
      icon: Icons.favorite_rounded,
      gradient: [
        const Color(0xFFE91E63),
        const Color(0xFFF48FB1),
      ],
    ),
    IntroPageData(
      title: 'Verified &\nSafe Dating',
      description:
          'Your safety is our priority. All profiles are verified through Face ID and document validation',
      icon: Icons.verified_user_rounded,
      gradient: [
        const Color(0xFF9C27B0),
        const Color(0xFFCE93D8),
      ],
    ),
    IntroPageData(
      title: 'Celebrate love\nat any age',
      description:
          'Age is just a number. Find meaningful relationships regardless of your age',
      icon: Icons.celebration_rounded,
      gradient: [
        const Color(0xFFE91E63),
        const Color(0xFF9C27B0),
      ],
    ),
  ];

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate to permissions screen
      Navigator.of(context).pushReplacementNamed('/permissions');
    }
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: _skip,
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            // PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return IntroPageWidget(data: _pages[index]);
                },
              ),
            ),
            // Page indicator and buttons
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  // Page indicator
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: _pages.length,
                    effect: ExpandingDotsEffect(
                      activeDotColor: Theme.of(context).primaryColor,
                      dotColor: Colors.grey[300]!,
                      dotHeight: 8,
                      dotWidth: 8,
                      expansionFactor: 4,
                      spacing: 8,
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Next/Get Started button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        _currentPage == _pages.length - 1
                            ? 'Get Started'
                            : 'Next',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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

/// Data model for intro page
class IntroPageData {
  final String title;
  final String description;
  final IconData icon;
  final List<Color> gradient;

  IntroPageData({
    required this.title,
    required this.description,
    required this.icon,
    required this.gradient,
  });
}

/// Individual intro page widget
class IntroPageWidget extends StatelessWidget {
  final IntroPageData data;

  const IntroPageWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon with gradient background
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: data.gradient,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: data.gradient[0].withOpacity(0.3),
                  blurRadius: 30,
                  spreadRadius: 5,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Icon(
              data.icon,
              size: 100,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 48),
          // Title
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[900],
                  height: 1.3,
                ),
          ),
          const SizedBox(height: 24),
          // Description
          Text(
            data.description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                  height: 1.5,
                ),
          ),
        ],
      ),
    );
  }
}
