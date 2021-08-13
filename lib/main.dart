import 'package:flutter/material.dart';
import 'global.dart' as global;
import 'backFunction.dart';
import 'package:wifi/wifi.dart';
import 'package:ping_discover_network/ping_discover_network.dart';
import 'package:date_format/date_format.dart';

void main() {
  //check if user stays logged in

  //if not, send to login page
  runApp(MaterialApp(
    title: 'Smart Strip Management',
    home: LoginScreen(),
  ));

  //if yes, send into account overview with strip management

}

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  String username = "username";
  String password = "password";
  String verifypassword = "verify password";
  int page = 0;
  int loginerr = 0;
  int passcreateerr = 0;
  int usercreateerr = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            SizedBox(
              height: 50,
            ),

            //Top Logo
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Text(
                  'SmartStrip Connect',
                  style: TextStyle(
                      color: Colors.blue[800],
                      fontSize: 40
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 130,
            ),

            //username field
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),

              child: TextField(
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                  ),
                  onChanged: (value) {
                    setState(() {
                      username = value;
                    });
                  }
              ),
            ),

            //password field
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  }
              ),
            ),

            //verify password field for create
            if (page == 1) Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirm Password',
                  ),
                  onChanged: (value) {
                    setState(() {
                      verifypassword = value;
                    });
                  }
              ),
            ),

            SizedBox(
              height: 20,
            ),

            // login button
            if (page == 0) Container (
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue[800],
                  borderRadius: BorderRadius.circular(20)
              ),
              child: FlatButton(
                onPressed: () {
                  //back function for verifying user
                  backFunction.verifyUserLogin(username, password).then((data){
                    if (data == 0) {
                      setState(() {
                        loginerr = 1;
                      });
                    }

                    if (data == 1) {
                      //login success
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SmartDevices())
                      );

                      //other condition errors

                    }
                  });
                },
                child: Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.white, fontSize: 25
                  ),
                ),
              ),
            ),

            // create button
            if (page == 1) Container (
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue[800],
                  borderRadius: BorderRadius.circular(20)
              ),
              child: FlatButton(
                onPressed: () {
                  //check password match
                  if (password != verifypassword) {
                    setState(() {
                      passcreateerr = 1;
                    });
                  }
                  //attempt account creation
                  backFunction.createUser(username, password).then((data){
                    if (data == 0) {
                      setState(() {
                        usercreateerr = 1;
                      });
                    }

                    if (data == 1) {
                      //login success
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SmartDevices())
                      );
                    }
                  });
                },
                child: Text(
                  'Create Account',
                  style: TextStyle(
                      color: Colors.white, fontSize: 25
                  ),
                ),
              ),
            ),

            //login error
            if (loginerr == 1) Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Center(
                child: Text(
                  'Error: Incorrect username/password combination',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 15
                  ),
                ),
              ),
            ),

            //createpass error
            if (passcreateerr == 1) Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Center(
                child: Text(
                  'Error: Passwords do not match',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 15
                  ),
                ),
              ),
            ),

            //create user error
              if (usercreateerr == 1) Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Center(
                child: Text(
                  'Error: Username already in use',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 15
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 130,
            ),

            //create account text button
            if (page == 0) FlatButton(
              onPressed: (){
                //push to create account screen
                setState(() {
                  page = 1;
                  passcreateerr = 0;
                  usercreateerr = 0;
                  loginerr = 0;
                });
              },
              child: Text(
                'Create Account',
                style: TextStyle(
                    color: Colors.blue[800],
                    fontSize: 15
                ),
              ),
            ),

            //login account text button
            if (page == 1) FlatButton(
              onPressed: (){
                //push to create account screen
                setState(() {
                  page = 0;
                  passcreateerr = 0;
                  usercreateerr = 0;
                  loginerr = 0;
                });
              },
              child: Text(
                'Login',
                style: TextStyle(
                    color: Colors.blue[800],
                    fontSize: 15
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StripEditPop {
  static const String edit = 'Edit Smart Strip Name';
  static const String manage = 'Manage Smart Strip';
  static const String remove = 'Remove';

  static const List<String> choices = <String>[
    manage,
    edit,
    remove
  ];
}

class OutletEditPopOne {
  static const String editname = 'Edit Outlet Name';
  static const String switchoutleton = 'Turn Outlet On';
  static const String outletmode = 'Change Outlet Operating Mode';
  static const String power = 'View Power Usage Info';

  static const List<String> choices = <String>[
    switchoutleton,
    outletmode,
    power,
    editname
  ];
}

class OutletEditPopTwo {
  static const String editname = 'Edit Outlet Name';
  static const String switchoutletoff = 'Turn Outlet Off';
  static const String outletmode = 'Change Outlet Operating Mode';
  static const String power = 'View Power Usage Info';

  static const List<String> choices = <String>[
    switchoutletoff,
    outletmode,
    power,
    editname
  ];
}

class OutletChange {
  static const String save = 'Save Outlet Changes';
  static const String exit = 'Exit Without Saving';

  static const List<String> choices = <String>[
    save,
    exit
  ];
}

class PingStripSearch {
  static const String pair = 'Attempt Device Pairing';

  static const List<String> choices = <String>[
    pair
  ];
}

class SmartDevices extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    /*
  if (global.appon == 0){
    initialize();
    global.appon = 1;
  }
     */

    return Scaffold(

      appBar: AppBar(
        title: Text('Smart Strip Devices'),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
      ),

      body: ListView.builder(
        itemCount: global.numstrips,
        itemBuilder: (context, index){
          return Card(
            child: ListTile(
              title: Text(global.stripname[index]),
              subtitle: Text('Powered Devices: ' + global.numpowered[index].toString()),
              trailing: Column(
                children: <Widget>[
                  PopupMenuButton<String>(
                    onSelected: (choice) => choiceAction(choice, context, index),
                    itemBuilder: (BuildContext context) {
                      return StripEditPop.choices.map((String choice){
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                  )
                ],
              ),
            )
          );
        }
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Application Options'),
              decoration: BoxDecoration(
                color: Colors.blue[800],
              ),
            ),
            Container(
              decoration: BoxDecoration (
                color: Colors.black26,
              ),
              child: ListTile(
                title: Text('Smart Strip Devices'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            ListTile(
              title: Text('Add Smart Strip'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddStrip())
                );
              },
            ),
            ListTile(
              title: Text('About'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => About())
                );
              },
            ),
          ],
        ),
      ),

    );
  }

  void choiceAction(String choice, BuildContext context, int index) {
    if (choice == StripEditPop.manage) {
      global.currentstrip = index;
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => stripView())
      );
    }
    if (choice == StripEditPop.remove) {
      backFunction.removeStrip(index);
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SmartDevices())
      );
    }
    if (choice == StripEditPop.edit) {
      global.currentstrip = index;
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => changeStripName())
      );
    }
  }
}

