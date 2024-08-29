import 'package:alibtisam/core/error/server_exception.dart';
import 'package:alibtisam/core/services/api_urls.dart';
import 'package:alibtisam/core/services/http_wrapper.dart';

class TournamentRequestRepo {
  Future requestTorunament(
      {required String name,
      required String startDate,
      required String endDate,
      required String type,
      required String location,
      required String description,
      required String travelDate,
      required String transportMedium,
      required String expectedDeparture,
      required String expectedArrival,
      required String from,
      required String to,
      required String teamName,
      required List<String> playerIds,
      required List<String> coachIds,
      required int requestedAmount}) async {
    try {
      final res =
          await HttpWrapper.postRequest(base_url + 'request/tournament', {
        "name": name,
        "startDate": startDate,
        "endDate": endDate,
        "type": type,
        "location": location,
        "description": description,
        "travelDate": travelDate,
        "transportMedium": transportMedium,
        "expectedDeparture": expectedDeparture,
        "expectedArrival": expectedArrival,
        "from": from,
        "to": to,
        "teamName": teamName,
        "playerIds": playerIds,
        "coachIds": coachIds,
        "requestedAmount": requestedAmount
      });
      return res;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  fetchTournamentsRequests() async {
    try {
      final res = await HttpWrapper.getRequest(
          base_url + 'request/by-status/all?kind=tournamentRequest');

      return res;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  fetchTournamentDataById({required String id})async{
    try {
      final res = await HttpWrapper.getRequest(base_url + 'request/get/$id');
      return res;
    } catch (e) {
      throw ServerException(e.toString());
      
    }
  }
}
