import '../models/country_model.dart';
import '../models/stream_model.dart';

/// Provides the data shown on the Home screen.
///
/// The methods are async and return the same shapes a REST endpoint would, so
/// swapping the hard-coded lists for an HTTP client later requires no changes
/// in the view-model or UI ("API-ready architecture").
class StreamRepository {
  /// Region filter chips.
  Future<List<CountryModel>> fetchCountries() async {
    await _simulateLatency();
    return const <CountryModel>[
      CountryModel(name: 'Global', flag: '🌐', isGlobal: true),
      CountryModel(name: 'India', flag: '🇮🇳'),
      CountryModel(name: 'Philippines', flag: '🇵🇭'),
      CountryModel(name: 'Brazil', flag: '🇧🇷'),
      CountryModel(name: 'Turkey', flag: '🇹🇷'),
      CountryModel(name: 'USA', flag: '🇺🇸'),
    ];
  }

  /// Live streams for the grid. Thumbnails point at remote portrait photos to
  /// keep the demo asset-free while looking production-like.
  Future<List<StreamModel>> fetchStreams() async {
    await _simulateLatency();
    return const <StreamModel>[
      StreamModel(
        id: '1',
        hostName: 'Sofia Chen',
        viewers: '8.2K',
        countryFlag: '🇵🇭',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=600&q=80',
      ),
      StreamModel(
        id: '2',
        hostName: 'Sofia Chen',
        viewers: '8.2K',
        countryFlag: '🇵🇭',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=600&q=80',
      ),
      StreamModel(
        id: '3',
        hostName: 'Sofia Chen',
        viewers: '8.2K',
        countryFlag: '🇵🇭',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1488426862026-3ee34a7d66df?w=600&q=80',
      ),
      StreamModel(
        id: '4',
        hostName: 'Sofia Chen',
        viewers: '8.2K',
        countryFlag: '🇵🇭',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?w=600&q=80',
      ),
      StreamModel(
        id: '5',
        hostName: 'Sofia Chen',
        viewers: '8.2K',
        countryFlag: '🇵🇭',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1492633423870-43d1cd2775eb?w=600&q=80',
      ),
      StreamModel(
        id: '6',
        hostName: 'Sofia Chen',
        viewers: '8.2K',
        countryFlag: '🇵🇭',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=600&q=80',
      ),
    ];
  }

  Future<void> _simulateLatency() =>
      Future<void>.delayed(const Duration(milliseconds: 350));
}
