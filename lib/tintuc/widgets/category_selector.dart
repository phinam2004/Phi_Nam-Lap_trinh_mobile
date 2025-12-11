import 'package:flutter/material.dart';

class CategorySelector extends StatelessWidget {
  final List<String> categories;
  final String selected;
  final Function(String) onSelected;

  const CategorySelector({
    required this.categories,
    required this.selected,
    required this.onSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        separatorBuilder: (_, __) => SizedBox(width: 10),
        itemBuilder: (context, index) {
          final cat = categories[index];
          final isSelected = cat == selected;

          return ChoiceChip(
            label: Text(cat),
            selected: isSelected,
            onSelected: (_) => onSelected(cat),
          );
        },
      ),
    );
  }
}