class changeStripName extends StatefulWidget {
  @override
  ChangeStripName createState() => ChangeStripName();
}

class ChangeStripName extends State<changeStripName> {
  String text = global.stripname[global.currentstrip];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text('Edit Smart Strip Name'),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          TextField(
            obscureText: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: text,
            ),
            onChanged: (value) {
              setState(() {
                text = value;
              });
            }
          ),
          FlatButton(
            onPressed: () {
              backFunction.changeStripName(global.currentstrip, text);
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SmartDevices())
              );
            },
            color: Colors.blue[800],
            child: Text('Save'),
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          ),
        ]
      ),

    );
  }
}

class AddStrip extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text('Add Smart Strip'),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
              child: Text(
                'Click below to search for available Smart Strip devices',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.grey,
                ),
              )
          ),
          FlatButton(
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StripSearch())
                );
              },
              color: Colors.blue[800],
              child: Text('Search'),
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0)
          ),
      ]
    ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Application Options'),
              decoration: BoxDecoration(
                color: Colors.blue[800],
              ),
            ),
            ListTile(
              title: Text('Smart Strip Devices'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SmartDevices())
                );
              },
            ),
            Container(
              decoration: BoxDecoration (
                color: Colors.black26,
              ),
              child: ListTile(
                title: Text('Add Smart Strip'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            ListTile(
              title: Text('About'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => About())
                );
              },
            ),
          ],
        ),
      ),

    );
  }
}

