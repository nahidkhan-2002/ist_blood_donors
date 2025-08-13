import 'utils.dart';
import 'style.dart';
import 'apipage.dart';
import 'theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blurrycontainer/blurrycontainer.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _refreshUserData();
  }

  Future<void> _refreshUserData() async {
    setState(() {
      _isLoading = true;
    });

    if (currentUserPhone.isNotEmpty) {
      final userData = await fetchUserByPhone(currentUserPhone);
      if (userData != null) {
        setState(() {
          currentUserName = userData['name'] ?? '';
          currentUserBloodGroup = userData['bloodGroup'] ?? '';
          currentUserDepartment = userData['department'] ?? '';
          currentUserSession = userData['session'] ?? '';
        });
        showtoast('Profile data refreshed successfully!');
      } else {
        showtoast('Failed to load profile data');
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final isDarkMode = themeProvider.isDarkMode;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
            centerTitle: true,
            backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
            foregroundColor: isDarkMode ? Colors.white : Colors.black,
            actions: [
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: _refreshUserData,
                tooltip: 'Refresh Profile Data',
              ),
            ],
          ),
          body:
              _isLoading
                  ? Center(
                    child: CircularProgressIndicator(
                      color: const Color.fromARGB(255, 206, 55, 55),
                    ),
                  )
                  : currentUserPhone.isEmpty
                  ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_off,
                          size: 64,
                          color:
                              isDarkMode ? Colors.grey[400] : Colors.grey[600],
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No User Data Available',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Please log in to view your profile',
                          style: TextStyle(
                            fontSize: 14,
                            color:
                                isDarkMode
                                    ? Colors.grey[300]
                                    : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                  : BlurryContainer(
                    blur: 10,
                    color: const Color.fromARGB(90, 255, 255, 255),
                    width: double.infinity,
                    borderRadius: BorderRadius.circular(10),
                    elevation: 10,
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          // Profile Header
                          BlurryContainer(
                            blur: 4,
                            width: double.infinity,
                            elevation: 4,
                            color: const Color.fromARGB(149, 255, 255, 255),
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundColor: const Color.fromARGB(
                                      255,
                                      206,
                                      55,
                                      55,
                                    ),
                                    child: Icon(
                                      Icons.person,
                                      size: 50,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    currentUserName.isNotEmpty
                                        ? currentUserName
                                        : 'User Name',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          isDarkMode
                                              ? Colors.white
                                              : Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    currentUserPhone.isNotEmpty
                                        ? currentUserPhone
                                        : 'Phone Number',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color:
                                          isDarkMode
                                              ? Colors.grey[300]
                                              : Colors.grey[600],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                        255,
                                        206,
                                        55,
                                        55,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      currentUserBloodGroup.isNotEmpty
                                          ? currentUserBloodGroup
                                          : 'Blood Group',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Profile Information
                          Card(
                            elevation: 2,
                            color: isDarkMode ? Colors.grey[850] : Colors.white,
                            child: Column(
                              children: [
                                _buildInfoTile(
                                  icon: Icons.school,
                                  title: 'Department',
                                  value:
                                      currentUserDepartment.isNotEmpty
                                          ? currentUserDepartment
                                          : 'Not specified',
                                  isDarkMode: isDarkMode,
                                ),
                                _buildInfoTile(
                                  icon: Icons.calendar_today,
                                  title: 'Session',
                                  value:
                                      currentUserSession.isNotEmpty
                                          ? currentUserSession
                                          : 'Not specified',
                                  isDarkMode: isDarkMode,
                                ),
                                _buildInfoTile(
                                  icon: Icons.phone,
                                  title: 'Contact',
                                  value:
                                      currentUserPhone.isNotEmpty
                                          ? currentUserPhone
                                          : 'Not specified',
                                  isDarkMode: isDarkMode,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Quick Actions
                          Card(
                            elevation: 2,
                            color: isDarkMode ? Colors.grey[850] : Colors.white,
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Icon(
                                    Icons.edit,
                                    color: const Color.fromARGB(
                                      255,
                                      206,
                                      55,
                                      55,
                                    ),
                                  ),
                                  title: const Text('Edit Profile'),
                                  subtitle: const Text(
                                    'Update your information',
                                  ),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                  onTap: () {
                                    // TODO: Navigate to edit profile page
                                    showtoast(
                                      'Edit profile functionality coming soon!',
                                    );
                                  },
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.share,
                                    color: const Color.fromARGB(
                                      255,
                                      206,
                                      55,
                                      55,
                                    ),
                                  ),
                                  title: const Text('Share App'),
                                  subtitle: const Text(
                                    'Share with friends and family',
                                  ),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                  onTap: () {
                                    // TODO: Implement share functionality
                                    showtoast(
                                      'Share functionality coming soon!',
                                    );
                                  },
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.help_outline,
                                    color: const Color.fromARGB(
                                      255,
                                      206,
                                      55,
                                      55,
                                    ),
                                  ),
                                  title: const Text('Help & Support'),
                                  subtitle: const Text(
                                    'Get help and contact support',
                                  ),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                  onTap: () {
                                    // TODO: Navigate to help page
                                    showtoast('Help & Support coming soon!');
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
        );
      },
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String value,
    required bool isDarkMode,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color.fromARGB(255, 206, 55, 55)),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      subtitle: Text(
        value,
        style: TextStyle(
          color: isDarkMode ? Colors.grey[300] : Colors.grey[600],
        ),
      ),
    );
  }
}
