import 'package:covid/models/country_stats.dart';
import 'package:covid/services/covid_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class CountryPage extends StatefulWidget {
  CountryStats data;

  CountryPage({Key key, this.data}) : super(key: key);

  @override
  _CountryPageState createState() => _CountryPageState(this.data);
}

class _CountryPageState extends State<CountryPage> {
  final CountryStats data;
  Future<CountryStats> countryStats;
  _CountryPageState(this.data);

  final formater = NumberFormat();

  @override
  void initState() {
    CovidService.fetchCountryStats(data.country).then((stats){
      //log(stats.cases.toString());
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data.country.toString().toUpperCase(), style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w900), textAlign: TextAlign.center),
      ),
      backgroundColor: Colors.red,
      body: SafeArea(
        minimum: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Wrap(
                children: <Widget>[
                  Card(
                    color: Colors.orangeAccent,
                    child: Container(
                      width: (MediaQuery.of(context).size.width),
                      //height: 100.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ListTile(
                            leading: FaIcon(FontAwesomeIcons.virus, color: Colors.white, size: 70,),
                            title: Text((formater.format(data.cases != null ? data.cases.toInt() : 0)).toString(), style: TextStyle(fontSize: 50.0, color: Colors.white, fontWeight: FontWeight.w900)),
                            subtitle: Text("Infections " + " +" + (formater.format(data.todayCases != null ? data.todayCases.toInt() : 0)), style: TextStyle(fontSize: 20.0, color: Colors.white),),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Card(
                    color: Colors.yellow,
                    child: Container(
                      width: (MediaQuery.of(context).size.width * 0.5) - 16,
                      //height: 100.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ListTile(
                            leading: FaIcon(FontAwesomeIcons.procedures, color: Colors.white, size: 40,),
                            title: Text((formater.format(data.active != null ? data.active.toInt() : 0)).toString(), style: TextStyle(fontSize: 20.0, color: Colors.white)),
                            subtitle: Text("Active", style: TextStyle(fontSize: 16.0, color: Colors.white),),
                          ),

                        ],
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.orange,
                    child: Container(
                      width: (MediaQuery.of(context).size.width * 0.5) - 16,
                      //height: 100.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ListTile(
                            leading: FaIcon(FontAwesomeIcons.lungsVirus, color: Colors.white, size: 40,),
                            title: Text((formater.format(data.critical != null ? data.critical.toInt() : 0)).toString(), style: TextStyle(fontSize: 20.0, color: Colors.white)),
                            subtitle: Text("Criticals", style: TextStyle(fontSize: 16.0, color: Colors.white),),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.green,
                    child: Container(
                      width: (MediaQuery.of(context).size.width * 0.5) - 16,
                      //height: 100.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ListTile(
                            leading: FaIcon(FontAwesomeIcons.headSideMask, color: Colors.white, size: 40,),
                            title: Text((formater.format(data.recovered != null ? data.recovered.toInt() : 0)).toString(), style: TextStyle(fontSize: 20.0, color: Colors.white)),
                            subtitle: Text("Recovered", style: TextStyle(fontSize: 16.0, color: Colors.white),),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.redAccent,
                    child: Container(
                      width: (MediaQuery.of(context).size.width * 0.5) - 16,
                      //height: 100.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ListTile(
                            leading: FaIcon(FontAwesomeIcons.dizzy, color: Colors.white, size: 40,),
                            title: Text((formater.format(data.deaths != null ? data.deaths.toInt() : 0)).toString(), style: TextStyle(fontSize: 20.0, color: Colors.white)),
                            subtitle: Text("Deaths " + " +" + (formater.format(data.todayDeaths != null ? data.todayDeaths.toInt() : 0)), style: TextStyle(fontSize: 16.0, color: Colors.white),),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.lightBlue,
                    child: Container(
                      width: (MediaQuery.of(context).size.width * 0.5) - 16,
                      //height: 100.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ListTile(
                            leading: FaIcon(FontAwesomeIcons.virus, color: Colors.white, size: 40,),
                            title: Text((formater.format(data.casesPerOneMillion != null ? data.casesPerOneMillion.toInt() : 0)).toString(), style: TextStyle(fontSize: 20.0, color: Colors.white)),
                            subtitle: Text("Cases per milliion", style: TextStyle(fontSize: 16.0, color: Colors.white),),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.lightBlue,
                    child: Container(
                      width: (MediaQuery.of(context).size.width * 0.5) - 16,
                      //height: 100.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ListTile(
                            leading: FaIcon(FontAwesomeIcons.dizzy, color: Colors.white, size: 40,),
                            title: Text((formater.format(data.deathsPerOneMillion != null ? data.deathsPerOneMillion.toInt() : 0)).toString(), style: TextStyle(fontSize: 20.0, color: Colors.white)),
                            subtitle: Text("Death per milliion", style: TextStyle(fontSize: 16.0, color: Colors.white),),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
