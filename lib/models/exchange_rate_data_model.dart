class ExchangeRateData {
  double beer;
  double dinner;
  double capuccino;
  double exchangeRate;

  /// Curreny code of country user is travelling from
  String fromCurrencyCode;

  /// Curreny code of country user is travelling to
  String toCurrencyCode;

  ExchangeRateData(this.beer, this.dinner, this.capuccino, this.exchangeRate,
      this.fromCurrencyCode, this.toCurrencyCode);
}
