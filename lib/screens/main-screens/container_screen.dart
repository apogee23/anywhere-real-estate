import 'package:realogy/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realogy/colors/custom_colors.dart';
import 'package:realogy/screens/screens.dart';
import 'package:theme_provider/theme_provider.dart';

class ContainerScreen extends ConsumerStatefulWidget {
  const ContainerScreen({
    super.key,
    required this.selectedScreen,
  });

  final int? selectedScreen;

  @override
  ConsumerState<ContainerScreen> createState() => _ContainerScreenState();
}

class _ContainerScreenState extends ConsumerState<ContainerScreen> {
  // late UserModel _user;
  // late List<GoalModel> _goals;
  late int _selectedScreen;
  String? _selectedConnectedItemId;
  String? _selectedAccountId;

  @override
  void initState() {
    // _user = widget.user;
    // _goals = widget.goals;
    _selectedScreen = widget.selectedScreen ?? 0;

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget getCurrentScreen() {
    var screens = [
      const DashboardScreen(),
      const GoalsScreen(),
    ];

    return screens[_selectedScreen];
  }

  @override
  Widget build(BuildContext context) {
    var dataState = ref.watch(dataProvider);

    var isAnAccountsScreen = _selectedScreen >= 6;

    return Container(
      color: ThemeProvider.themeOf(context).data.backgroundColor,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.lightBlue,
          actions: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 0.5,
                ),
              ),
              child: IconButton(
                icon: const Icon(Icons.notification_add),
                onPressed: () {},
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 0.5,
                ),
              ),
              child: IconButton(
                icon: const Icon(Icons.notes),
                onPressed: () {},
              ),
            ),
          ],
        ),
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.lightBlue,
                ),
                child: Text('Alena Smith'),
              ),
              ListTile(
                title: const Text('Home'),
                // selected: _selectedIndex == 0,
                onTap: () {
                  // Update the state of the app
                  // _onItemTapped(0);
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Page 1'),
                // selected: _selectedIndex == 1,
                onTap: () {
                  // Update the state of the app
                  // _onItemTapped(1);
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Page 2'),
                // selected: _selectedIndex == 2,
                onTap: () {
                  // Update the state of the app
                  // _onItemTapped(2);
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        persistentFooterButtons: [
          GestureDetector(
            onTap: () => showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.cancel_outlined),
                            onPressed: () => Navigator.pop(context),
                          )
                        ],
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "How intense is your urge?",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Container(
                        height: 75,
                        color: Colors.yellow,
                        child: const Center(
                          child: Text(
                            "Low",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 75,
                        color: Colors.orange,
                        child: const Center(
                          child: Text(
                            "Medium",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 75,
                        color: Colors.red,
                        child: const Center(
                          child: Text(
                            "High",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
            child: Container(
              width: double.infinity,
              height: 50,
              color: Colors.red,
              child: const Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Manage Urge',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Icon(
                      Icons.add_circle_outline,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
        backgroundColor: ThemeProvider.themeOf(context).data.backgroundColor,
        body:
            // User is logged in, and has linked accounts.
            LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) =>

              // Add width condition of Web
              constraints.maxWidth > 600
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 600,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: isAnAccountsScreen ? 0 : 16,
                              left: isAnAccountsScreen ? 0 : 16,
                              right: isAnAccountsScreen ? 0 : 16,
                            ),
                            child: getCurrentScreen(),
                          ),
                        ),
                      ],
                    )
                  : getCurrentScreen(),
        ),
        bottomNavigationBar: BottomAppBar(
          child: BottomNavigationBar(
            elevation: 0,
            currentIndex: _selectedScreen <= 5 ? _selectedScreen : 5,
            backgroundColor:
                ThemeProvider.themeOf(context).data.backgroundColor,
            unselectedItemColor: const Color(0xFF7C7C7C),
            selectedItemColor: CustomColors.primary,
            type: BottomNavigationBarType.fixed,
            onTap: (index) => setState(
              () => _selectedScreen = index,
            ),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.explore_outlined),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.route_outlined),
                label: 'Recovery',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_2_outlined),
                label: 'Urges',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month_outlined),
                label: 'Meetings',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.check_box_outlined),
                label: 'Check-in',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
