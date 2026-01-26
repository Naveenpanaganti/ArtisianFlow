import 'package:flutter/material.dart';

class ResponsiveHome extends StatelessWidget {
  const ResponsiveHome({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions using MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text("ArtisanFlow Dashboard"),
        backgroundColor: Colors.brown[400],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (isTablet) {
            // Tablet/Landscape Layout: Two Columns
            return Row(
              children: [
                Expanded(flex: 2, child: _buildInventoryGrid(3)), // Grid with 3 columns
                Expanded(flex: 1, child: _buildRecentOrders()),  // Side panel for orders
              ],
            );
          } else {
            // Phone Layout: Single Column
            return Column(
              children: [
                Expanded(child: _buildInventoryGrid(2)), // Grid with 2 columns
                Container(
                  height: 150,
                  color: Colors.brown[50],
                  child: _buildRecentOrders(),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  // A reusable widget for our inventory display
  Widget _buildInventoryGrid(int crossAxisCount) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: 6,
      itemBuilder: (context, index) => Card(
        color: Colors.orange[100],
        child: Center(child: Text("Product ${index + 1}")),
      ),
    );
  }

  // A reusable widget for recent activity
  Widget _buildRecentOrders() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) => ListTile(
        leading: const Icon(Icons.shopping_bag),
        title: Text("Order #100${index + 1}"),
        subtitle: const Text("Status: Pending"),
      ),
    );
  }
}