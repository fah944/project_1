import 'package:flutter/material.dart';

import 'custome_image.dart';

class PatientsListViewItem extends StatelessWidget {
  final String? profImage;
  const PatientsListViewItem({
    super.key,
    this.profImage,
  });


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomeImage(
          image: profImage == null ? 'assets/images/expert_image2.jpg' : profImage!,
          width: MediaQuery.of(context).size.height * .09,
          height: MediaQuery.of(context).size.height * .09,
          borderRadius: BorderRadius.circular(40),
        ),
      ],
    );
  }
}
