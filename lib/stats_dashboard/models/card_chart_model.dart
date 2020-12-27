
import 'dart:convert';

CardChartInfo cardChartInfoFromJson(String str) => CardChartInfo.fromJson(json.decode(str));

String cardChartInfoToJson(CardChartInfo data) => json.encode(data.toJson());

class CardChartInfo {
    CardChartInfo({
        this.cardData,
    });

    String cardData;

    factory CardChartInfo.fromJson(Map<String, dynamic> json) => CardChartInfo(
        cardData: json['cardData'],
    );

    Map<String, dynamic> toJson() => {
        'cardData': cardData,
    };
}
