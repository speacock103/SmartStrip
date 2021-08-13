library smartstrip_test.global;

//convenient globals
int appon = 0;
int currentstrip = 0;
int currentoutlet = 0;
int tempstripid = -1;

//store
int staylogged = 0;
String uniqueid = "";

//fetched from db following verification
String userid = "";
List<String> stripname = new List(10);
List<int> numpowered = new List(10);
var outletname = List.generate(10, (i) => List(4));
var outletstatus = List.generate(10, (i) => List(4));
var outletmode = List.generate(10, (i) => List(4));
var outlettimeon = List.generate(10, (i) => List(4));
var outlettimeoff = List.generate(10, (i) => List(4));
var kwhtotal = List.generate(10, (i) => List(4));
var kwhavg = List.generate(10, (i) => List(4));
List<int> stripid = new List(10);
List<String> stripip = new List(10);
int numstrips = 0;

//power infos, get rid of global and just display when fetched from db?
List<double> dailypoweruse = new List(10);
var outletpowerusehour = List.generate(10, (i) => List(4));
var outletpoweruseday = List.generate(10, (i) => List(4));
var outletpoweruseweek = List.generate(10, (i) => List(4));