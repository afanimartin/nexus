import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'loan_requests_record.g.dart';

abstract class LoanRequestsRecord
    implements Built<LoanRequestsRecord, LoanRequestsRecordBuilder> {
  static Serializer<LoanRequestsRecord> get serializer =>
      _$loanRequestsRecordSerializer;

  @nullable
  double get amount;

  @nullable
  @BuiltValueField(wireName: 'date_requested')
  DateTime get dateRequested;

  @nullable
  @BuiltValueField(wireName: 'when_to_pay')
  DateTime get whenToPay;

  @nullable
  DocumentReference get reason;

  @nullable
  @BuiltValueField(wireName: 'requested_by')
  DocumentReference get requestedBy;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(LoanRequestsRecordBuilder builder) =>
      builder..amount = 0.0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('loan_requests');

  static Stream<LoanRequestsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<LoanRequestsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then(
          (s) => serializers.deserializeWith(serializer, serializedData(s)));

  LoanRequestsRecord._();
  factory LoanRequestsRecord(
          [void Function(LoanRequestsRecordBuilder) updates]) =
      _$LoanRequestsRecord;

  static LoanRequestsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createLoanRequestsRecordData({
  double amount,
  DateTime dateRequested,
  DateTime whenToPay,
  DocumentReference reason,
  DocumentReference requestedBy,
}) =>
    serializers.toFirestore(
        LoanRequestsRecord.serializer,
        LoanRequestsRecord((l) => l
          ..amount = amount
          ..dateRequested = dateRequested
          ..whenToPay = whenToPay
          ..reason = reason
          ..requestedBy = requestedBy));
