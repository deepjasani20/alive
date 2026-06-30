import 'package:get/get.dart';

import '../../../data/models/country_model.dart';
import '../../../data/models/stream_model.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/stream_repository.dart';

/// Presentation logic + state for the Home screen.
///
/// Exposes reactive lists and selection indices so the view simply renders
/// whatever the view-model publishes.
class HomeViewModel extends GetxController {
  HomeViewModel(this._streamRepository, {this.user});

  final StreamRepository _streamRepository;

  /// The user passed in from the login flow (may be null on cold start).
  final UserModel? user;

  final RxBool isLoading = true.obs;
  final RxList<CountryModel> countries = <CountryModel>[].obs;
  final RxList<StreamModel> streams = <StreamModel>[].obs;

  /// Stream / Hot / Follow tab index.
  final RxInt selectedTab = 0.obs;

  /// Index of the selected region chip.
  final RxInt selectedCountry = 0.obs;

  /// Bottom-navigation index (Go-Live centre button is excluded).
  final RxInt navIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _load();
  }

  Future<void> _load() async {
    isLoading.value = true;
    final List<CountryModel> fetchedCountries =
        await _streamRepository.fetchCountries();
    final List<StreamModel> fetchedStreams =
        await _streamRepository.fetchStreams();
    countries.assignAll(fetchedCountries);
    streams.assignAll(fetchedStreams);
    isLoading.value = false;
  }

  /// Pull-to-refresh handler.
  Future<void> refreshData() => _load();

  void selectTab(int index) => selectedTab.value = index;
  void selectCountry(int index) => selectedCountry.value = index;
  void selectNav(int index) => navIndex.value = index;
}
