import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/home_viewmodel.dart';
import 'region_chip.dart';

class RegionFilterRow extends StatelessWidget {
  const RegionFilterRow({super.key});

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
