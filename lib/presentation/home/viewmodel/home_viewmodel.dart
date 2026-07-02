import 'package:flutter/foundation.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_strings.dart';
import '../../../domain/entities/stream_entity.dart';
import '../../../domain/usecases/get_streams_usecase.dart';

class RegionFilter {
  const RegionFilter(this.label, this.flagAsset);

  final String label;
  final String flagAsset;
}

/// Drives the Home feed: top tab (Stream/Hot/Follow), region filter chips,
/// bottom navigation index, and the resulting stream list.
class HomeViewModel extends ChangeNotifier {
  HomeViewModel(this._getStreamsUseCase) {
    _loadStreams();
  }

  final GetStreamsUseCase _getStreamsUseCase;

  static const List<String> tabs = [
    AppStrings.tabStream,
    AppStrings.tabHot,
    AppStrings.tabFollow,
  ];

  static const List<RegionFilter> regions = [
    RegionFilter(AppStrings.regionGlobal, AppAssets.flagGlobal),
    RegionFilter(AppStrings.regionIndia, AppAssets.flagIndia),
    RegionFilter(AppStrings.regionPhilippines, AppAssets.flagPhilippines),
    RegionFilter(AppStrings.regionBrazil, AppAssets.flagBrazil),
  ];

  int _selectedTabIndex = 0;
  int _selectedRegionIndex = 0;
  int _selectedNavIndex = 0;
  bool _isLoading = true;
  List<StreamEntity> _streams = [];

  int get selectedTabIndex => _selectedTabIndex;
  int get selectedRegionIndex => _selectedRegionIndex;
  int get selectedNavIndex => _selectedNavIndex;
  bool get isLoading => _isLoading;
  List<StreamEntity> get streams => _streams;

  Future<void> _loadStreams() async {
    _isLoading = true;
    notifyListeners();
    _streams = await _getStreamsUseCase(region: regions[_selectedRegionIndex].label);
    _isLoading = false;
    notifyListeners();
  }

  void selectTab(int index) {
    if (index == _selectedTabIndex) return;
    _selectedTabIndex = index;
    notifyListeners();
  }

  void selectRegion(int index) {
    if (index == _selectedRegionIndex) return;
    _selectedRegionIndex = index;
    _loadStreams();
  }

  void selectNavItem(int index) {
    if (index == _selectedNavIndex) return;
    _selectedNavIndex = index;
    notifyListeners();
  }
}
