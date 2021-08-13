import 'package:flutter/material.dart';

import 'main.dart';
import 'global.dart' as global;
import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class backFunction {

  //test strip ping to properly receive and parse info
  static Future<bool> pingStrip(String testip) async {
    final url = 'http://' + testip + '/pingtest';
    try {
      Response response = await Dio().get(url);
      final dynamic info = json.decode(response.data);
      print(response);
      print(info);
      print(json.decode(info['stripid']));
      //print(response['stripid']);
      //print(response.stripid);
      if (response.statusCode== 200) {
        global.tempstripid = json.decode(info['stripid']) as int;
        return true;
      }
      else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  //new strip call to api
  static void addStripApi () async {
    String stripname = global.stripname[global.numstrips - 1];
    String outletonename = global.outletname[global.numstrips - 1][0] as String;
    String outlettwoname = global.outletname[global.numstrips - 1][1] as String;
    String outletthreename = global.outletname[global.numstrips - 1][2] as String;
    String outletfourname = global.outletname[global.numstrips - 1][3] as String;
    int outletonestatus = global.outletstatus[global.numstrips - 1][0] as int;
    int outlettwostatus = global.outletstatus[global.numstrips - 1][1] as int;
    int outletthreestatus = global.outletstatus[global.numstrips - 1][2] as int;
    int outletfourstatus = global.outletstatus[global.numstrips - 1][3] as int;
    int outletonemode = global.outletmode[global.numstrips - 1][0] as int;
    int outlettwomode = global.outletmode[global.numstrips - 1][1] as int;
    int outletthreemode = global.outletmode[global.numstrips - 1][2] as int;
    int outletfourmode = global.outletmode[global.numstrips - 1][3] as int;
    String outletonetimeon  = global.outlettimeon[global.numstrips - 1][0] as String;
    String outlettwotimeon = global.outlettimeon[global.numstrips - 1][1] as String;
    String outletthreetimeon = global.outlettimeon[global.numstrips - 1][2] as String;
    String outletfourtimeon = global.outlettimeon[global.numstrips - 1][3] as String;
    String outletonetimeoff  = global.outlettimeoff[global.numstrips - 1][0] as String;
    String outlettwotimeoff = global.outlettimeoff[global.numstrips - 1][1] as String;
    String outletthreetimeoff = global.outlettimeoff[global.numstrips - 1][2] as String;
    String outletfourtimeoff = global.outlettimeoff[global.numstrips - 1][3] as String;
    int numpowered = global.numpowered[global.numstrips - 1];
    String uniqueid = global.uniqueid;
    String userid = global.userid;
    int newstrip = 1;
    int stripid = global.stripid[global.numstrips - 1];
    String stripip = global.stripip[global.numstrips - 1];

    var params = {
      "body":
      "{\"userid\": \"$userid\", \"uniqueid\": \"$uniqueid\",  \"newstrip\": \"$newstrip\",  \"stripid\": \"$stripid\",  \"stripname\": \"$stripname\",  \"outletonename\": \"$outletonename\",  \"outlettwoname\": \"$outlettwoname\", \"outletthreename\": \"$outletthreename\", \"outletfourname\": \"$outletfourname\", \"outletonestatus\": \"$outletonestatus\", \"outlettwostatus\": \"$outlettwostatus\", \"outletthreestatus\": \"$outletthreestatus\", \"outletfourstatus\": \"$outletfourstatus\", \"outletonemode\": \"$outletonemode\", \"outlettwomode\": \"$outlettwomode\", \"outletthreemode\": \"$outletthreemode\", \"outletfourmode\": \"$outletfourmode\", \"outletonetimeon\": \"$outletonetimeon\", \"outlettwotimeon\": \"$outlettwotimeon\", \"outletthreetimeon\": \"$outletthreetimeon\", \"outletfourtimeon\": \"$outletfourtimeon\", \"outletonetimeoff\": \"$outletonetimeoff\", \"outlettwotimeoff\": \"$outlettwotimeoff\", \"outletthreetimeoff\": \"$outletthreetimeoff\", \"outletfourtimeoff\": \"$outletfourtimeoff\", \"stripip\": \"$stripip\", \"numpowered\": \"$numpowered\"}"
    };

    final response =
        await http.post('https://s4n0sm7t6b.execute-api.us-west-2.amazonaws.com/live/placestripinfo',
        body: jsonEncode(params)
    );
    print(response.body);

    return;
  }

  //remove strip call to api
  static void removeStripApi (int index) async {
    var params = {
      "body": "{\"stripid\": \"$index\"}"
    };

    final response =
    await http.post('https://kq2o500623.execute-api.us-west-2.amazonaws.com/live/removestrip',
        body: jsonEncode(params)
    );

    return;
  }

  //update strip info call to api
  static void updateStrip (int index) async {

    String stripname = global.stripname[index];
    String outletonename = global.outletname[index][0] as String;
    String outlettwoname = global.outletname[index][1] as String;
    String outletthreename = global.outletname[index][2] as String;
    String outletfourname = global.outletname[index][3] as String;
    int outletonestatus = global.outletstatus[index][0] as int;
    print(outletonestatus);
    int outlettwostatus = global.outletstatus[index][1] as int;
    int outletthreestatus = global.outletstatus[index][2] as int;
    int outletfourstatus = global.outletstatus[index][3] as int;
    int outletonemode = global.outletmode[index][0] as int;
    int outlettwomode = global.outletmode[index][1] as int;
    int outletthreemode = global.outletmode[index][2] as int;
    int outletfourmode = global.outletmode[index][3] as int;
    String outletonetimeon  = global.outlettimeon[index][0] as String;
    String outlettwotimeon = global.outlettimeon[index][1] as String;
    String outletthreetimeon = global.outlettimeon[index][2] as String;
    String outletfourtimeon = global.outlettimeon[index][3] as String;
    String outletonetimeoff  = global.outlettimeoff[index][0] as String;
    String outlettwotimeoff = global.outlettimeoff[index][1] as String;
    String outletthreetimeoff = global.outlettimeoff[index][2] as String;
    String outletfourtimeoff = global.outlettimeoff[index][3] as String;
    int numpowered = global.numpowered[index];
    String uniqueid = global.uniqueid;
    String userid = global.userid;
    int newstrip = 0;
    int stripid = global.stripid[index];
    String stripip = global.stripip[index];

    var params = {
      "body":
      "{\"userid\": \"$userid\", \"uniqueid\": \"$uniqueid\",  \"newstrip\": \"$newstrip\",  \"stripid\": \"$stripid\",  \"stripname\": \"$stripname\",  \"outletonename\": \"$outletonename\",  \"outlettwoname\": \"$outlettwoname\", \"outletthreename\": \"$outletthreename\", \"outletfourname\": \"$outletfourname\", \"outletonestatus\": \"$outletonestatus\", \"outlettwostatus\": \"$outlettwostatus\", \"outletthreestatus\": \"$outletthreestatus\", \"outletfourstatus\": \"$outletfourstatus\", \"outletonemode\": \"$outletonemode\", \"outlettwomode\": \"$outlettwomode\", \"outletthreemode\": \"$outletthreemode\", \"outletfourmode\": \"$outletfourmode\", \"outletonetimeon\": \"$outletonetimeon\", \"outlettwotimeon\": \"$outlettwotimeon\", \"outletthreetimeon\": \"$outletthreetimeon\", \"outletfourtimeon\": \"$outletfourtimeon\", \"outletonetimeoff\": \"$outletonetimeoff\", \"outlettwotimeoff\": \"$outlettwotimeoff\", \"outletthreetimeoff\": \"$outletthreetimeoff\", \"outletfourtimeoff\": \"$outletfourtimeoff\", \"stripip\": \"$stripip\", \"numpowered\": \"$numpowered\"}"
    };

    final response =
    await http.post('https://s4n0sm7t6b.execute-api.us-west-2.amazonaws.com/live/placestripinfo',
        body: jsonEncode(params)
    );
    print(response.body);

    return;
  }

  //update num strips user
  static void updateNumStrips () async {
    String userid = global.userid;
    String uniqueid = global.uniqueid;
    int numstrips = global.numstrips;

    var params = {
      "body": "{\"userid\": \"$userid\", \"uniqueid\": \"$uniqueid\", \"numstrips\": \"$numstrips\"}"
    };

    final response =
    await http.post('https://0tfc9ve92m.execute-api.us-west-2.amazonaws.com/live/updatestrips',
        body: jsonEncode(params)
    );
    print(response.body);

    return;
  }

  //calls new strip, update num strips
  static void addStrip (String ip, int id) {
    global.numstrips = global.numstrips + 1;
    global.stripid[global.numstrips - 1] = id;
    global.stripip[global.numstrips - 1] = ip;
    global.stripname[global.numstrips - 1] = 'Smart Strip ' + global.numstrips.toString();
    global.numpowered[global.numstrips - 1] = 4;

    for (int i = 0; i < 4; i++) {
      global.outletname[global.numstrips - 1][i] = i.toString();
      global.outletstatus[global.numstrips - 1][i] = 1;
      global.outletmode[global.numstrips - 1][i] = 1;
      global.outlettimeon[global.numstrips - 1][i] = "n";
      global.outlettimeoff[global.numstrips - 1][i] = "n";

      //power info
      /*
      global.outletpowerusehour[global.numstrips - 1][i] = 0.0;
      global.outletpoweruseday[global.numstrips - 1][i] = 0.0;
      global.outletpoweruseweek[global.numstrips - 1][i] = 0.0;
       */
    }

    addStripApi();
    updateNumStrips();
  }

  //calls remove strip, update num strips
  static void removeStrip (int index) {
    global.numstrips = global.numstrips - 1;
    int tempid = global.stripid[index];

    if (global.numstrips == 0) {
      global.stripip[index] = '';
      global.stripname[index] = '';
      global.numpowered[index] = 0;
      global.stripid[index] = 0;

      for (int i = 0; i < 4; i++) {
        global.outletname[index][i] = i.toString();
        global.outletstatus[index][i] = 0;
        global.outletmode[index][i] = 1;
        global.outlettimeon[index][i] = "n";
        global.outlettimeoff[index][i] =  "n";
      }
    }

    //if there are still power strips, transfer proceedings ones back a space
    if (global.numstrips != 0) {

      for (int i = 0; i < global.numstrips; i++) {
        if ((i+1) == index) {
          continue;
        }
        global.stripip[i] = global.stripip[i+1];
        global.stripname[i] = global.stripname[i+1];
        global.numpowered[i] = global.numpowered[i+1];
        global.stripid[i] = global.stripid[i+1];

        for (int j = 0; j < 4; j++) {
          global.outletname[i][j] = global.outletname[i+1][j];
          global.outletstatus[i][j] = global.outletstatus[i+1][j];
          global.outletmode[i][j] = global.outletmode[i+1][j];
          global.outlettimeon[i][j] = global.outlettimeon[i+1][j];
          global.outlettimeoff[i][j] = global.outlettimeoff[i+1][j];
        }
      }

      global.stripip[global.numstrips+1] = '';
      global.stripname[global.numstrips+1] = '';
      global.numpowered[global.numstrips+1] = 0;
      global.stripid[global.numstrips+1] = 0;

      for (int i = 0; i < 4; i++) {
        global.outletname[global.numstrips+1][i] = i.toString();
        global.outletstatus[global.numstrips+1][i] = 0;
        global.outletmode[global.numstrips+1][i] = 1;
        global.outlettimeon[global.numstrips+1][i] = "n";
        global.outlettimeoff[global.numstrips+1][i] =  "n";
      }
    }

    removeStripApi(tempid);
    updateNumStrips();
  }

  //calls update
  static void changeStripName(int index, String name) {
    global.stripname[index] = name;
    updateStrip(index);
  }

  //calls update
  static void changeOutletName(int index, String name) {
    global.outletname[index][global.currentoutlet] = name;
    updateStrip(index);
  }

  //calls update
  static Future<void> turnOutletOn(int index) async {
    String currentip = global.stripip[global.currentstrip];
    try {
      if (index == 0) {Response response = await Dio().get('http://' + currentip + '/switchoneon');}
      if (index == 1) {Response response = await Dio().get('http://' + currentip + '/switchtwoon');}
      if (index == 2) {Response response = await Dio().get('http://' + currentip + '/switchthreeon');}
      if (index == 3) {Response response = await Dio().get('http://' + currentip + '/switchfouron');}

      global.outletstatus[global.currentstrip][index] = 1;
      global.numpowered[global.currentstrip]++;
      updateStrip(global.currentstrip);
    } catch (e) {
      print(e);
    }
  }

  //calls update
  static Future<void> turnOutletOff(int index) async {
    String currentip = global.stripip[global.currentstrip];
    try {
      if (index == 0) {Response response = await Dio().get('http://' + currentip + '/switchoneoff');}
      if (index == 1) {Response response = await Dio().get('http://' + currentip + '/switchtwooff');}
      if (index == 2) {Response response = await Dio().get('http://' + currentip + '/switchthreeoff');}
      if (index == 3) {Response response = await Dio().get('http://' + currentip + '/switchfouroff');}

      global.numpowered[global.currentstrip]--;
      global.outletstatus[global.currentstrip][index] = 0;
      updateStrip(global.currentstrip);
    } catch (e) {
      print(e);
    }
  }

  //set outlet time on
  static Future<void> setTimeOn(int index, String time) async {
    String currentip = global.stripip[global.currentstrip];
    //set globals
    global.outlettimeon[global.currentstrip][index] = time;
    global.outletmode[global.currentstrip][index] = 2;

    //send to mcu
    try {
      if (index == 0) {Response response = await Dio().post('http://' + currentip + '/timeoneon', data: time);}
      if (index == 1) {Response response = await Dio().post('http://' + currentip + '/timetwoon', data: time);}
      if (index == 2) {Response response = await Dio().post('http://' + currentip + '/timethreeon', data: time);}
      if (index == 3) {Response response = await Dio().post('http://' + currentip + '/timefouron', data: time);}
      Response response = await Dio().get('http://' + currentip + '/timedmode');
    } catch (e) {
      print(e);
    }

    //call update
    updateStrip(global.currentstrip);
  }

  //set outlet timee off
  static Future<void> setTimeOff(int index, String time) async {
    String currentip = global.stripip[global.currentstrip];
    //set globals
    global.outlettimeoff[global.currentstrip][index] = time;
    global.outletmode[global.currentstrip][index] = 2;

    //send to mcu
    try {
      if (index == 0) {Response response = await Dio().post('http://' + currentip + '/timeoneoff', data: time);}
      if (index == 1) {Response response = await Dio().post('http://' + currentip + '/timetwooff', data: time);}
      if (index == 2) {Response response = await Dio().post('http://' + currentip + '/timethreeoff', data: time);}
      if (index == 3) {Response response = await Dio().post('http://' + currentip + '/timefouroff', data: time);}
      Response response = await Dio().get('http://' + currentip + '/timedmode');
    } catch (e) {
      print(e);
    }

    //call update
    updateStrip(global.currentstrip);
  }

  //send uniqueid to mcu
  static Future<void> sendUniqueId(int stripid) async {
    String currentip = global.stripip[stripid];
    String uniqueid = global.uniqueid;
    try {
      Response response = await Dio().post('http://' + currentip + '/uniqueid', data: uniqueid);
    } catch (e) {
      print(e);
    }
  }

  //send userid to mcu
  static Future<void> sendUserId(int stripid) async {
    String currentip = global.stripip[stripid];
    String userid = global.userid;
     try {
       Response response = await Dio().post('http://' + currentip + '/userid', data: userid);
     } catch (e) {
       print(e);
     }
  }

  static Future<int> changeStandardMode () async {
    String currentip = global.stripip[global.currentstrip];
    try {
      Response response = await Dio().get('http://' + currentip + '/standardmode');
    } catch (e) {
      print(e);
    }

    //call update
    updateStrip(global.currentstrip);
  }

  //verifies user login
  static Future<int> verifyUserLogin(String username, String password) async {
    var params = {
      "body":
      "{\"username\": \"$username\", \"pass\": \"$password\",  \"staylog\": \"0\"}"
    };

    final response =
    await http.post('https://4dukp9l38h.execute-api.us-west-2.amazonaws.com/live/verifyuser',
       body: jsonEncode(params)
    );
    final dynamic body = json.decode(response.body);
    final dynamic bodytwo = body['body'];
    final dynamic finalbody = json.decode(bodytwo);

    //failure, returns to main and asks for re-entry
    if (body['statusCode'] == 401 || body['statusCode'] == 402) {
      return 0;
    }

    //success, updates values, returns to main to update screen
    if (body['statusCode'] == 200) {
      global.uniqueid = finalbody['uniqueid'] as String;
      global.userid = finalbody['userid'] as String;
      global.numstrips = int.parse(finalbody['numstrips'] as String);
      //global.staylogged = 1;

      //get strip ids
      var tempuserid = global.userid;
      var tempnumstrips = global.numstrips;
      params = {
        "body":
        "{\"userid\": \"$tempuserid\", \"numstrips\": \"$tempnumstrips\"}"
      };
      final stripids =
      await http.post('https://6cojg59o19.execute-api.us-west-2.amazonaws.com/live/getstripid',
          body: jsonEncode(params)
      );
      final dynamic idbody = json.decode(stripids.body);
      final dynamic idbodytwo = idbody['body'];
      final dynamic idfinalbody = json.decode(idbodytwo);
      //failure, unable to access database
      if (idbody['statusCode'] == 401) {
        return 2;
      }

      for (int i = 0; i < tempnumstrips; i++) {
        global.stripid[i] = int.parse(idfinalbody['strip'+(i+1).toString()+'id'] as String);
      }

      //update unique ids in tables
      var tempuniqueid = global.uniqueid;
      var tempstripid = 0;
      for (int i = 0; i < tempnumstrips; i++) {
        tempstripid = global.stripid[i];
        params = {
          "body":
          "{\"stripid\": \"$tempstripid\", \"uniqueid\": \"$tempuniqueid\"}"
        };
        final updatestrip =
        await http.post('https://u4tkcj9hsc.execute-api.us-west-2.amazonaws.com/live/updatetableid',
            body: jsonEncode(params)
        );
      }

      //get strip info
      for (int i = 0; i < tempnumstrips; i++) {
        tempstripid = global.stripid[i];
        params = {
          "body":
          "{\"stripid\": \"$tempstripid\", \"uniqueid\": \"$tempuniqueid\", \"userid\": \"$tempuserid\"}"
        };
        var stripinfo =
        await http.post('https://v8kf25t0t8.execute-api.us-west-2.amazonaws.com/live/getstripinfo',
            body: jsonEncode(params)
        );
        dynamic stripbody = json.decode(stripinfo.body);
        dynamic stripbodytwo = stripbody['body'];
        dynamic stripfinalbody = json.decode(stripbodytwo);

        if (stripbody['statusCode'] == 401) {
          return 2;
        }

        global.stripname[i] = stripfinalbody['stripname'] as String;
        global.stripip[i] = stripfinalbody['stripip'] as String;
        global.numpowered[i] = int.parse(stripfinalbody['numpowered'] as String);

        for (int y = 0; y < 4; y++) {
          global.outletname[i][y] = stripfinalbody['outlet'+(y+1).toString()+"name"] as String;
          global.outletstatus[i][y] = int.parse(stripfinalbody['outlet'+(y+1).toString()+"status"] as String); //int
          global.outletmode[i][y] = int.parse(stripfinalbody['outlet'+(y+1).toString()+"mode"] as String); //int
          global.outlettimeon[i][y] = stripfinalbody['outlet'+(y+1).toString()+"timeon"] as String; //int
          global.outlettimeoff[i][y] = stripfinalbody['outlet'+(y+1).toString()+"timeoff"] as String; //int
        }

        //send info to strip
        sendUniqueId(i);
        sendUserId(i);
      }

      //wifi check, return code for success with conditions

      //return verification success
      return 1;
    }
  }

  //create user
  static Future<int> createUser(String username, String password) async {
    var params = {
      "body":
      "{\"username\": \"$username\", \"pass\": \"$password\",  \"staylog\": \"0\"}"
    };

    final response =
    await http.post('https://0bu2mg2ewg.execute-api.us-west-2.amazonaws.com/live/createuser',
        body: jsonEncode(params)
    );
    final dynamic body = json.decode(response.body);
    final dynamic bodytwo = body['body'];
    final dynamic finalbody = json.decode(bodytwo);

    //failure, returns to main and asks for re-entry
    if (body['statusCode'] == 401 || body['statusCode'] == 402) {
      return 0;
    }

    //success, updates values, returns to main to update screen
    if (body['statusCode'] == 200) {
      global.uniqueid = finalbody['uniqueid'] as String;
      global.userid = finalbody['userid'] as String;
      global.numstrips = int.parse(finalbody['numstrips'] as String);
    }

    return 1;
  }

  //fetch power usage info kwh
  static Future<int> getPowerInfo() async {
    String uniqueid = global.uniqueid;
    int stripid = global.stripid[global.currentstrip];

    var params = {
      "body":
          "{\"stripid\": \"$stripid\", \"uniqueid\": \"$uniqueid\"}"
    };

    final response =
    await http.post('https://aza6kvwbc1.execute-api.us-west-2.amazonaws.com/live/getkwh',
        body: jsonEncode(params)
    );
    dynamic stripbody = json.decode(response.body);
    dynamic stripbodytwo = stripbody['body'];
    dynamic stripfinalbody = json.decode(stripbodytwo);

    global.kwhtotal[global.currentstrip][0] = stripfinalbody['kwhtotal1'] as String;
    global.kwhtotal[global.currentstrip][1] = stripfinalbody['kwhtotal2'] as String;
    global.kwhtotal[global.currentstrip][2] = stripfinalbody['kwhtotal3'] as String;
    global.kwhtotal[global.currentstrip][3] = stripfinalbody['kwhtotal4'] as String;

    global.kwhavg[global.currentstrip][0] = stripfinalbody['kwhavg1'] as String;
    global.kwhavg[global.currentstrip][1] = stripfinalbody['kwhavg2'] as String;
    global.kwhavg[global.currentstrip][2] = stripfinalbody['kwhavg3'] as String;
    global.kwhavg[global.currentstrip][3] = stripfinalbody['kwhavg4'] as String;

    return 1;
  }
}