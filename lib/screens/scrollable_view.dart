import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ScrollableViews extends StatelessWidget {
  const ScrollableViews({super.key});

  Future<void> _showEditDialog(BuildContext context, QueryDocumentSnapshot doc) async {
    final tCtrl = TextEditingController(text: doc['title'] ?? '');
    final dCtrl = TextEditingController(text: doc['description'] ?? '');
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: tCtrl, decoration: const InputDecoration(labelText: 'Title')),
              TextField(controller: dCtrl, decoration: const InputDecoration(labelText: 'Description')),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
            ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('Save')),
          ],
        );
      },
    );

    if (result == true) {
      await FirebaseFirestore.instance.collection('items').doc(doc.id).update({
        'title': tCtrl.text,
        'description': dCtrl.text,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    }
  }

  Future<void> _confirmDelete(BuildContext context, QueryDocumentSnapshot doc) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete'),
        content: const Text('Delete this item? This action cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete')),
        ],
      ),
    );
    if (ok == true) {
      await FirebaseFirestore.instance.collection('items').doc(doc.id).delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ArtisanFlow Catalog')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('items').orderBy('createdAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) return const Center(child: Text('No items yet'));

          final docs = snapshot.data!.docs;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Featured Items', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 140,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: docs.length < 6 ? docs.length : 6,
                    itemBuilder: (context, index) {
                      final d = docs[index];
                      return GestureDetector(
                        onTap: () => _showEditDialog(context, d),
                        onLongPress: () => _confirmDelete(context, d),
                        child: Container(
                          width: 140,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.primaries[index % Colors.primaries.length].shade200,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(d['title'] ?? 'Untitled', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 8),
                              Expanded(child: Text(d['description'] ?? '', overflow: TextOverflow.ellipsis, maxLines: 4)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Divider(height: 32),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Product Grid', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: LayoutBuilder(builder: (context, constraints) {
                    final cross = constraints.maxWidth > 800 ? 4 : (constraints.maxWidth > 600 ? 3 : 2);
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: cross,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1,
                      ),
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        final d = docs[index];
                        return GestureDetector(
                          onTap: () => _showEditDialog(context, d),
                          onLongPress: () => _confirmDelete(context, d),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(d['title'] ?? 'Untitled', style: const TextStyle(fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 8),
                                  Expanded(child: Text(d['description'] ?? '', overflow: TextOverflow.ellipsis, maxLines: 6)),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(d['createdBy'] ?? '', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                      Text(_timeAgo(d['createdAt']), style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
                const SizedBox(height: 80),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final tCtrl = TextEditingController();
          final dCtrl = TextEditingController();
          final result = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Add Item'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(controller: tCtrl, decoration: const InputDecoration(labelText: 'Title')),
                  TextField(controller: dCtrl, decoration: const InputDecoration(labelText: 'Description')),
                ],
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('Add')),
              ],
            ),
          );
          if (result == true) {
            await FirebaseFirestore.instance.collection('items').add({
              'title': tCtrl.text,
              'description': dCtrl.text,
              'createdBy': FirebaseAuth.instance.currentUser?.uid,
              'createdAt': FieldValue.serverTimestamp(),
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  static String _timeAgo(dynamic ts) {
    try {
      if (ts == null) return '';
      final DateTime date = (ts is Timestamp) ? ts.toDate() : DateTime.parse(ts.toString());
      final diff = DateTime.now().difference(date);
      if (diff.inMinutes < 1) return 'now';
      if (diff.inHours < 1) return '${diff.inMinutes}m';
      if (diff.inDays < 1) return '${diff.inHours}h';
      return '${diff.inDays}d';
    } catch (_) {
      return '';
    }
  }
}