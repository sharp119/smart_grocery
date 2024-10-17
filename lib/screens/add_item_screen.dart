import 'package:flutter/material.dart';
import '../components/custom_app_bar.dart';
import '../models/models.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({Key? key}) : super(key: key);

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _formKey = GlobalKey<FormState>();
  String _itemName = '';
  int _quantity = 1;
  FreshnessLevel _freshnessLevel = FreshnessLevel.fresh;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Add New Item'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Item Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an item name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _itemName = value!;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Quantity',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  initialValue: '1',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a quantity';
                    }
                    if (int.tryParse(value) == null || int.parse(value) < 1) {
                      return 'Please enter a valid quantity';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _quantity = int.parse(value!);
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  'Freshness Level',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                SegmentedButton<FreshnessLevel>(
                  segments: const [
                    ButtonSegment(
                      value: FreshnessLevel.fresh,
                      label: Text('Fresh'),
                      icon: Icon(Icons.circle, color: Colors.green),
                    ),
                    ButtonSegment(
                      value: FreshnessLevel.medium,
                      label: Text('Medium'),
                      icon: Icon(Icons.circle, color: Colors.orange),
                    ),
                    ButtonSegment(
                      value: FreshnessLevel.expiringSoon,
                      label: Text('Expiring Soon'),
                      icon: Icon(Icons.circle, color: Colors.red),
                    ),
                  ],
                  selected: {_freshnessLevel},
                  onSelectionChanged: (Set<FreshnessLevel> newSelection) {
                    setState(() {
                      _freshnessLevel = newSelection.first;
                    });
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Add Item'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // TODO: Save the new item to the inventory
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Added $_quantity $_itemName to inventory')),
      );
      Navigator.pop(context);
    }
  }
}
