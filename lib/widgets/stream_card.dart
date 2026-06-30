import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_strings.dart';
import '../core/constants/app_text_styles.dart';
import '../data/models/stream_model.dart';

/// A single live-stream tile: full-bleed thumbnail with a viewer-count pill
/// (top-left) and a host row with a "+ Follow" pill (bottom).
class StreamCard extends StatelessWidget {
  const StreamCard({super.key, required this.stream});

  final StreamModel stream;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Thumbnail.
          CachedNetworkImage(
            imageUrl: stream.thumbnailUrl,
            fit: BoxFit.cover,
            placeholder: (BuildContext c, String _) => Container(
              color: AppColors.fieldFill,
              child: const Center(
                child: SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppColors.primary),
                  ),
                ),
              ),
            ),
            errorWidget: (BuildContext c, String url, Object error) =>
                Container(
              color: AppColors.fieldFill,
              child: const Icon(Icons.broken_image_outlined,
                  color: AppColors.hint),
            ),
          ),

          // Bottom gradient scrim so the name/pill stay legible.
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 80,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: <Color>[
                    AppColors.black.withValues(alpha: 0.65),
                    AppColors.black.withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
          ),

          // Viewer-count pill.
          Positioned(
            top: 10,
            left: 10,
            child: _ViewerPill(count: stream.viewers),
          ),

          // Host name + follow pill.
          Positioned(
            left: 10,
            right: 10,
            bottom: 10,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        stream.hostName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.cardName.copyWith(fontSize: 13),
                      ),
                      const SizedBox(height: 2),
                      Text(stream.countryFlag,
                          style: const TextStyle(fontSize: 11)),
                    ],
                  ),
                ),
                const SizedBox(width: 6),
                const _FollowPill(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ViewerPill extends StatelessWidget {
  const _ViewerPill({required this.count});

  final String count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.black.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(Icons.remove_red_eye,
              color: AppColors.white, size: 13),
          const SizedBox(width: 4),
          Text(count, style: AppTextStyles.viewerCount),
        ],
      ),
    );
  }
}

class _FollowPill extends StatelessWidget {
  const _FollowPill();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.accentYellow,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(AppStrings.follow, style: AppTextStyles.followPill),
    );
  }
}
