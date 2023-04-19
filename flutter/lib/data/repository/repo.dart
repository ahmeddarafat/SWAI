import 'package:google_solution2/app/constants.dart';
import 'package:google_solution2/data/model/measurements_model.dart';
import 'package:google_solution2/data/network/api_service.dart';
// import 'package:google_solution2/data/network/network_info.dart';

class Repo {
  final ApiService apiService;
  // final NetworkInfo networkInfo;
  Repo({required this.apiService});


  Future<MeasurementsModel> getMeasurements() async{
    // if(await networkInfo.isConnected){}
    final response = await apiService.getData(url: Constants.measurementsEndpoint);
    return MeasurementsModel.fromJson(response.data);
  }
}
