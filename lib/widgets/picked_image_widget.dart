import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../medical_desk.dart';

class PickedImageWidget extends StatelessWidget {
  final List<XFile> selectedImages;
  final void Function(int) onDelete;
  const PickedImageWidget({
    required this.selectedImages,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(selectedImages.isNotEmpty)...[
          TextView("Uploaded Files",fontsize: 12,fontweight: FontWeight.w500,textColor: ThemeColor.lightBlack,),
          SizedBox(height: 8,),
          ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
              height: 8,
            ),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: selectedImages.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.only(left:16,right:8,),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextView(
                        selectedImages[index].name, // Display file name
                        fontsize: 12,
                        fontweight: FontWeight.w400,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete_forever_outlined,color: ThemeColor.red0000,size: 20,),
                      onPressed: () {
                        onDelete(index);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: 8,),
        ]

      ],
    );
  }
}