class StripSearch extends StatefulWidget {
  @override
  SearchState createState() => SearchState();
}

class SearchState extends State<StripSearch> {
  int searchcomp = 0;
  List<String> iplist = [""];
  int listplace = 0;

  @override initState() {
    super.initState();
    if (searchcomp == 0) {
      //search and retreive ip addresses
      searchip().then((List<String> iplisttemp) {
        iplist = iplisttemp;
        if (iplist.length == 0){
          setState(() {
            searchcomp = 1;
            iplist = iplist;
            listplace = 0;
          });
        }
        else {
          setState(() {
            searchcomp = 2;
            iplist = iplist;
            listplace = 0;
          });
        }
      });
    }

    if (searchcomp == 3) {

    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue[800],
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[

          if (searchcomp == 0) Container(
              child: Text(
                '     Searching for available network devices..',
                textAlign: TextAlign.center,
                style: TextStyle(
                fontSize: 20.0,
                color: Colors.grey,
              ),
            )
          ),
          if (searchcomp == 0) FlatButton(
            onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddStrip())
              );
            },
            color: Colors.blue[800],
            child: Text('Cancel'),
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0)
          ),

          if (searchcomp == 1) Container(
              child: Text(
                '     No network devices found. Please check that mobile device is present on the same wifi network as the Smart Strip and retry search',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.grey,
                ),
              )
          ),
          if (searchcomp == 1)  FlatButton(
              onPressed: (){
                setState(() {
                  searchcomp = 0;
                  iplist = [""];
                });
              },
              color: Colors.blue[800],
              child: Text('Retry search'),
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0)
          ),

          if (searchcomp == 2)ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: iplist.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(iplist[index]),
                    trailing: Column(
                      children: <Widget>[
                        PopupMenuButton<String>(
                          onSelected: (choice) {
                            backFunction.pingStrip(iplist[index]).then((bool result) {
                              if (result) {
                                // successful ping, pair with strip
                                setState(() {
                                  searchcomp = 5;
                                  iplist = iplist;
                                  listplace = index;
                                });
                              }
                              else {
                                //incorrect device, remove ip, back to list for trying with new ip
                                iplist.removeAt(index);
                                setState(() {
                                  searchcomp = 4;
                                  iplist = iplist;
                                  listplace = 0;
                                });
                              }
                            });
                          },
                          itemBuilder: (BuildContext context) {
                            return PingStripSearch.choices.map((String choice) {
                              return PopupMenuItem<String>(
                                value: choice,
                                child: Text(choice),
                              );
                            }).toList();
                          },
                        )
                      ],
                    ),
                  ),
                );
              }
          ),

          if (searchcomp == 3) Container (
              child: Text(
                '     Attempting to pair with network device...',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.grey,
                ),
              )
          ),

          if (searchcomp == 4) Container (
              child: Text(
                '     Pairing not successful. Please try a different device',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.grey,
                ),
              )
          ),
          if (searchcomp == 4) FlatButton (
              onPressed: (){
                setState(() {
                  searchcomp = 2;
                  iplist = iplist;
                  listplace = 0;
                });
              },
              color: Colors.blue[800],
              child: Text('Try different device'),
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0)
          ),

          if (searchcomp == 5) Container (
              child: Text(
                '     Successfuly found Smart Strip device. Click below to finish pairing',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.grey,
                ),
              )
          ),
          if (searchcomp ==5) FlatButton (
              onPressed: (){
                backFunction.addStrip(iplist[listplace], global.tempstripid);
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SmartDevices())
                );
              },
              color: Colors.blue[800],
              child: Text('Finish pairing'),
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0)
          ),

        ]
      ),

    );
  }

  Future<List<String>> searchip() async {
    List<String> iplisttemp = [""];
    String ip = await Wifi.ip;
    String subnet = ip.substring(0, ip.lastIndexOf('.'));
    int port = 80;

    final stream = NetworkAnalyzer.discover2(subnet, port);
    await for (NetworkAddress addr in stream) {
      if (addr.exists) {
        if (addr.ip == global.stripip[0] || addr.ip == global.stripip[1] || addr.ip == global.stripip[2] || addr.ip == global.stripip[3] || addr.ip == global.stripip[4] || addr.ip == global.stripip[5] || addr.ip == global.stripip[6] || addr.ip == global.stripip[7] || addr.ip == global.stripip[8] || addr.ip == global.stripip[9]) {

        } else {
          iplisttemp.add(addr.ip);
        }
      }
    }

    iplisttemp.removeAt(0);
    print(iplisttemp);
    return iplisttemp;
  }
}

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return new Scaffold(

      appBar: AppBar(
        title: Text('About'),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Application Options'),
              decoration: BoxDecoration(
                color: Colors.blue[800],
              ),
            ),
            ListTile(
              title: Text('Smart Strip Devices'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SmartDevices())
                );
              },
            ),
            ListTile(
              title: Text('Add Smart Strip'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddStrip())
                );
              },
            ),
            Container(
              decoration: BoxDecoration (
                color: Colors.black26,
              ),
              child: ListTile(
                title: Text('About'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),

    );
  }
}

