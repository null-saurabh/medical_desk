import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../medical_desk.dart';

class ImagePickerButton extends StatelessWidget {
  final Function(List<XFile>) onImagesSelected;
  final String title;
  const ImagePickerButton({
    required this.onImagesSelected,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            TextView(
              title,
              fontweight: FontWeight.w500,
            ),
            TextView("*",textColor: ThemeColor.red0000,fontweight: FontWeight.w500,)
          ],
        ),
        SizedBox(height: 8,),
        AppElevatedButton(
          width:  140,
          child: Row(
            children: [
              TextView("Upload",fontweight: FontWeight.w500,textColor: ThemeColor.white,),
              SizedBox(width: 8,),
              Icon(Icons.cloud_upload_outlined,color: ThemeColor.white,),
            ],
          ),
          // title: ,
          onPressed: () async {
            var list = await AppUtils.pickMultiImage();
            onImagesSelected(list);
          },
        ),
      ],
    );
  }
}
