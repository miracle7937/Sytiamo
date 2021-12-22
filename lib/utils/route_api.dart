class Routes {
  static String baseURL = "http://sytiamoportal.com/api";
  static String login = "$baseURL/login";
  static String loanProduct = "$baseURL/loanproduct";
  static String location = "$baseURL/location";
  static String userAPI = "$baseURL/userapi";
  static String createdLoan = "$baseURL/createloan";
  static String getCustomer(String name) => "$baseURL/userapi/search/$name";
  static String getBreakdown(String id) => "$baseURL/loanrepay/paid/$id";
  static String runningLoan = "$baseURL/loanrepay/loancollect";
  static String agentRepayment = "$baseURL/loanrepay/createrepay";
  static String reportRoute = "$baseURL/loanrepay/report";
  static String smsRoute = "$baseURL/send";
  static String ticket = "$baseURL/support_tickets";
  static String userLoanBreakdown = "$baseURL/breakdown";
  static String loanDetail = "$baseURL/loanrepay/loandetails";
}
