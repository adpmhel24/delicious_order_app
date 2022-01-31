class UserModel {
  int? id;
  String? username;
  String? fullname;
  String? dateUpdated;
  String? branch;
  String? whse;
  bool? isActive;
  bool? isAdmin;
  bool? isSuperAdmin;
  bool? isManager;
  bool? isAuditor;
  bool? isSales;
  bool? isCashier;
  bool? isProduction;
  bool? isAgentSales;
  bool? isCashSales;
  bool? isARSales;
  bool? isAccounting;
  bool? isCanAddSap;
  bool? isCanAddActualCash;
  bool? isAllowConfidential;
  bool? isAllowItemAdjustment;
  bool? isAllowProdOrder;
  bool? isAllowIssueForProd;
  bool? isAllowReceiveFromProd;
  bool? isAllowTransfer;
  bool? isAllowReceive;
  bool? isAllowEnding;
  bool? isAllowPullOut;
  bool? isAllowDeposit;
  bool? isAllowPayment;
  bool? isAllowSales;
  bool? isAllowSoa;
  bool? isAllowForecast;
  bool? isAllowInventoryReturn;
  bool? isAllowItemSalesSummaryReport;
  bool? isAllowBranchSalesSummaryReport;
  bool? isAllowCustomerSalesSummaryReport;
  bool? isAllowFinalPrintedReport;
  bool? isAllowToAdd;
  bool? isAllowToConfirm;
  bool? isAllowToCancel;
  bool? isAllowToUpdate;
  bool? isAllowToClose;
  bool? isAllowToVoid;
  bool? isAllowToDiscount;
  bool? isAllowToPayAR;
  bool? isAllowToPayCash;
  bool? isAllowToPayAgent;
  bool? isAllowToReceivePO;
  bool? isAllowToCustomer;
  late String token;

  UserModel(
      {this.id,
      this.username,
      this.fullname,
      this.dateUpdated,
      this.branch,
      this.whse,
      this.isActive,
      this.isAdmin,
      this.isSuperAdmin,
      this.isManager,
      this.isAuditor,
      this.isSales,
      this.isCashier,
      this.isProduction,
      this.isAgentSales,
      this.isCashSales,
      this.isARSales,
      this.isAccounting,
      this.isCanAddSap,
      this.isCanAddActualCash,
      this.isAllowConfidential,
      this.isAllowItemAdjustment,
      this.isAllowProdOrder,
      this.isAllowIssueForProd,
      this.isAllowReceiveFromProd,
      this.isAllowTransfer,
      this.isAllowReceive,
      this.isAllowEnding,
      this.isAllowPullOut,
      this.isAllowDeposit,
      this.isAllowPayment,
      this.isAllowSales,
      this.isAllowSoa,
      this.isAllowForecast,
      this.isAllowInventoryReturn,
      this.isAllowItemSalesSummaryReport,
      this.isAllowBranchSalesSummaryReport,
      this.isAllowCustomerSalesSummaryReport,
      this.isAllowFinalPrintedReport,
      this.isAllowToAdd,
      this.isAllowToConfirm,
      this.isAllowToCancel,
      this.isAllowToUpdate,
      this.isAllowToClose,
      this.isAllowToVoid,
      this.isAllowToDiscount,
      this.isAllowToPayAR,
      this.isAllowToPayCash,
      this.isAllowToPayAgent,
      this.isAllowToReceivePO,
      this.isAllowToCustomer,
      required this.token});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    fullname = json['fullname'];
    dateUpdated = json['date_updated'];
    branch = json['branch'];
    whse = json['whse'];
    isActive = json['isActive'];
    isAdmin = json['isAdmin'];
    isSuperAdmin = json['isSuperAdmin'];
    isManager = json['isManager'];
    isAuditor = json['isAuditor'];
    isSales = json['isSales'];
    isCashier = json['isCashier'];
    isProduction = json['isProduction'];
    isAgentSales = json['isAgentSales'];
    isCashSales = json['isCashSales'];
    isARSales = json['isARSales'];
    isAccounting = json['isAccounting'];
    isCanAddSap = json['isCanAddSap'];
    isCanAddActualCash = json['isCanAddActualCash'];
    isAllowConfidential = json['isAllowConfidential'];
    isAllowItemAdjustment = json['isAllowItemAdjustment'];
    isAllowProdOrder = json['isAllowProdOrder'];
    isAllowIssueForProd = json['isAllowIssueForProd'];
    isAllowReceiveFromProd = json['isAllowReceiveFromProd'];
    isAllowTransfer = json['isAllowTransfer'];
    isAllowReceive = json['isAllowReceive'];
    isAllowEnding = json['isAllowEnding'];
    isAllowPullOut = json['isAllowPullOut'];
    isAllowDeposit = json['isAllowDeposit'];
    isAllowPayment = json['isAllowPayment'];
    isAllowSales = json['isAllowSales'];
    isAllowSoa = json['isAllowSoa'];
    isAllowForecast = json['isAllowForecast'];
    isAllowInventoryReturn = json['isAllowInventoryReturn'];
    isAllowItemSalesSummaryReport = json['isAllowItemSalesSummaryReport'];
    isAllowBranchSalesSummaryReport = json['isAllowBranchSalesSummaryReport'];
    isAllowCustomerSalesSummaryReport =
        json['isAllowCustomerSalesSummaryReport'];
    isAllowFinalPrintedReport = json['isAllowFinalPrintedReport'];
    isAllowToAdd = json['isAllowToAdd'];
    isAllowToConfirm = json['isAllowToConfirm'];
    isAllowToCancel = json['isAllowToCancel'];
    isAllowToUpdate = json['isAllowToUpdate'];
    isAllowToClose = json['isAllowToClose'];
    isAllowToVoid = json['isAllowToVoid'];
    isAllowToDiscount = json['isAllowToDiscount'];
    isAllowToPayAR = json['isAllowToPayAR'];
    isAllowToPayCash = json['isAllowToPayCash'];
    isAllowToPayAgent = json['isAllowToPayAgent'];
    isAllowToReceivePO = json['isAllowToReceivePO'];
    isAllowToCustomer = json['isAllowToCustomer'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['fullname'] = fullname;
    data['date_updated'] = dateUpdated;
    data['branch'] = branch;
    data['whse'] = whse;
    data['isActive'] = isActive;
    data['isAdmin'] = isAdmin;
    data['isSuperAdmin'] = isSuperAdmin;
    data['isManager'] = isManager;
    data['isAuditor'] = isAuditor;
    data['isSales'] = isSales;
    data['isCashier'] = isCashier;
    data['isProduction'] = isProduction;
    data['isAgentSales'] = isAgentSales;
    data['isCashSales'] = isCashSales;
    data['isARSales'] = isARSales;
    data['isAccounting'] = isAccounting;
    data['isCanAddSap'] = isCanAddSap;
    data['isCanAddActualCash'] = isCanAddActualCash;
    data['isAllowConfidential'] = isAllowConfidential;
    data['isAllowItemAdjustment'] = isAllowItemAdjustment;
    data['isAllowProdOrder'] = isAllowProdOrder;
    data['isAllowIssueForProd'] = isAllowIssueForProd;
    data['isAllowReceiveFromProd'] = isAllowReceiveFromProd;
    data['isAllowTransfer'] = isAllowTransfer;
    data['isAllowReceive'] = isAllowReceive;
    data['isAllowEnding'] = isAllowEnding;
    data['isAllowPullOut'] = isAllowPullOut;
    data['isAllowDeposit'] = isAllowDeposit;
    data['isAllowPayment'] = isAllowPayment;
    data['isAllowSales'] = isAllowSales;
    data['isAllowSoa'] = isAllowSoa;
    data['isAllowForecast'] = isAllowForecast;
    data['isAllowInventoryReturn'] = isAllowInventoryReturn;
    data['isAllowItemSalesSummaryReport'] = isAllowItemSalesSummaryReport;
    data['isAllowBranchSalesSummaryReport'] = isAllowBranchSalesSummaryReport;
    data['isAllowCustomerSalesSummaryReport'] =
        isAllowCustomerSalesSummaryReport;
    data['isAllowFinalPrintedReport'] = isAllowFinalPrintedReport;
    data['isAllowToAdd'] = isAllowToAdd;
    data['isAllowToConfirm'] = isAllowToConfirm;
    data['isAllowToCancel'] = isAllowToCancel;
    data['isAllowToUpdate'] = isAllowToUpdate;
    data['isAllowToClose'] = isAllowToClose;
    data['isAllowToVoid'] = isAllowToVoid;
    data['isAllowToDiscount'] = isAllowToDiscount;
    data['isAllowToPayAR'] = isAllowToPayAR;
    data['isAllowToPayCash'] = isAllowToPayCash;
    data['isAllowToPayAgent'] = isAllowToPayAgent;
    data['isAllowToReceivePO'] = isAllowToReceivePO;
    data['isAllowToCustomer'] = isAllowToCustomer;
    data['token'] = token;
    return data;
  }
}
