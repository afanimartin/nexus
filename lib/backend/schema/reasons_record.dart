import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'reasons_record.g.dart';

abstract class ReasonsRecord
    implements Built<ReasonsRecord, ReasonsRecordBuilder> {
  static Serializer<ReasonsRecord> get serializer => _$reasonsRecordSerializer;

  @nullable
  String get content;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(ReasonsRecordBuilder builder) =>
      builder..content = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('reasons');

  static Stream<ReasonsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<ReasonsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  ReasonsRecord._();
  factory ReasonsRecord([void Function(ReasonsRecordBuilder) updates]) =
      _$ReasonsRecord;

  static ReasonsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createReasonsRecordData({
  String content,
}) =>
    serializers.toFirestore(
        ReasonsRecord.serializer, ReasonsRecord((r) => r..content = content));
