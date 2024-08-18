import 'package:flutter/material.dart';
import 'package:ignition_hacks/screens/ai_modal.dart';
import 'package:ignition_hacks/screens/budget_modal.dart';
import 'package:ignition_hacks/screens/expense_tracker.dart';
import 'package:ignition_hacks/screens/modal_display.dart';
import 'package:ignition_hacks/screens/story_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late Widget currentScreen;
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    currentScreen = buildHomeScreen();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _rotationAnimation =
        Tween<double>(begin: 0.0, end: 0.125).animate(_controller);

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  void _navSelector() {
    setState(() {
      if (_selectedIndex == 0) {
        currentScreen = buildHomeScreen();
      } else if (_selectedIndex == 1) {
        currentScreen = ExpenseTracker();
      } else {
        currentScreen = buildHomeScreen();
      }
    });
  }

  Widget buildCard(
      String title, String subtitle, Widget newScreen, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => newScreen),
          );
        },
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  imageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHomeScreen() {
    return SingleChildScrollView(
      child: Column(children: [
        SizedBox(height: 80),
        buildCard(
            'Budgeting Basics',
            'Create Your Own Budget and Sticking to it',
            StoryPage(),
            'https://cdn.discordapp.com/attachments/1273633503002497144/1274574264607051808/Budgeting_1920x1080.png?ex=66c2bf49&is=66c16dc9&hm=ec7cce91cc77d60cbbbf35e829241a9967b1f74e0a19702834bf726e82e1e219&'),
        buildCard(
            'Understand Taxes',
            'Maximizing Your Refund and Minimizing Your Bill',
            Scaffold(),
            'https://cdn.discordapp.com/attachments/1273633503002497144/1274568150142423050/Shutterstock_1789167659-1080x675.png?ex=66c2b997&is=66c16817&hm=225eb93b78035982f44b82634f98d8ac8367bbc29f021a13db9f9b2ae0bd77b6&'),
        buildCard(
            'Retirement Planning,',
            'Starting Early for Long-Term Success',
            Scaffold(),
            'https://cdn.discordapp.com/attachments/1273633503002497144/1274568374348812318/insured-retirement-plan-saskatoon.png?ex=66c2b9cc&is=66c1684c&hm=91d4138e3de513ac7c46c24e7cd079f7ccb7543bd4f9f09dfb0507e1384d3eec&'),
        buildCard(
            'Side Hustles',
            'Turning Your Skills into Extra Income',
            Scaffold(),
            'https://cdn.discordapp.com/attachments/1273633503002497144/1274568540606828626/side-hustle-ideas_f4192072-e83c-4d44-9cf8-269254c844bc.png?ex=66c2b9f4&is=66c16874&hm=b0e78e7ab533f643d27d5b2e9e572ed28e4a89da12bd13423b7dbef7e3169ef5&'),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          currentScreen,
          if (_isExpanded) ...[
            FadeTransition(
              opacity: _fadeAnimation,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _controller.reverse();
                    _isExpanded = false;
                  });
                },
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
          ],
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(
          height: 56,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                iconSize: 24,
                icon: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.article_outlined),
                    SizedBox(height: 2),
                    Text('Tutorials', style: TextStyle(fontSize: 10)),
                  ],
                ),
                onPressed: () {
                  _selectedIndex = 0;
                  _navSelector();
                },
              ),
              SizedBox(width: 48),
              IconButton(
                iconSize: 24,
                icon: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.attach_money),
                    SizedBox(height: 2),
                    Text('Expense Tracker', style: TextStyle(fontSize: 10)),
                  ],
                ),
                onPressed: () {
                  _selectedIndex = 1;
                  _navSelector();
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: FloatingActionButton.extended(
                    heroTag: 'aiEvaluate', // Unique hero tag
                    label: Text("AI Evaluate"),
                    icon: Icon(Icons.assessment),
                    backgroundColor: Colors.orange,
                    onPressed: () {
                      showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16.0),
                          ),
                        ),
                        useSafeArea: true,
                        isScrollControlled: true,
                        context: context,
                        builder: (ctx) {
                          return ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(16.0),
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.7,
                              color: Colors.white,
                              child:
                                  AiEvaluateModal(), // Use the empty modal here
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: 10),
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: FloatingActionButton.extended(
                    heroTag: 'makeBudget', // Unique hero tag
                    label: Text("Make Budget"),
                    icon: Icon(Icons.pie_chart),
                    backgroundColor: Colors.green,
                    onPressed: () {
                      showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16.0),
                          ),
                        ),
                        useSafeArea: true,
                        isScrollControlled: true,
                        context: context,
                        builder: (ctx) {
                          return ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(16.0),
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.7,
                              color: Colors.white,
                              child: NewBudget(),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: 10),
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: FloatingActionButton.extended(
                    heroTag: 'addExpenseIncome', // Unique hero tag
                    label: Text("Add Expense/Income"),
                    icon: Icon(Icons.add),
                    backgroundColor: Colors.blue,
                    onPressed: () {
                      showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16.0),
                          ),
                        ),
                        useSafeArea: true,
                        isScrollControlled: true,
                        context: context,
                        builder: (ctx) {
                          return ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(16.0),
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.7,
                              color: Colors.white,
                              child: NewExpense(),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: 80),
              ],
            ),
            FloatingActionButton(
              heroTag: 'mainActionButton', // Unique hero tag
              shape: CircleBorder(),
              onPressed: () {
                setState(() {
                  if (_isExpanded) {
                    _controller.reverse();
                  } else {
                    _controller.forward();
                  }
                  _isExpanded = !_isExpanded;
                });
              },
              child: RotationTransition(
                turns: _rotationAnimation,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
              backgroundColor: Color.fromRGBO(251, 78, 78, 1),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
