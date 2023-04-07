import 'package:flutter/material.dart';
import 'package:meta_club_api/src/models/gallery.dart';
import 'package:photo_view/photo_view.dart';

class GallerySingleImage extends StatelessWidget {
  const GallerySingleImage({Key? key, this.gallery}) : super(key: key);
  final Gallery? gallery;

  static Route route(Gallery? galleries) => MaterialPageRoute(
      builder: (_) => GallerySingleImage(
            gallery: galleries,
          ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          gallery!.attachmentFile != null
              ? PhotoView(
                  imageProvider: NetworkImage(gallery!.attachmentFile!),
                )
              : const SizedBox(),
          Positioned(
            left: 10,
            top: 60,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade700,
                shape: BoxShape.circle
              ),
              child: IconButton(
                splashRadius: 12,
                padding: EdgeInsets.zero,
                onPressed: ()=> Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back_ios_new_sharp),
              ),
            )
          ),
        ],
      ),
    );
  }
}
