import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../profile/view/profile_view.dart';
import '../viewmodel/home_viewmodel.dart';
import '../widgets/coming_soon_view.dart';
import '../widgets/home_bottom_nav_bar.dart';
import '../widgets/home_top_bar.dart';
import '../widgets/region_chip.dart';
import '../widgets/stream_card.dart';

/// Home feed screen: matches the "Alive" live-streaming UI reference —
/// top bar, Stream/Hot/Follow tabs, region filters and a stream grid.
/// Also hosts the bottom navigation's other destinations (Party, Chats,
/// Profile) so switching tabs shows real, distinct content.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _handleNavTap(BuildContext context, int index) {
    final viewModel = context.read<HomeViewModel>();
    if (index == 2) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text(AppStrings.goLiveNotice)));
      return;
    }
    viewModel.selectNavItem(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: Consumer<HomeViewModel>(
          builder: (context, viewModel, _) {
            switch (viewModel.selectedNavIndex) {
              case 1:
                return const ComingSoonView(icon: Icons.celebration_outlined, label: AppStrings.navParty);
              case 3:
                return const ComingSoonView(icon: Icons.chat_bubble_outline, label: AppStrings.navChats);
              case 4:
                return const ProfileView();
              default:
                return const _HomeFeedBody();
            }
          },
        ),
      ),
      bottomNavigationBar: Consumer<HomeViewModel>(
        builder: (context, viewModel, _) {
          return HomeBottomNavBar(
            selectedIndex: viewModel.selectedNavIndex,
            onTap: (index) => _handleNavTap(context, index),
          );
        },
      ),
    );
  }
}

class _HomeFeedBody extends StatelessWidget {
  const _HomeFeedBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        HomeTopBar(notificationCount: 3),
        _FeedTabs(),
        SizedBox(height: 10),
        _RegionFilterRow(),
        SizedBox(height: 12),
        Expanded(child: _StreamGrid()),
      ],
    );
  }
}

class _FeedTabs extends StatelessWidget {
  const _FeedTabs();

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: List.generate(HomeViewModel.tabs.length, (index) {
              final selected = viewModel.selectedTabIndex == index;
              return Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () => viewModel.selectTab(index),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          HomeViewModel.tabs[index],
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                            color: selected ? AppColors.primaryGreenDark : AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          height: 3,
                          width: selected ? 16 : 0,
                          decoration: BoxDecoration(
                            color: AppColors.primaryGreenDark,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}

class _RegionFilterRow extends StatelessWidget {
  const _RegionFilterRow();

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, _) {
        return SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: HomeViewModel.regions.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final region = HomeViewModel.regions[index];
              return RegionChip(
                label: region.label,
                flagAsset: region.flagAsset,
                selected: viewModel.selectedRegionIndex == index,
                onTap: () => viewModel.selectRegion(index),
              );
            },
          ),
        );
      },
    );
  }
}

class _StreamGrid extends StatelessWidget {
  const _StreamGrid();

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, _) {
        if (viewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return GridView.builder(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          itemCount: viewModel.streams.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.74,
          ),
          itemBuilder: (context, index) {
            return StreamCard(stream: viewModel.streams[index]);
          },
        );
      },
    );
  }
}
