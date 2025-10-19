import 'package:e_commerce/widget/custom_text_field.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Postpage extends StatelessWidget {
  Postpage({super.key});
  TextEditingController title = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController image = TextEditingController();
  TextEditingController category = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Customtextfield(
            icon: Icon(Icons.title),
            textHint: Text('title'),
            textEditingController: title,
          ),
          const SizedBox(height: 10),

          Customtextfield(
            icon: Icon(Icons.price_change),
            textHint: Text('price'),
            textEditingController: price,
          ),
          const SizedBox(height: 10),

          Customtextfield(
            icon: Icon(Icons.description),
            textHint: Text('description'),
            textEditingController: description,
          ),
          const SizedBox(height: 10),

          Customtextfield(
            icon: Icon(Icons.image),
            textHint: Text('image'),
            textEditingController: image,
          ),
          const SizedBox(height: 10),

          Customtextfield(
            icon: Icon(Icons.category),
            textHint: Text('category'),
            textEditingController: category,
          ),
          const SizedBox(height: 18),
          TextButton.icon(onPressed: () {}, label: Text('Enter')),
        ],
      ),
    );
  }
}
