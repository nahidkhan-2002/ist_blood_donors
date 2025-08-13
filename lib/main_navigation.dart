import 'profilepage.dart';
import 'mainlistpage.dart';
import 'settings_page.dart';
import 'theme_provider.dart';
import 'language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  late PageController _pageController;
  bool _showSwipeHint = true;

  final List<Widget> _pages = [
    const Mainlistpage(),
    const Profilepage(),
    const SettingsPage(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
    _hideSwipeHint();
  }

  void _hideSwipeHint() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showSwipeHint = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
      _showSwipeHint = false; // Hide hint when user navigates
    });
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      _showSwipeHint = false; // Hide hint when user taps tab
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, LanguageProvider>(
      builder: (context, themeProvider, languageProvider, child) {
        return Scaffold(
          body: Stack(
            children: [
              PageView(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                physics: const BouncingScrollPhysics(),
                children: _pages,
              ),
              // Swipe hint text
              if (_showSwipeHint)
                Positioned(
                  top: MediaQuery.of(context).padding.top + 50,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: AnimatedOpacity(
                      opacity: _showSwipeHint ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 500),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color:
                              themeProvider.isDarkMode
                                  ? Colors.grey[800]?.withOpacity(0.9) ??
                                      Colors.grey[700]!.withOpacity(0.9)
                                  : Colors.grey[200]?.withOpacity(0.9) ??
                                      Colors.grey[300]!.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.swipe_left,
                              size: 16,
                              color:
                                  themeProvider.isDarkMode
                                      ? Colors.grey[300]
                                      : Colors.grey[600],
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Swipe to navigate',
                              style: TextStyle(
                                fontSize: 12,
                                color:
                                    themeProvider.isDarkMode
                                        ? Colors.grey[300]
                                        : Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: _onTabTapped,
            type: BottomNavigationBarType.fixed,
            backgroundColor:
                themeProvider.isDarkMode ? Colors.grey[900] : Colors.white,
            selectedItemColor: const Color.fromARGB(255, 206, 55, 55),
            unselectedItemColor:
                themeProvider.isDarkMode ? Colors.grey[400] : Colors.grey,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            elevation: 8,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.list_alt),
                label: languageProvider.donorList,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.person),
                label: languageProvider.profile,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.settings),
                label: languageProvider.settings,
              ),
            ],
          ),
        );
      },
    );
  }
}
