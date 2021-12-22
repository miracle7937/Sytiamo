import 'package:sytiamo/data/model/responseModel/agent_payment_model.dart';
import 'package:sytiamo/data/model/responseModel/breakdown_loan_model.dart';
import 'package:sytiamo/data/model/responseModel/loan_collcet_model.dart';
import 'package:sytiamo/data/model/responseModel/loan_creation_response.dart';
import 'package:sytiamo/data/model/setModel/loan_creation_model.dart';
import 'package:sytiamo/utils/route_api.dart';

import '../http.dart';

class RequestLoanRepo {
  ServerData _serverData = ServerData();

  Future<LoanCreationResponse> post(LoanCreationModel loanCreationModel) async {
    var responseData = await _serverData.postData(null,
        body: loanCreationModel.toJson(), path: Routes.createdLoan);
    print(responseData.data);

    return LoanCreationResponse.fromJson(responseData.data);
  }

  Future<LoanCollectionUsersModel> getLoanRunningUser(Map map) async {
    var responseData =
        await _serverData.postData(null, body: map, path: Routes.runningLoan);
    print(responseData.data);
    return LoanCollectionUsersModel.fromJson(responseData.data);
  }

  Future<LoanCollectionUsersModel> generateReport(Map map) async {
    var responseData =
        await _serverData.postData(null, body: map, path: Routes.reportRoute);
    print(responseData.data);
    return LoanCollectionUsersModel.fromJson(responseData.data);
  }

  Future<Map> payedBreakDow(Map map, id) async {
    var responseData = await _serverData.getData(null,
        path: Routes.getBreakdown(id.toString()));
    print(responseData.data);
    return responseData.data;
  }

  Future<BreakDownLoanModel> getLoanBreakDown(Map map) async {
    var responseData =
        await _serverData.postData(null, path: Routes.loanDetail, body: map);
    print(responseData.data);
    return BreakDownLoanModel.fromJson(responseData.data);
  }

  Future<AgentPaymentModel> agentPayed(Map map) async {
    var responseData = await _serverData.postData(null,
        body: map, path: Routes.agentRepayment);
    print(responseData.data);
    return AgentPaymentModel.fromJson(responseData.data);
  }
}
