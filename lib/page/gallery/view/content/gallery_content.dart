import 'package:club_application/page/gallery/bloc/gallery_bloc.dart';
import 'package:club_application/page/gallery/view/content/gallery_single_image.dart';
import 'package:club_application/res/const.dart';
import 'package:club_application/res/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';



class GalleryContent extends StatelessWidget {
  const GalleryContent({Key? key}) : super(key: key);

  // final Galleries galleries;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GalleryBloc, GalleryState>(
      builder: (BuildContext context, state) {
        if (state.status == NetworkStatus.loading) {
          return Center(
            child: CircularProgressIndicator(
              color: mainColor,
            ),
          );
        }
        if (state.status == NetworkStatus.success) {
          if (state.galleries != null) {
            return state.galleries!.galleries.isNotEmpty ? MasonryGridView.count(
              // controller: state.galleries.galleries.scrollController,
              itemCount: state.galleries!.galleries.length,
              crossAxisCount: 2,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
              itemBuilder: (BuildContext context, int index) {
                final data = state.galleries!.galleries[index];
                return SizedBox(
                  /// BlurHash is a fast and easy way to render a blurry image
                  /// for a blurHash widget we need to pass height
                  height: index.isEven ? 200 : 300,
                  // child: Image.network('${data.attachmentFile}', fit: BoxFit.cover,),
                  child: InkWell(
                    onTap: () => Navigator.of(context).push(GallerySingleImage.route(data)),
                    child: BlurHash(
                        hash: 'L5H2EC=PM+yV0g-mq.wG9c010J}I',
                        image: data.attachmentFile),
                  ),
                );
              },
            ) : const Center(
              child: Text(
                'No Image Found',
                textAlign: TextAlign.center,
                style: TextStyle(height: 1.6),
              ),
            );
          }
        }
        if (state.status == NetworkStatus.failure) {
          return const Center(
            child: Text('Error to load'),
          );
        }
        return const SizedBox();
      },
    );
  }
}
