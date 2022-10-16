
import 'package:http/http.dart' as http;
import '../class/stationListResponse.dart';

Future<http.Response> getStationListAPI(String accessToken) {
  return http.get(
    Uri.parse(
        'https://staging.api.locq.com/ms-fleet/station?page=1&perPage=1000'),
    headers: <String, String>{
      'Authorization': accessToken,
    },
  );
}
