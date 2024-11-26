import 'package:flutter/material.dart';

class UnilevelTreeScreen extends StatelessWidget {
  const UnilevelTreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Tree View'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Search Bar and Buttons
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Search Username...',
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        // Perform search
                      },
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Up one level logic
                      },
                      child: Text('UP 1 LEVEL'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Top level logic
                      },
                      child: Text('TOP'),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // Tree Structure
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Top User
                        ProfileCard(
                          username: 'Steven Chan',
                          userId: '#919562',
                          status: 'Active',
                          paidRank: 'Affiliate',
                          currentRank: 'Affiliate',
                        ),
                        SizedBox(height: 20),

                        // Sub-Users in Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ProfileCard(
                              username: 'test test',
                              userId: '#9501442',
                              status: 'Inactive',
                              paidRank: 'Affiliate',
                              currentRank: 'Affiliate',
                            ),
                            ProfileCard(
                              username: 'test123test test123test',
                              userId: '#7502184',
                              status: 'Inactive',
                              paidRank: 'Affiliate',
                              currentRank: 'Affiliate',
                            ),
                            ProfileCard(
                              username: 'test test',
                              userId: '#7502947',
                              status: 'Inactive',
                              paidRank: 'Affiliate',
                              currentRank: 'Affiliate',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Zoom Buttons
          Positioned(
            bottom: 20,
            left: 20,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.zoom_out),
                  onPressed: () {
                    // Zoom out functionality
                  },
                ),
                IconButton(
                  icon: Icon(Icons.zoom_in),
                  onPressed: () {
                    // Zoom in functionality
                  },
                ),
              ],
            ),
          ),
          // Legend
          Positioned(
            bottom: 20,
            right: 20,
            child: Column(
              children: [
                LegendItem(color: Colors.red, label: 'Affiliate'),
                LegendItem(color: Colors.green, label: 'Preferred'),
                LegendItem(color: Colors.grey, label: 'Retail'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String username;
  final String userId;
  final String status;
  final String paidRank;
  final String currentRank;

  const ProfileCard({super.key, 
    required this.username,
    required this.userId,
    required this.status,
    required this.paidRank,
    required this.currentRank,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        width: 150,
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey[200],
              child: Icon(Icons.person, size: 40),
            ),
            SizedBox(height: 10),
            Text(
              username,
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(userId),
            SizedBox(height: 5),
            Text('Status: $status'),
            Text('Paid Rank: $paidRank'),
            Text('Current Rank: $currentRank'),
          ],
        ),
      ),
    );
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const LegendItem({super.key, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          color: color,
        ),
        SizedBox(width: 10),
        Text(label),
      ],
    );
  }
}
