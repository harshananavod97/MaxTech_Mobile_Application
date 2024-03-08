class ProductInfo {
  final String productName;
  final String sellPriceIncTax;
  final int productId;
  final String productquantity;
  final int variationid;
  final String picestype;

  ProductInfo(
      {required this.productName,
      required this.sellPriceIncTax,
      required this.productId,
      required this.productquantity,
      required this.variationid,
      required this.picestype});
}

class SellTransaction {
  final int id;
  final String transactionDate;
  final String type;
  final int isDirectSale;
  final String invoiceNo;
  final String invoiceNoText;
  final String name;
  final String mobile;
  final String contactId;
  final int? cityId;
  final int? subCityId;
  final String? mainCity;
  final String? subCity;
  final String? supplierBusinessName;
  final String status;
  final String? paymentStatus;
  final String finalTotal;
  final String taxAmount;
  final String discountAmount;
  final String discountType;
  final String totalBeforeTax;
  final int rpRedeemed;
  final String rpRedeemedAmount;
  final int rpEarned;
  final int typesOfServiceId;
  final String shippingStatus;
  final int payTermNumber;
  final String payTermType;
  final String additionalNotes;
  final String staffNote;
  final String shippingDetails;
  final dynamic document;
  final dynamic shippingCustomField1;
  final dynamic shippingCustomField2;
  final dynamic shippingCustomField3;
  final dynamic shippingCustomField4;
  final dynamic shippingCustomField5;
  final dynamic customField1;
  final dynamic customField2;
  final dynamic customField3;
  final dynamic customField4;
  final String saleDate;
  final String addedBy;
  final dynamic totalPaid;
  final String businessLocation;
  final int returnExists;
  final dynamic returnPaid;
  final String amountReturn;
  final dynamic returnTransactionId;
  final dynamic typesOfServiceName;
  final String serviceCustomField1;
  final int totalItems;
  final String waiter;
  final dynamic tableName;
  final dynamic soQtyRemaining;
  final int isExport;
  final int location_id;
  final List<PaymentLine> paymentLines;

  SellTransaction({
    required this.id,
    required this.transactionDate,
    required this.type,
    required this.isDirectSale,
    required this.invoiceNo,
    required this.invoiceNoText,
    required this.name,
    required this.mobile,
    required this.contactId,
    required this.cityId,
    required this.subCityId,
    required this.mainCity,
    required this.subCity,
    required this.supplierBusinessName,
    required this.status,
    required this.paymentStatus,
    required this.finalTotal,
    required this.taxAmount,
    required this.discountAmount,
    required this.discountType,
    required this.totalBeforeTax,
    required this.rpRedeemed,
    required this.rpRedeemedAmount,
    required this.rpEarned,
    required this.typesOfServiceId,
    required this.shippingStatus,
    required this.payTermNumber,
    required this.payTermType,
    required this.additionalNotes,
    required this.staffNote,
    required this.shippingDetails,
    required this.document,
    required this.shippingCustomField1,
    required this.shippingCustomField2,
    required this.shippingCustomField3,
    required this.shippingCustomField4,
    required this.shippingCustomField5,
    required this.customField1,
    required this.customField2,
    required this.customField3,
    required this.customField4,
    required this.saleDate,
    required this.addedBy,
    required this.totalPaid,
    required this.businessLocation,
    required this.returnExists,
    required this.returnPaid,
    required this.amountReturn,
    required this.returnTransactionId,
    required this.typesOfServiceName,
    required this.serviceCustomField1,
    required this.totalItems,
    required this.waiter,
    required this.tableName,
    required this.soQtyRemaining,
    required this.isExport,
    required this.location_id,
    required this.paymentLines,
  });

