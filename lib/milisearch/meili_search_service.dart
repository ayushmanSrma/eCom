import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meilisearch/meilisearch.dart';

class MeiliSearchService {
  final MeiliSearchClient client;
  late final MeiliSearchIndex index;

  MeiliSearchService()
      : client = MeiliSearchClient(
    dotenv.env['MEILI_API_HOST'] ?? 'http://localhost:7700',
    dotenv.env['MEILI_MASTER_KEY'] ?? '',
  ) {
    index = client.index('newsblog');
  }

  Future<List<Map<String, dynamic>>> search(String query) async {
    final result = await index.search(query);
    return List<Map<String, dynamic>>.from(result.hits);
  }
}