class stripView extends StatefulWidget {
  @override
  StripView createState() => StripView();
}

class StripView extends State<stripView> {
  //variables that will change in regards to current strip and outlet power
  List<int> tempstatus = [global.outletstatus[global.currentstrip][0], global.outletstatus[global.currentstrip][1], global.outletstatus[global.currentstrip][2], global.outletstatus[global.currentstrip][3]];
  int tempstrip = global.currentstrip;
  List<int> tempmode = [global.outletmode[global.currentstrip][0], global.outletmode[global.currentstrip][1], global.outletmode[global.currentstrip][2], global.outletmode[global.currentstrip][3]];
  List<String> mode = ["", "", "", ""];
  List<String> status = ["", "", "", ""];
  List<String> timeon = ["", "", "", ""];
  List<String> timeoff = ["", "", "", ""];

  @override
  void initState() {
    if (tempmode[0] == 1) {
      mode[0] = "Standard Mode";
    } else {
      mode[0] = "Timed Mode";
      String on = global.outlettimeon[global.currentstrip][0] as String;
      String off = global.outlettimeoff[global.currentstrip][0] as String;
      if (!(on.isEmpty)) {
        timeon[0] = "Outlet Time on: " + on;
      }
      if (!(off.isEmpty)) {
        timeoff[0] = "Outlet Time off: " + off;
      }
    }

    if (tempmode[1] == 1) {
      mode[1] = "Standard Mode";
    } else {
      mode[1] = "Timed Mode";
      String on = global.outlettimeon[global.currentstrip][1] as String;
      String off = global.outlettimeoff[global.currentstrip][1] as String;
      if (!(on.isEmpty)) {
        timeon[1] = "Outlet Time on: " + on;
      }
      if (!(off.isEmpty)) {
        timeoff[1] = "Outlet Time off: " + off;
      }
    }

    if (tempmode[2] == 1) {
      mode[2] = "Standard Mode";
    } else {
      mode[2] = "Timed Mode";
      String on = global.outlettimeon[global.currentstrip][2] as String;
      String off = global.outlettimeoff[global.currentstrip][2] as String;
      if (!(on.isEmpty)) {
        timeon[2] = "Outlet Time on: " + on;
      }
      if (!(off.isEmpty)) {
        timeoff[2] = "Outlet Time off: " + off;
      }
    }

    if (tempmode[3] == 1) {
      mode[3] = "Standard Mode";
    } else {
      mode[3] = "Timed Mode";
      String on = global.outlettimeon[global.currentstrip][3] as String;
      String off = global.outlettimeoff[global.currentstrip][3] as String;
      if (!(on.isEmpty)) {
        timeon[3] = "Outlet Time on: " + on;
      }
      if (!(off.isEmpty)) {
        timeoff[3] = "Outlet Time off: " + off;
      }
    }

    if (global.outletstatus[global.currentstrip][0] == 1) {
      status[0] = "on";
    } else {
      status[0] = "off";
    }
    if (global.outletstatus[global.currentstrip][1] == 1) {
      status[1] = "on";
    } else {
      status[1] = "off";
    }
    if (global.outletstatus[global.currentstrip][2] == 1) {
      status[2] = "on";
    } else {
      status[2] = "off";
    }
    if (global.outletstatus[global.currentstrip][3] == 1) {
      status[3] = "on";
    } else {
      status[3] = "off";
    }
  }
  Widget build(BuildContext context) {
    return new Scaffold(

      appBar: AppBar(
          title: Text(global.stripname[global.currentstrip] + ' Manager'),
          centerTitle: true,
          backgroundColor: Colors.blue[800],
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SmartDevices())
                );
              }
          )
      ),

      body: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(global.outletname[global.currentstrip][index]),
                subtitle: Text(
                    'Outlet ' + (index+1).toString() +
                        '                                                                                           ' +
                    'Powered: ' + status[index] +
                    '                                                                                           ' +
                    'Mode: ' + mode[index] +
                    '                                                                                           ' +
                    timeon[index] +
                    '                                                                                           ' +
                    timeoff[index]
                ),
                trailing: Column(
                  children: <Widget>[
                    PopupMenuButton<String>(
                      onSelected: (choice) => choiceAction(choice, context, index),
                      itemBuilder: (BuildContext context) {
                        if (tempstatus[index] == 0) {
                          return OutletEditPopOne.choices.map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                        }

                        else {
                          return OutletEditPopTwo.choices.map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                        }
                      },
                    )
                  ],
                ),
              ),
            );
          }
      ),

    );
  }

  void choiceAction(String choice, BuildContext context, int index) {
    global.currentoutlet = index;

    //if outlet is not powered, present these options
    if (choice == OutletEditPopOne.switchoutleton) {
      backFunction.turnOutletOn(index).then((_) {
        setState(() {
          tempstatus = [global.outletstatus[global.currentstrip][0], global.outletstatus[global.currentstrip][1], global.outletstatus[global.currentstrip][2], global.outletstatus[global.currentstrip][3]];
          tempstrip = global.currentstrip;
          tempmode = [global.outletmode[global.currentstrip][0], global.outletmode[global.currentstrip][1], global.outletmode[global.currentstrip][2], global.outletmode[global.currentstrip][3]];
          if (global.outletstatus[global.currentstrip][0] == 1) {
            status[0] = "on";
          } else {
            status[0] = "off";
          }
          if (global.outletstatus[global.currentstrip][1] == 1) {
            status[1] = "on";
          } else {
            status[1] = "off";
          }
          if (global.outletstatus[global.currentstrip][2] == 1) {
            status[2] = "on";
          } else {
            status[2] = "off";
          }
          if (global.outletstatus[global.currentstrip][3] == 1) {
            status[3] = "on";
          } else {
            status[3] = "off";
          }
          mode[0] = mode[0];
          mode[1] = mode[1];
          mode[2] = mode[2];
          mode[3] = mode[3];
          status[0] = status[0];
          status[1] = status[1];
          status[2] = status[2];
          status[3] = status[3];
          timeon[0] = timeon[0];
          timeon[1] = timeon[1];
          timeon[2] = timeon[2];
          timeon[3] = timeon[3];
          timeoff[0] = timeoff[0];
          timeoff[1] = timeoff[1];
          timeoff[2] = timeoff[2];
          timeoff[3] = timeoff[3];
        });
      });
    }
    if (choice == OutletEditPopOne.power) {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MakePower())
      );
    }
    if (choice == OutletEditPopOne.editname) {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => changeOutletName())
      );
    }
    if (choice == OutletEditPopOne.outletmode) {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OutletEditor())
      );
    }

    //if outlet is powered, present these options
    if (choice == OutletEditPopTwo.switchoutletoff) {
      backFunction.turnOutletOff(index).then((_){
        setState(() {
          tempstatus = [global.outletstatus[global.currentstrip][0], global.outletstatus[global.currentstrip][1], global.outletstatus[global.currentstrip][2], global.outletstatus[global.currentstrip][3]];
          tempstrip = global.currentstrip;
          tempmode = [global.outletmode[global.currentstrip][0], global.outletmode[global.currentstrip][1], global.outletmode[global.currentstrip][2], global.outletmode[global.currentstrip][3]];
          if (global.outletstatus[global.currentstrip][0] == 1) {
            status[0] = "on";
          } else {
            status[0] = "off";
          }
          if (global.outletstatus[global.currentstrip][1] == 1) {
            status[1] = "on";
          } else {
            status[1] = "off";
          }
          if (global.outletstatus[global.currentstrip][2] == 1) {
            status[2] = "on";
          } else {
            status[2] = "off";
          }
          if (global.outletstatus[global.currentstrip][3] == 1) {
            status[3] = "on";
          } else {
            status[3] = "off";
          }
          mode[0] = mode[0];
          mode[1] = mode[1];
          mode[2] = mode[2];
          mode[3] = mode[3];
          status[0] = status[0];
          status[1] = status[1];
          status[2] = status[2];
          status[3] = status[3];
          timeon[0] = timeon[0];
          timeon[1] = timeon[1];
          timeon[2] = timeon[2];
          timeon[3] = timeon[3];
          timeoff[0] = timeoff[0];
          timeoff[1] = timeoff[1];
          timeoff[2] = timeoff[2];
          timeoff[3] = timeoff[3];
        });
      });
    }
    if (choice == OutletEditPopTwo.power) {

    }
    if (choice == OutletEditPopTwo.editname) {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => changeOutletName())
      );
    }
    if (choice == OutletEditPopTwo.outletmode) {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OutletEditor())
      );
    }
  }
}

