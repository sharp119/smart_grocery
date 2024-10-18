import 'package:flutter/material.dart';
import '../components/custom_app_bar.dart';
import '../models/models.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Settings'),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'User Info'),
              Tab(text: 'Purchase History'),
              Tab(text: 'Meal Planner'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildUserInfoTab(),
                _buildPurchaseHistoryTab(),
                _buildMealPlannerTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfoTab() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildUserAvatar(),
        const SizedBox(height: 16),
        _buildTextField('Name', 'John Doe'),
        _buildTextField('Email', 'johndoe@example.com'),
        _buildTextField('Phone', '+1 234 567 8900'),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Changes saved')),
            );
          },
          child: const Text('Save Changes'),
        ),
      ],
    );
  }

  Widget _buildUserAvatar() {
    return Center(
      child: Stack(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/default_avatar.png'),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              radius: 18,
              child: IconButton(
                icon: const Icon(Icons.edit, size: 18),
                color: Theme.of(context).colorScheme.onPrimary,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Avatar change not implemented yet')),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String initialValue) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildPurchaseHistoryTab() {
    final purchases = [
      {
        'date': '2023-10-15',
        'items': ['Apples', 'Milk', 'Bread']
      },
      {
        'date': '2023-10-10',
        'items': ['Chicken', 'Rice', 'Vegetables']
      },
      {
        'date': '2023-10-05',
        'items': ['Eggs', 'Cheese', 'Yogurt']
      },
    ];

    return ListView.builder(
      itemCount: purchases.length,
      itemBuilder: (context, index) {
        final purchase = purchases[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ListTile(
            title: Text('Purchase on ${purchase['date']}'),
            subtitle: Text((purchase['items'] as List<String>).join(', ')),
            trailing: IconButton(
              icon: const Icon(Icons.info_outline),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Purchase details not implemented yet')),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildMealPlannerTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.restaurant_menu,
            size: 100,
            color: Theme.of(context).colorScheme.secondary,
          ),
          const SizedBox(height: 16),
          Text(
            'Meal Planner Coming Soon!',
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Text(
            'We\'re working on a smart meal planner to help you use your ingredients efficiently and reduce food waste.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Notification sign-up not implemented yet')),
              );
            },
            child: const Text('Notify Me When It\'s Ready'),
          ),
        ],
      ),
    );
  }
}
