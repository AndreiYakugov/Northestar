import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:northstar_app/screens/my_team/widgets/contact_detail_dialog.dart';
import 'package:northstar_app/utils/app_colors.dart';
import 'package:northstar_app/utils/gaps.dart';

class TreeViewScreen extends StatelessWidget {
  final Graph graph = Graph()..isTree = true; // Enable tree layout
  final BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();
  final scaleValue;

  final List<Map<String, String>> data = [
    {
      'name': 'Steven Chan',
      'id': '#433344',
      'user': "schan",
      'status1': 'Active',
      'status2': 'Affiliate',
      'status3': 'Affilitate',
    },
    {
      'name': 'Test 1',
      'id': '#433344',
      'user': "schan",
      'status1': 'Active',
      'status2': 'Affiliate',
      'status3': 'Affilitate',
    },
    {
      'name': 'Test 2',
      'id': '#433344',
      'user': "schan",
      'status1': 'Active',
      'status2': 'Affiliate',
      'status3': 'Affilitate',
    },
    {
      'name': 'Test',
      'id': '#433344',
      'user': "schan",
      'status1': 'Active',
      'status2': 'Affiliate',
      'status3': 'Affilitate',
    },
    {
      'name': 'Test33',
      'id': '#433344',
      'user': "schan",
      'status1': 'Active',
      'status2': 'Affiliate',
      'status3': 'Affilitate',
    },
    {
      'name': 'Test33',
      'id': '#433344',
      'user': "schan",
      'status1': 'Active',
      'status2': 'Affiliate',
      'status3': 'Affilitate',
    },
  ];

  TreeViewScreen({super.key, required this.scaleValue}) {
    // Create the nodes
    final parent = Node.Id(0);
    final child1 = Node.Id(1);
    final child2 = Node.Id(2);
    final child3 = Node.Id(3);
    final child4 = Node.Id(4);
    final child5 = Node.Id(5);

    // Add edges between parent and children
    graph.addEdge(parent, child1);
    graph.addEdge(parent, child2);
    graph.addEdge(parent, child3);
    graph.addEdge(parent, child4);
    graph.addEdge(parent, child5);

    // Configure tree layout
    builder
      ..siblingSeparation = (30) // Horizontal spacing between siblings
      ..levelSeparation = (80) // Vertical spacing between levels
      ..subtreeSeparation = (100) // Spacing between subtrees
      ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM;
  }

  @override
  Widget build(BuildContext context) {
    final scaleMatrix = Matrix4.identity()..scale(scaleValue);
    final viewTransformationController = TransformationController(scaleMatrix);
    return InteractiveViewer(
      // alignment: Alignment.center,
      transformationController: viewTransformationController,
      constrained: false,
      boundaryMargin: const EdgeInsets.all(500),
      minScale: 0.8,
      maxScale: 1.5,
      child: GraphView(
        graph: graph,
        paint: Paint()
          ..color = Colors.white
          ..strokeWidth = 2,
        algorithm: BuchheimWalkerAlgorithm(builder, TreeEdgeRenderer(builder)),
        builder: (Node node) {
          // Return a widget for each node in the tree
          var index = node.key!.value as int;
          return profileCard(index, context); // Build the profile card widget
        },
      ),
    );
  }

  // A simple widget for displaying a profile card
  Widget profileCard(int index, BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(context: context, builder: (c) => ContactDetailDialog());
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        width: 176,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Container(
              height: 6,
              color: index == 0 ? AppColors.primaryColor : Colors.grey,
            ),
            16.ph,
            CircleAvatar(
              backgroundColor: Colors.grey.shade200,
              radius: 30,
            ),
            const SizedBox(height: 8.0),
            Text(
              data[index]['name']!,
              style: const TextStyle(fontSize: 12),
            ),
            Text(
              data[index]['id']!,
              style: const TextStyle(
                fontSize: 12,
                decoration: TextDecoration.underline,
              ),
            ),
            Text(
              data[index]['user']!,
              style: const TextStyle(fontSize: 12),
            ),
            const Text(
              "Status: Active",
              style: TextStyle(fontSize: 12),
            ),
            const Text(
              "Paid Rank: Affiliate",
              style: TextStyle(fontSize: 12),
            ),
            const Text(
              "Current Rank: Affiliate",
              style: TextStyle(fontSize: 12),
            ),
            16.ph,
          ],
        ),
      ),
    );
  }
}