class changeOutletName extends StatefulWidget {
  @override
  ChangeOutletName createState() => ChangeOutletName();
}

class ChangeOutletName extends State<changeOutletName> {
  String text = global.outletname[global.currentstrip][global.currentoutlet];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text('Edit Outlet Name'),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_outlined),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => stripView())
                );
              },
            );
          },
        ),
      ),

      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextField(
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: text,
                ),
                onChanged: (value) {
                  setState(() {
                    text = value;
                  });
                }
            ),
            FlatButton(
              onPressed: () {
                backFunction.changeOutletName(global.currentstrip, text);
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => stripView())
                );
              },
              color: Colors.blue[800],
              child: Text('Save'),
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            ),
          ]
      ),

    );
  }
}

class OutletEditor extends StatelessWidget {

  @override
  Widget build(BuildContext context){

    return new Scaffold(

      appBar: AppBar(
        title: Text(global.outletname[global.currentstrip][global.currentoutlet] + " Mode Select"),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_outlined),
              onPressed: () {
                Navigator.push(
                  context,
                    MaterialPageRoute(builder: (context) => stripView())
                );
                },
            );
          },
        ),
      ),

      body: Column (
          mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Card (
            elevation: 8,
            child: InkWell(
              child: ListTile (
                title: Text("Standard Outlet"),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StandardMode())
                );
              },
            ),
          ),
          Card (
            elevation: 8,
            child: InkWell(
              child: ListTile (
                title: Text("Timed Outlet"),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TimeMode())
                );
              },
            ),
          ),

        ]
      ),

    );
  }

  void choiceAction(String choice, BuildContext context) {
    if (choice == OutletChange.save) {
      backFunction.turnOutletOn(global.currentoutlet);
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => stripView())
      );
    }
    if (choice == OutletChange.exit) {
      backFunction.turnOutletOff(global.currentoutlet);
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => stripView())
      );
    }
  }
}

