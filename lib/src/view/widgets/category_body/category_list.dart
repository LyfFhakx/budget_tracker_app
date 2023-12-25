import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data.dart';
import 'category_card.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (_, db, __) {
        var list = db.categories;
        return ListView.builder(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            itemCount: list.length,
            itemBuilder: (_, i) => CategoryCard(list[i]));
      },
    );
  }

}
