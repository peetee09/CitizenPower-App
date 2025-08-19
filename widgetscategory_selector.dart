import 'package:flutter/material.dart';

class CategorySelector extends StatefulWidget {
  const CategorySelector({super.key});

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  String? _selectedCategory;

  final List<Map<String, dynamic>> _categories = [
    {'icon': Icons.road, 'label': 'Roads'},
    {'icon': Icons.water_drop, 'label': 'Water'},
    {'icon': Icons.delete, 'label': 'Waste'},
    {'icon': Icons.bolt, 'label': 'Electricity'},
    {'icon': Icons.local_police, 'label': 'Safety'},
    {'icon': Icons.park, 'label': 'Parks'},
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: _categories.map((category) {
        return ChoiceChip(
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(category['icon'], size: 18),
              const SizedBox(width: 5),
              Text(category['label']),
            ],
          ),
          selected: _selectedCategory == category['label'],
          onSelected: (selected) {
            setState(() {
              _selectedCategory = selected ? category['label'] : null;
            });
          },
        );
      }).toList(),
    );
  }
}