  factory SellTransaction.fromJson(Map<String, dynamic> json) {
    return SellTransaction(
      location_id: json['location_id'] ?? 0,
      id: json['id'] ?? 0,
      transactionDate: json['transaction_date'] ?? '',
      type: json['type'] ?? '',
      isDirectSale: json['is_direct_sale'] ?? 0,
      invoiceNo: json['invoice_no'] ?? '',
      invoiceNoText: json['invoice_no_text'] ?? '',
      name: json['name'] ?? '',
      mobile: json['mobile'] ?? '',
      contactId: json['contact_id'] ?? '',
      cityId: json['city_id'],
      subCityId: json['sub_city_id'],
      mainCity: json['main_city'],
      subCity: json['sub_city'],
      supplierBusinessName: json['supplier_business_name'],
      status: json['status'] ?? '',
      paymentStatus: json['payment_status'],
      finalTotal: json['final_total'] ?? '',
      taxAmount: json['tax_amount'] ?? '',
      discountAmount: json['discount_amount'] ?? '',
      discountType: json['discount_type'] ?? '',
      totalBeforeTax: json['total_before_tax'] ?? '',
      rpRedeemed: json['rp_redeemed'] ?? 0,
      rpRedeemedAmount: json['rp_redeemed_amount'] ?? '',
      rpEarned: json['rp_earned'] ?? 0,
      typesOfServiceId: json['types_of_service_id'] ?? 0,
      shippingStatus: json['shipping_status'] ?? '',
      payTermNumber: json['pay_term_number'] ?? 0,
      payTermType: json['pay_term_type'] ?? '',
      additionalNotes: json['additional_notes'] ?? '',
      staffNote: json['staff_note'] ?? '',
      shippingDetails: json['shipping_details'] ?? '',
      document: json['document'],
      shippingCustomField1: json['shipping_custom_field_1'],
      shippingCustomField2: json['shipping_custom_field_2'],
      shippingCustomField3: json['shipping_custom_field_3'],
      shippingCustomField4: json['shipping_custom_field_4'],
      shippingCustomField5: json['shipping_custom_field_5'],
      customField1: json['custom_field_1'],
      customField2: json['custom_field_2'],
      customField3: json['custom_field_3'],
      customField4: json['custom_field_4'],
      saleDate: json['sale_date'] ?? '',
      addedBy: json['added_by'] ?? '',
      totalPaid: json['total_paid'],
      businessLocation: json['business_location'] ?? '',
      returnExists: json['return_exists'] ?? 0,
      returnPaid: json['return_paid'],
      amountReturn: json['amount_return'] ?? '',
      returnTransactionId: json['return_transaction_id'],
      typesOfServiceName: json['types_of_service_name'],
      serviceCustomField1: json['service_custom_field_1'] ?? '',
      totalItems: json['total_items'] ?? 0,
      waiter: json['waiter'] ?? '',
      tableName: json['table_name'],
      soQtyRemaining: json['so_qty_remaining'],
      isExport: json['is_export'] ?? 0,
      paymentLines: (json['payment_lines'] as List<dynamic>?)
              ?.map((line) => PaymentLine.fromJson(line))
              .toList() ??
          [],
    );
  }
}

class PaymentLine {
  final int id;
  final int transactionId;
  final int businessId;
  final int isReturn;
  final String amount;
  final String method;
  final String? paymentType;
  final String? transactionNo;
  final dynamic bulkReturnTransactionId;
  final String cardTransactionNumber;
  final String cardNumber;
  final String cardType;
  final String cardHolderName;
  final String cardMonth;
  final dynamic cardYear;
  final String cardSecurity;
  final String chequeNumber;
  final dynamic chequeRealized;
  final String chequePaidAmount;
  final String bankAccountNumber;
  final String paidOn;
  final int createdBy;
  final int paidThroughLink;
  final dynamic gateway;
  final int isAdvance;
  final int paymentFor;
  final dynamic parentId;
  final String note;
  final dynamic document;
  final String paymentRefNo;
  final int accountId;
  final dynamic chequeId;
  final String createdAt;
  final String updatedAt;


  PaymentLine({
    required this.id,
    required this.transactionId,
    required this.businessId,
    required this.isReturn,
    required this.amount,
    required this.method,
    required this.paymentType,
    required this.transactionNo,
    required this.bulkReturnTransactionId,
    required this.cardTransactionNumber,
    required this.cardNumber,
    required this.cardType,
    required this.cardHolderName,
    required this.cardMonth,
    required this.cardYear,
    required this.cardSecurity,
    required this.chequeNumber,
    required this.chequeRealized,
    required this.chequePaidAmount,
    required this.bankAccountNumber,
    required this.paidOn,
    required this.createdBy,
    required this.paidThroughLink,
    required this.gateway,
    required this.isAdvance,
    required this.paymentFor,
    required this.parentId,
    required this.note,
    required this.document,
    required this.paymentRefNo,
    required this.accountId,
    required this.chequeId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PaymentLine.fromJson(Map<String, dynamic> json) {
    return PaymentLine(
      id: json['id'] ?? 0,
      transactionId: json['transaction_id'] ?? 0,
      businessId: json['business_id'] ?? 0,
      isReturn: json['is_return'] ?? 0,
      amount: json['amount'] ?? '',
      method: json['method'] ?? '',
      paymentType: json['payment_type'],
      transactionNo: json['transaction_no'],
      bulkReturnTransactionId: json['bulk_return_transaction_id'],
      cardTransactionNumber: json['card_transaction_number'] ?? '',
      cardNumber: json['card_number'] ?? '',
      cardType: json['card_type'] ?? '',
      cardHolderName: json['card_holder_name'] ?? '',
      cardMonth: json['card_month'] ?? '',
      cardYear: json['card_year'],
      cardSecurity: json['card_security'] ?? '',
      chequeNumber: json['cheque_number'] ?? '',
      chequeRealized: json['cheque_realized'],
      chequePaidAmount: json['cheque_paid_amount'] ?? '',
      bankAccountNumber: json['bank_account_number'] ?? '',
      paidOn: json['paid_on'] ?? '',
      createdBy: json['created_by'] ?? 0,
      paidThroughLink: json['paid_through_link'] ?? 0,
      gateway: json['gateway'],
      isAdvance: json['is_advance'] ?? 0,
      paymentFor: json['payment_for'] ?? 0,
      parentId: json['parent_id'],
      note: json['note'] ?? '',
      document: json['document'],
      paymentRefNo: json['payment_ref_no'] ?? '',
      accountId: json['account_id'] ?? 0,
      chequeId: json['cheque_id'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
