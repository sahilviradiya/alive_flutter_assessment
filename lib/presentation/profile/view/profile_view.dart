import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/routes/app_routes.dart';
import '../viewmodel/profile_viewmodel.dart';

/// Profile tab content: shows the signed-in Google account's photo,
/// name and email (fetched from Firebase Auth via [ProfileViewModel]),
/// plus a logout action.
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  Future<void> _confirmLogout(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text(AppStrings.logoutConfirmTitle),
        content: const Text(AppStrings.logoutConfirmMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text(AppStrings.logout, style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;

    await context.read<ProfileViewModel>().signOut();
    if (!context.mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, viewModel, _) {
        final user = viewModel.user;
        return ListView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
          children: [
            Center(
              child: CircleAvatar(
                radius: 48,
                backgroundColor: AppColors.inputFill,
                backgroundImage: (user?.photoUrl != null) ? NetworkImage(user!.photoUrl!) : null,
                child: user?.photoUrl == null
                    ? const Icon(Icons.person, size: 48, color: AppColors.textHint)
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              user?.name ?? '—',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 4),
            Text(
              user?.email ?? '—',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 32),
            const Divider(color: AppColors.divider),
            Material(
              color: Colors.transparent,
              child: ListTile(
                leading: const Icon(Icons.logout, color: AppColors.error),
                title: const Text(AppStrings.logout, style: TextStyle(color: AppColors.error, fontWeight: FontWeight.w600)),
                onTap: () => _confirmLogout(context),
              ),
            ),
            const Divider(color: AppColors.divider),
          ],
        );
      },
    );
  }
}
