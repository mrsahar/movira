import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movira/screens/static/role_selection_screen.dart';
import 'package:movira/utils/constants/colors.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<IntroPage> _pages = [
    IntroPage(
      title: 'Your Ride, Anytime',
      description: 'Safe, reliable rides available 24/7.',
      image: 'assets/images/intro1.png',
    ),
    IntroPage(
      title: 'Fair to Drivers, Fair to Riders',
      description: 'Drivers keep 100% of fares (minus a tiny Platform fee). No commissions. Transparent pricing for riders.',
      image: 'assets/images/intro2.png',
    ),
    IntroPage(
      title: 'Beyond Rides',
      description: 'Quick, secure deliveries and trusted rides for family & friends.',
      image: 'assets/images/intro3.png',
    ),
    IntroPage(
      title: 'RIDES. REDEFINED.',
      description: 'Join the platform that puts drivers first and redefines rideshare.',
      image: 'assets/images/logo_splash.png',
      isLastPage: true,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Page View
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return _buildPage(_pages[index]);
                },
              ),
            ),

            // Dots Indicator
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                      (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == index ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? AppColors.black
                          : AppColors.greyLight,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),

            // Buttons
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
              child: Column(
                children: [
                  // Skip/Register Button (Yellow)
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_currentPage == _pages.length - 1) {
                          // Navigate to register
                          // Get.offAllNamed(Routes.register);
                        } else {
                          // Skip to last page or login
                          // Get.offAllNamed(Routes.login);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:AppColors.primary , // Yellow
                        foregroundColor: AppColors.black,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: Text(
                        _currentPage == _pages.length - 1 ? 'Register' : 'Skip',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Next/Login Button (Black)
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_currentPage == _pages.length - 1) {
                          Get.to(RoleSelectionScreen());
                        } else {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.black,
                        foregroundColor: AppColors.primary, // Yellow text
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: Text(
                        _currentPage == _pages.length - 1 ? 'Login' : 'Next',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
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

  Widget _buildPage(IntroPage page) {
    final isLastPage = page.isLastPage;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isLastPage ? 40 : 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            // Image Container

            // Regular intro images - full width
            // Image Container with white fade effect
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.white,
                    Colors.transparent,
                    Colors.transparent,
                    AppColors.white,
                  ],
                  stops: const [0.0, 0.1, 0.9, 1.0],
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstOut,
              child: Image.asset(
                page.image,
                width: double.infinity,
                height: 380,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(height: isLastPage ? 60 : 30),

            // Text content with horizontal padding
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  // Title
                  Text(
                    page.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isLastPage ? 24 : 26,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                      height: 1.2,
                      letterSpacing: isLastPage ? 1.2 : 0,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Description
                  Text(
                    page.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class IntroPage {
  final String title;
  final String description;
  final String image;
  final bool isLastPage;

  IntroPage({
    required this.title,
    required this.description,
    required this.image,
    this.isLastPage = false,
  });
}