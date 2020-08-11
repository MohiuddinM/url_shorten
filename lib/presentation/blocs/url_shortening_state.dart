import 'package:super_enum/super_enum.dart';
import 'package:url_shorten/data/models/shortened_url.dart';

part 'url_shortening_state.g.dart';

@superEnum
enum _UrlShorteningState {
  @object
  Idle,
  @Data(fields: [DataField<ShortenedUrl>('shortUrl')])
  Loaded,
  @object
  Loading,
  @Data(fields: [DataField<String>('message')])
  Failed,
}
