import 'utils.dart';
import 'style.dart';
import 'apipage.dart';
import 'registerpage.dart';
import 'donor_details_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Mainlistpage extends StatefulWidget {
  const Mainlistpage({super.key});

  @override
  State<Mainlistpage> createState() => _MainlistpageState();
}

bool Loading = false;

class _MainlistpageState extends State<Mainlistpage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedBloodGroup = 'All';
  List<String> _filteredNames = [];
  List<String> _filteredPhones = [];
  List<String> _filteredBloodGroups = [];
  List<String> _filteredDepartments = [];
  List<String> _filteredSessions = [];

  final List<String> _bloodGroupOptions = [
    'All',
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];

  @override
  void initState() {
    super.initState();
    loadData();
    _searchController.addListener(_filterData);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void loadData() async {
    setState(() {
      Loading = true;
    });
    await fetchAllInformation(); // 🔁 fetch firestore data
    _filterData(); // Apply initial filtering
    setState(() {
      Loading = false;
    }); // 🧠 UI update
  }

  void refreshData() async {
    await fetchAllInformation();
    _filterData();
  }

  void _filterData() {
    String searchQuery = _searchController.text.toLowerCase();

    _filteredNames = [];
    _filteredPhones = [];
    _filteredBloodGroups = [];
    _filteredDepartments = [];
    _filteredSessions = [];

    for (int i = 0; i < nameList.length; i++) {
      bool matchesSearch =
          nameList[i].toLowerCase().contains(searchQuery) ||
          phoneList[i].contains(searchQuery);

      bool matchesBloodGroup =
          _selectedBloodGroup == 'All' ||
          bloodGroupList[i] == _selectedBloodGroup;

      if (matchesSearch && matchesBloodGroup) {
        _filteredNames.add(nameList[i]);
        _filteredPhones.add(phoneList[i]);
        _filteredBloodGroups.add(bloodGroupList[i]);
        _filteredDepartments.add(departmentList[i]);
        _filteredSessions.add(sessionList[i]);
      }
    }
    setState(() {});
  }

  void _onBloodGroupChanged(String? newValue) {
    if (newValue != null) {
      setState(() {
        _selectedBloodGroup = newValue;
      });
      _filterData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("IST Blood Donors"),
        centerTitle: true,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
      ),
      drawer: Drawer(child: buildDrawerList(context)),
      body:
          Loading
              ? Center(child: CircularProgressIndicator())
              : Stack(
                children: [
                  Transform.scale(
                    scale: 2.0,
                    child: Center(
                      child: Image.asset(
                        'asset_project/ist.png',
                        opacity: AlwaysStoppedAnimation(0.4),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      // Search and Filter Section
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            // Search Bar
                            TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                hintText: 'Search by name or phone number...',
                                prefixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                filled: true,
                                fillColor: Colors.grey[100],
                              ),
                            ),
                            SizedBox(height: 16),
                            // Blood Group Filter
                            Row(
                              children: [
                                Text(
                                  'Filter by Blood Group:',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    value: _selectedBloodGroup,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                    ),
                                    items:
                                        _bloodGroupOptions.map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                    onChanged: _onBloodGroupChanged,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            // Results count
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${_filteredNames.length} donor(s) found',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // List View
                      Expanded(
                        child:
                            _filteredNames.isEmpty
                                ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.search_off,
                                        size: 64,
                                        color: Colors.grey[400],
                                      ),
                                      SizedBox(height: 16),
                                      Text(
                                        'No donors found',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      Text(
                                        'Try adjusting your search or filter',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                : ListView.builder(
                                  physics: BouncingScrollPhysics(
                                    parent: AlwaysScrollableScrollPhysics(),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  itemCount: _filteredNames.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      shadowColor: const Color.fromARGB(
                                        121,
                                        0,
                                        0,
                                        0,
                                      ),
                                      elevation: 4,
                                      margin: EdgeInsets.only(bottom: 16),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border:
                                              currentUserPhone ==
                                                      _filteredPhones[index]
                                                  ? Border.all(
                                                    color: const Color.fromARGB(
                                                      255,
                                                      206,
                                                      55,
                                                      55,
                                                    ),
                                                    width: 2,
                                                  )
                                                  : null,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          _filteredNames[index],
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          'Blood Group: ${_filteredBloodGroups[index]}',
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        SizedBox(height: 4),
                                                        Text(
                                                          'Number: ${_filteredPhones[index]}',
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  // Current user indicator
                                                  if (currentUserPhone ==
                                                      _filteredPhones[index])
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                            horizontal: 8,
                                                            vertical: 4,
                                                          ),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            const Color.fromARGB(
                                                              255,
                                                              206,
                                                              55,
                                                              55,
                                                            ),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              12,
                                                            ),
                                                      ),
                                                      child: Text(
                                                        'You',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                              SizedBox(height: 12),
                                              Row(
                                                children: [
                                                  TextButton(
                                                    onPressed: () {
                                                      // Navigate to donor details page
                                                      Navigator.push(
                                                        context,
                                                        PageTransition(
                                                          type:
                                                              PageTransitionType
                                                                  .rightToLeftWithFade,
                                                          child: DonorDetailsPage(
                                                            name:
                                                                _filteredNames[index],
                                                            phone:
                                                                _filteredPhones[index],
                                                            bloodGroup:
                                                                _filteredBloodGroups[index],
                                                            department:
                                                                _filteredDepartments[index],
                                                            session:
                                                                _filteredSessions[index],
                                                          ),
                                                          duration: Duration(
                                                            milliseconds: 400,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Text(
                                                      'See Details',
                                                      style: TextStyle(
                                                        color:
                                                            const Color.fromARGB(
                                                              255,
                                                              240,
                                                              31,
                                                              31,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                  // Update Profile button for current user
                                                  if (currentUserPhone ==
                                                      _filteredPhones[index]) ...[
                                                    SizedBox(width: 8),
                                                    ElevatedButton(
                                                      onPressed: () async {
                                                        // Fetch complete user data before updating
                                                        final userData =
                                                            await fetchUserByPhone(
                                                              _filteredPhones[index],
                                                            );
                                                        if (userData != null) {
                                                          Navigator.push(
                                                            context,
                                                            PageTransition(
                                                              type:
                                                                  PageTransitionType
                                                                      .rightToLeftWithFade,
                                                              child: Registerpage(
                                                                isUpdateMode:
                                                                    true,
                                                                existingData:
                                                                    userData,
                                                              ),
                                                              duration: Duration(
                                                                milliseconds:
                                                                    400,
                                                              ),
                                                            ),
                                                          ).then((_) {
                                                            // Refresh data when returning from update page
                                                            refreshData();
                                                          });
                                                        } else {
                                                          showtoast(
                                                            'Failed to load user data',
                                                          );
                                                        }
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                            const Color.fromARGB(
                                                              255,
                                                              206,
                                                              55,
                                                              55,
                                                            ),
                                                        foregroundColor:
                                                            Colors.white,
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                              horizontal: 16,
                                                              vertical: 8,
                                                            ),
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                8,
                                                              ),
                                                        ),
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Icon(
                                                            Icons.edit,
                                                            size: 16,
                                                          ),
                                                          SizedBox(width: 4),
                                                          Text('Update'),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                      ),
                    ],
                  ),
                ],
              ),
    );
  }
}
