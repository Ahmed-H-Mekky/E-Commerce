import 'package:e_commerce/Screen/page_get_category.dart';
import 'package:flutter/material.dart';

class CustomListView extends StatelessWidget {
  final dynamic state;
  const CustomListView({super.key, required this.state});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: state.categoryList.length,
          itemBuilder: (context, index) {
            final data = state.categoryList[index];

            return GestureDetector(
              onTap: () {
                Navigator.of(
                  context,
                ).pushNamed(PageGetCategory.id, arguments: data);
              },
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    state.categoryList[index],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
