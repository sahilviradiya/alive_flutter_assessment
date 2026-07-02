import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../profile/view/profile_view.dart';
import '../viewmodel/home_viewmodel.dart';
import '../widgets/coming_soon_view.dart';
import '../widgets/feed_tabs.dart';
import '../widgets/home_bottom_nav_bar.dart';
import '../widgets/home_top_bar.dart';
import '../widgets/region_filter_row.dart';
import '../widgets/stream_grid.dart';

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
        FeedTabs(),
        SizedBox(height: 10),
        RegionFilterRow(),
        SizedBox(height: 12),
        Expanded(child: StreamGrid()),
      ],
    );
  }
}
