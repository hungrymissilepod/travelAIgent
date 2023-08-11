import 'package:json_annotation/json_annotation.dart';

part 'exchange_rate_data_model.g.dart';

@JsonSerializable()
class ExchangeRateData {
  double beer;
  double dinner;
  double capuccino;
  double exchangeRate;

  /// Curreny code of country user is travelling from
  String fromCurrencyCode;

  /// Curreny code of country user is travelling to
  String toCurrencyCode;

  ExchangeRateData(
      this.beer, this.dinner, this.capuccino, this.exchangeRate, this.fromCurrencyCode, this.toCurrencyCode);

  factory ExchangeRateData.fromJson(Map<String, dynamic> json) => _$ExchangeRateDataFromJson(json);

  Map<String, dynamic> toJson() => _$ExchangeRateDataToJson(this);
}
