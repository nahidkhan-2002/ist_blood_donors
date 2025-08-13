import 'theme_provider.dart';
import 'developerdetails.dart';
import 'language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, LanguageProvider>(
      builder: (context, themeProvider, languageProvider, child) {
        final isDarkMode = themeProvider.isDarkMode;
        
        return Scaffold(
          appBar: AppBar(
            title: Text(languageProvider.settings),
            centerTitle: true,
            backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
            iconTheme: IconThemeData(
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          body: Container(
            color: isDarkMode ? Colors.grey[800] : Colors.grey[50],
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Theme Section
                _buildSectionCard(
                  title: languageProvider.appearance,
                  icon: Icons.palette,
                  isDarkMode: isDarkMode,
                  children: [
                    SwitchListTile(
                      title: Text(
                        languageProvider.darkMode,
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        languageProvider.switchTheme,
                        style: TextStyle(
                          color: isDarkMode ? Colors.grey[300] : Colors.grey[600],
                        ),
                      ),
                      value: isDarkMode,
                      onChanged: (value) {
                        themeProvider.toggleTheme();
                      },
                      activeColor: const Color.fromARGB(255, 206, 55, 55),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Language Section
                _buildSectionCard(
                  title: languageProvider.language,
                  icon: Icons.language,
                  isDarkMode: isDarkMode,
                  children: [
                    ListTile(
                      title: Text(
                        languageProvider.english,
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      leading: Radio<String>(
                        value: 'English',
                        groupValue: languageProvider.currentLanguage,
                        onChanged: (value) {
                          languageProvider.setLanguage(value!);
                        },
                        activeColor: const Color.fromARGB(255, 206, 55, 55),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        languageProvider.bangla,
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      leading: Radio<String>(
                        value: 'বাংলা',
                        groupValue: languageProvider.currentLanguage,
                        onChanged: (value) {
                          languageProvider.setLanguage(value!);
                        },
                        activeColor: const Color.fromARGB(255, 206, 55, 55),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Developer Section
                _buildSectionCard(
                  title: languageProvider.developer,
                  icon: Icons.developer_mode,
                  isDarkMode: isDarkMode,
                  children: [
                    ListTile(
                      title: Text(
                        languageProvider.developerDetails,
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        languageProvider.viewDeveloperInfo,
                        style: TextStyle(
                          color: isDarkMode ? Colors.grey[300] : Colors.grey[600],
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: isDarkMode ? Colors.grey[300] : Colors.grey[600],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Developerdetails(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // About Us Section
                _buildSectionCard(
                  title: languageProvider.aboutUs,
                  icon: Icons.info,
                  isDarkMode: isDarkMode,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            languageProvider.appName,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            languageProvider.appDescription,
                            style: TextStyle(
                              fontSize: 14,
                              color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            languageProvider.version,
                            style: TextStyle(
                              fontSize: 12,
                              color: isDarkMode ? Colors.grey[400] : Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required bool isDarkMode,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 2,
      color: isDarkMode ? Colors.grey[850] : Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: const Color.fromARGB(255, 206, 55, 55),
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}
