import 'dart:convert';
import 'package:covid/models/country_stats.dart';
import 'package:covid/models/world_stats.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class CovidService {
  static Future<CountryStats> fetchCountryStats(String country) async {
    final endPoint = "https://api.coronastatistics.live/countries/" + country;
    final response = await http.get(endPoint);

    if (response.statusCode == HttpStatus.ok) {
      //log(response.body.toString());
      return CountryStats.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load data.");
    }
  }

  static Future<List<CountryStats>> fetchSummaryCountryStats() async {
    try {
      final endPoint = "https://api.coronastatistics.live/countries?sort=cases";
      final response = await http.get(endPoint);

      if (response.statusCode == HttpStatus.ok) {
        //log(response.body.toString());
        //return compute(parseCountryStats, response.body);
        List<CountryStats> list = await parseCountryStats(response.body);
        return list;
      } else {
        throw Exception("Failed to load data.");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<CountryStats> parseCountryStats(String response) {
    //log(response.toString());
    final parsed = json.decode(response).cast<Map<String, dynamic>>();
    //log(parsed.toString());
    return parsed.map<CountryStats>((json) => CountryStats.fromJson(json)).toList();
  }


  static String getFlagImage(String countryName) {
    String asset = "asset/flags";
    var countryCode;
    if (countryCode[countryName] == null) {
      asset = asset = "unknow.png";
    } else {
      asset = asset + countryCode[countryName].toLowerCase() + ".png";
    }
    return asset;
  }

  static Future<WorldStats> fetchWorldStats() async {
    final endPoint = "https://api.coronastatistics.live/all/";
    final response = await http.get(endPoint);

    if (response.statusCode == HttpStatus.ok) {
      //log(response.body.toString());
      return WorldStats.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load data.");
    }
  }
}