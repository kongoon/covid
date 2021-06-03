class CountryStats {
  String country;
  int cases;
  int todayCases;
  int deaths;
  int todayDeaths;
  int recovered;
  int active;
  int critical;
  double casesPerOneMillion;
  double deathsPerOneMillion;

  CountryStats(
      {
        this.country,
        this.cases,
        this.todayCases,
        this.deaths,
        this.todayDeaths,
        this.recovered,
        this.active,
        this.critical,
        this.casesPerOneMillion,
        this.deathsPerOneMillion
      });

  CountryStats.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    cases = json['cases'] ?? 0;
    todayCases = json['todayCases'] ?? 0;
    deaths = json['deaths'] ?? 0;
    todayDeaths = json['todayDeaths'] ?? 0;
    recovered = json['recovered'] ?? 0;
    active = json['active'] ?? 0;
    critical = json['critical'] ?? 0;
    casesPerOneMillion = (json['casesPerOneMillion'] ?? 0.0).toDouble();
    deathsPerOneMillion = (json['deathsPerOneMillion'] ?? 0.0).toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['cases'] = this.cases;
    data['todayCases'] = this.todayCases;
    data['deaths'] = this.deaths;
    data['todayDeaths'] = this.todayDeaths;
    data['recovered'] = this.recovered;
    data['active'] = this.active;
    data['critical'] = this.critical;
    data['casesPerOneMillion'] = this.casesPerOneMillion;
    data['deathsPerOneMillion'] = this.deathsPerOneMillion;
    return data;
  }
}