class StandardMode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      appBar: AppBar(
        title: Text("Standard Outlet Mode"),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_outlined),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OutletEditor())
                );
              },
            );
          },
        ),
      ),

      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container (
              child: Text(
                'Under the Standard Outlet operating mode, the selected outlet on the smart strip operates as a normal power outlet. It will not power off without direct switching of the outlet by the user. To operate under the Standard Outlet mode, click on the "Use Standard Outlet mode" button below.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.grey,
                ),
              ),
            ),
            FlatButton (
                onPressed: (){
                  global.outletmode[global.currentstrip][global.currentoutlet] = 1;
                  backFunction.updateStrip(global.currentstrip);
                  backFunction.changeStandardMode();
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OutletEditor())
                  );
                },
                color: Colors.blue[800],
                child: Text('Use Standard Outlet mode'),
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0)
            ),
          ]
      ),

    );
  }
}

class TimeMode extends StatefulWidget {
  @override
  TimePick createState() => TimePick();
}

class TimePick extends State<TimeMode>{
  String _setTimeOn, _setTimeOff;
  String setTimeOn = "n", setTimeOff = "n";
  String _houron, _minuteon, _timeon;
  String _houroff, _minuteoff, _timeoff;
  String dateTime;
  int timeerr = 0;

  TimeOfDay selecttimeon = TimeOfDay(hour: 00, minute: 00);
  TimeOfDay selecttimeoff = TimeOfDay(hour: 00, minute: 00);
  TextEditingController _timeControllerOn = TextEditingController();
  TextEditingController _timeControllerOff = TextEditingController();

