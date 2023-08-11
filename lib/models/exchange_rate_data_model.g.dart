// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange_rate_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExchangeRateData _$ExchangeRateDataFromJson(Map<String, dynamic> json) =>
    ExchangeRateData(
      (json['beer'] as num).toDouble(),
      (json['dinner'] as num).toDouble(),
      (json['capuccino'] as num).toDouble(),
      (json['exchangeRate'] as num).toDouble(),
      json['fromCurrencyCode'] as String,
      json['toCurrencyCode'] as String,
    );

Map<String, dynamic> _$ExchangeRateDataToJson(ExchangeRateData instance) =>
    <String, dynamic>{
      'beer': instance.beer,
      'dinner': instance.dinner,
      'capuccino': instance.capuccino,
      'exchangeRate': instance.exchangeRate,
      'fromCurrencyCode': instance.fromCurrencyCode,
      'toCurrencyCode': instance.toCurrencyCode,
    };
