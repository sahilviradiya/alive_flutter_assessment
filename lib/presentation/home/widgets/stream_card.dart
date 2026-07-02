import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../domain/entities/stream_entity.dart';

/// A single live-stream tile used inside the Home grid, showing the
/// thumbnail, viewer count, host name and a follow button.
class StreamCard extends StatelessWidget {
  const StreamCard({super.key, required this.stream, this.onFollowTap});

  final StreamEntity stream;
  final VoidCallback? onFollowTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            stream.photoUrl,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return SvgPicture.asset(stream.thumbnailAsset, fit: BoxFit.cover);
            },
            errorBuilder: (context, error, stackTrace) {
              return SvgPicture.asset(stream.thumbnailAsset, fit: BoxFit.cover);
            },
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black.withValues(alpha: 0.0), Colors.black.withValues(alpha: 0.55)],
                stops: const [0.6, 1.0],
              ),
            ),
          ),
          Positioned(
            top: 8,
            left: 8,
            child: _ViewerBadge(count: stream.formattedViewerCount),
          ),
          Positioned(
            left: 7,
            right: 7,
            bottom: 7,
            child: Row(
              children: [
                _Avatar(photoUrl: stream.photoUrl),
                const SizedBox(width: 5),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        stream.hostName,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 1),
                      SvgPicture.asset(
                        stream.regionFlagAsset,
                        width: 13,
                        height: 13,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 3),
                _FollowButton(onTap: onFollowTap),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.photoUrl});

  final String photoUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1.1),
        image: DecorationImage(image: NetworkImage(photoUrl), fit: BoxFit.cover),
      ),
    );
  }
}

class _ViewerBadge extends StatelessWidget {
  const _ViewerBadge({required this.count});

  final String count;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              AppAssets.icEye,
              width: 12,
              height: 12,
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
            const SizedBox(width: 4),
            Text(
              count,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FollowButton extends StatelessWidget {
  const _FollowButton({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.followYellow,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          child: Text(
            AppStrings.follow,
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
          ),
        ),
      ),
    );
  }
}