  Future<Null> _selectTimeOn(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selecttimeon,
    );
    if (picked != null)
      setState(() {
        selecttimeon = picked;
        selecttimeoff = selecttimeoff;
        _houron = selecttimeon.hour.toString();
        _minuteon = selecttimeon.minute.toString();
        _timeon = _houron + ' : ' + _minuteon;
        _timeControllerOn.text = _timeon;
        _timeControllerOn.text = formatDate(
            DateTime(2019, 08, 1, selecttimeon.hour, selecttimeon.minute),
            [hh, ':', nn, " ", am]).toString();

        String hourformat, minuteformat;
        //format hour
        if (selecttimeon.hour < 10) {
          hourformat = '0' + selecttimeon.hour.toString();
        }
        else {
          hourformat = selecttimeon.hour.toString();
        }

        //format minute
        if (selecttimeon.minute < 10) {
          minuteformat = '0' + selecttimeon.minute.toString();
        }
        else {
          minuteformat = selecttimeon.minute.toString();
        }

        //set in state
        setTimeOn = hourformat + minuteformat;
        setTimeOff = setTimeOff;
        print(setTimeOn);
      });
  }

  Future<Null> _selectTimeOff(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selecttimeoff
    );
    if (picked != null)
      setState(() {
        selecttimeoff = picked;
        selecttimeon = selecttimeon;
        _houroff = selecttimeoff.hour.toString();
        _minuteoff = selecttimeoff.minute.toString();
        _timeoff = _houroff + ' : ' + _minuteoff;
        _timeControllerOff.text = _timeoff;
        _timeControllerOff.text = formatDate(
            DateTime(2019, 08, 1, selecttimeoff.hour, selecttimeoff.minute),
            [hh, ':', nn, " ", am]).toString();

        String hourformat, minuteformat;
        //format hour
        if (selecttimeoff.hour < 10) {
          hourformat = "0" + selecttimeoff.hour.toString();
        }
        else {
          hourformat = selecttimeoff.hour.toString();
        }

        //format minute
        if (selecttimeoff.minute < 10) {
          minuteformat = "0" + selecttimeoff.minute.toString();
        }
        else {
          minuteformat = selecttimeoff.minute.toString();
        }

        //set in state
        setTimeOff = hourformat + minuteformat;
        setTimeOn = setTimeOn;
        print(setTimeOff);

      });
  }

  @override
  void initState() {
    _timeControllerOn.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
    _timeControllerOff.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
    super.initState();
  }

  Widget build(BuildContext context) {
    return new Scaffold(

      appBar: AppBar(
        title: Text("Timed Outlet Mode"),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_outlined),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OutletEditor())
                );
              },
            );
          },
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[

            //text explaining functionality
            Text(
            'Under the timed outlet operating mode, the selected outlet on the smart strip operates as a normal timed outlet. This means at the selected on time, the outlet will turn on, and that at the selected off time the outlet will be turned off. To operate under the Timed Outlet mode, select on and/or off times below and click the "Use Timed Outlet mode" button below',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.grey,
              ),
            ),

            //time on outlet
            Column(
              children: <Widget>[
                Text(
                  'Choose Time to Turn Outlet On',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5),
                ),
                InkWell(
                  onTap: () {
                    _selectTimeOn(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 30),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.blue[800]),
                    child: TextFormField(
                      style: TextStyle(fontSize: 40),
                      textAlign: TextAlign.center,
                      onSaved: (String val) {
                        _setTimeOn = val;
                        print(_setTimeOn);
                        //set the time locally
                      },
                      enabled: false,
                      keyboardType: TextInputType.text,
                      controller: _timeControllerOn,
                      decoration: InputDecoration(
                          disabledBorder:
                          UnderlineInputBorder(borderSide: BorderSide.none),
                          // labelText: 'Time',
                          contentPadding: EdgeInsets.all(5)),
                    ),
                  ),
                ),
              ],
            ),

            //time off outlet
            Column(
              children: <Widget>[
                Text(
                  'Choose Time to Turn Outlet Off',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5),
                ),
                InkWell(
                  onTap: () {
                    _selectTimeOff(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 30),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.blue[800]),
                    child: TextFormField(
                      style: TextStyle(fontSize: 40),
                      textAlign: TextAlign.center,
                      onSaved: (String val) {
                        _setTimeOff = val;
                        print(_setTimeOff);
                        //set the time locally
                      },
                      enabled: false,
                      keyboardType: TextInputType.text,
                      controller: _timeControllerOff,
                      decoration: InputDecoration(
                          disabledBorder:
                          UnderlineInputBorder(borderSide: BorderSide.none),
                          // labelText: 'Time',
                          contentPadding: EdgeInsets.all(5)),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(   //Use of SizedBox
              height: 30,
            ),

            FlatButton (
                onPressed: (){
                  //check if times have been entered
                  if (identical(setTimeOn, "n") && identical(setTimeOff, "n")) {
                    //set state to show error
                    setState(() {
                      timeerr = 1;
                    });
                  }
                  //if so, will push data to mcu and db
                  else {
                    if (!identical(setTimeOn, "n")) {
                      backFunction.setTimeOn(global.currentoutlet, setTimeOn);
                    }

                    if (!identical(setTimeOff, "n")) {
                      backFunction.setTimeOff(global.currentoutlet, setTimeOff);
                    }

                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OutletEditor())
                    );
                  }
                },
                color: Colors.blue[800],
                child: Text('Use Timed Outlet mode'),
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0)
            ),

            //text for no present time entry
            if (timeerr == 1) Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Center(
                child: Text(
                  'Error: Must enter an on or off time',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 15
                  ),
                ),
              ),
            ),

          ],
        ),
    ),

    );
  }
}

class MakePower extends StatefulWidget {
  @override
  PowerView createState() => PowerView();
}

class PowerView extends State<MakePower>{
  String kwhtotal = "0.0";
  String kwhavg = "0.0";

  @override
  void initState() {
    backFunction.getPowerInfo().then((value){
      setState(() {
        kwhtotal = global.kwhtotal[global.currentstrip][global.currentoutlet] as String;
        kwhavg = global.kwhavg[global.currentstrip][global.currentoutlet] as String;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(global.outletname[global.currentstrip][global.currentoutlet] + " Power Usage Info"),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_outlined),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => stripView())
                );
              },
            );
          },
        ),
      ),

    body: Container(
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[

          Text( "Average outlet KWH usage: " + kwhavg,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 40.0,
              color: Colors.black,
            ),
          ),

          Text( "Total outlet KWH usage: " + kwhtotal,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 40.0,
              color: Colors.black,
            ),
          ),

        ]
      )
    ),
    );
  }
}

//view power page