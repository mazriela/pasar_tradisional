import 'package:flutter/material.dart';
import 'package:loader_search_bar/loader_search_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:pasar_tradisional_app/helper/constant.dart';
import 'package:pasar_tradisional_app/helper/show_alert_dialog.dart';
import 'package:pasar_tradisional_app/model/kategoriPasar/ModelGetKategoriPasar.dart';
import 'package:pasar_tradisional_app/model/pasar/ModelGetPasar.dart';
import 'package:pasar_tradisional_app/view/account/Account_screen.dart';
import 'package:pasar_tradisional_app/view/cart/Cart_Screen.dart';
import 'package:pasar_tradisional_app/view/order_history/orderhistory_screen.dart';
import 'package:pasar_tradisional_app/view/product/SubKategoriPage.dart';
import 'package:http/http.dart' as http;

const String _kGalleryAssetsPackage = 'flutter_gallery_assets';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => home();
// TODO: implement createState

}

class Photo {
  Photo({
    this.assetName,
    this.assetPackage,
    this.title,
    this.caption,
  });

  final String assetName;
  final String assetPackage;
  final String title;
  final String caption;
}

class home extends State<HomePage> {
  List list = ['12', '11'];

  final List<String> items = ['Balbhadra', 'Maulik', 'Roshi'];
  static const double height = 366.0;

  var idPasar = "1";
  var idKategori = "1";
  var namaPasar;

  String name = 'My Wishlist';
  ModelGetPasar modelGetPasar;
  ModelGetKategoriPasar modelGetKategoriPasar;

  var loading = true;
  var loadingKategori = true;

  List _listPasar = List();
  List _listKategoriPasar = List();

  void first() {}

  void _getPasarFirst() async {
    loading = true;
    final response = await http.get(baseURL + endtPointGetPasar);

    modelGetPasar = modelGetPasarFromJson(response.body);
    if (response.statusCode == 200) {
      var status = modelGetPasar.status;
      var message = modelGetPasar.message;
      if (status) {
        loading = false;
        var data = modelGetPasar.data;
        setState(() {
          _listPasar = data;
          namaPasar = _listPasar[0].namaPasar;
          _getKategoriPasar(_listPasar[0].idPasar.toString());
          print(response.body);
        });
      } else {
        loading = false;
        var data = modelGetPasar.data;
        setState(() {
          namaPasar = "Pilih Pasar";
          _listPasar = data;
          print(response.body);
        });
        print("MESSSAGE =  $message");
        print("Status =  $status");
      }
    } else {
      print("Server tidak merespon, silahkan check koneksi internet anda");
    }
  }

  void _getPasar() async {
    loading = true;
    final response = await http.get(baseURL + endtPointGetPasar);

    modelGetPasar = modelGetPasarFromJson(response.body);
    if (response.statusCode == 200) {
      var status = modelGetPasar.status;
      var message = modelGetPasar.message;
      if (status) {
        loading = false;
        var data = modelGetPasar.data;
        setState(() {
          _listPasar = data;
          print(response.body);

          showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomAlertDialog(
                  title: Center(child: Text('Pilih Pasar')),
                  content: setupAlertDialoadContainer(data),
                );
              });
        });
      } else {
        loading = false;
        var data = modelGetPasar.data;
        setState(() {
          _listPasar = data;
          print(response.body);
        });
        print("MESSSAGE =  $message");
        print("Status =  $status");
      }
    } else {
      print("Server tidak merespon, silahkan check koneksi internet anda");
    }
  }

  void _getKategoriPasar(id_pasar) async {
    loadingKategori = true;
    final response = await http.post(baseURL + endtPointGetKategoriPasar,
        body: {"id_pasar": id_pasar});

    modelGetKategoriPasar = modelGetKategoriPasarFromJson(response.body);
    if (response.statusCode == 200) {
      var status = modelGetKategoriPasar.status;
      var message = modelGetKategoriPasar.message;
      if (status) {
        loadingKategori = false;
        var data = modelGetKategoriPasar.data;
        setState(() {
          print("KATEGORI PASAR = ${response.body}");
          _listKategoriPasar = data;
        });
      } else {
        loadingKategori = false;
        setState(() {
          print(response.body);
        });
        print("MESSSAGE =  $message");
        print("Status =  $status");
      }
    } else {
      loadingKategori = false;
      print("Server tidak merespon, silahkan check koneksi internet anda");
    }
  }

  Widget setupAlertDialoadContainer(dataPasar) {
    return loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            width: MediaQuery.of(context).size.width / 1.3,
            height: MediaQuery.of(context).size.height /
                2, // Change as per your requirement
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _listPasar.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: GestureDetector(
                      child: Card(
                    elevation: 8.0,
                    // margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                    child: Container(
                      decoration:
                          BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                      child: ListTile(
                          // contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                          leading: Container(
                            padding: EdgeInsets.only(right: 12.0),
                            decoration: new BoxDecoration(
                                border: new Border(
                                    right: new BorderSide(
                                        width: 1.0, color: cPrimary))),
                            child: Icon(Icons.account_balance,
                                color: Colors.white),
                          ),
                          title: Text(
                            "${dataPasar[index].namaPasar}",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                          subtitle: Row(
                            children: <Widget>[
                              Icon(Icons.all_inclusive,
                                  color: Colors.yellowAccent),
                              Text("5km", style: TextStyle(color: Colors.white))
                            ],
                          ),
                          trailing: Icon(Icons.keyboard_arrow_right,
                              color: Colors.white, size: 30.0)),
                    ),
                  )),
                  onTap: () {
                    setState(() {
                      idPasar = dataPasar[index].idPasar.toString();

                      namaPasar = dataPasar[index].namaPasar;
                      print("id pasar = $idPasar");
                      _getKategoriPasar(idPasar);
                    });
                    Navigator.pop(context);
                  },
                );
              },
            ),
          );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPasarFirst();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final Orientation orientation = MediaQuery.of(context).orientation;
    final ThemeData theme = Theme.of(context);
    final TextStyle titleStyle =
        theme.textTheme.headline.copyWith(color: Colors.black54);
    final TextStyle descriptionStyle = theme.textTheme.subhead;
    ShapeBorder shapeBorder;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(color: cPrimary),
        backgroundColor: Colors.white,
        title: Text(
          "Pasar Tradisional",
          style: kLabelStyle,
        ),
        actions: <Widget>[
          // IconButton(
          //   tooltip: 'Search',
          //   icon: const Icon(Icons.search,color: Colors.black
          //     ,),
          //   onPressed: () async {
          //     final int selected = await showSearch<int>(
          //       context: context,
          //       //delegate: _delegate,
          //     );
          //   },
          // ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 150.0,
              width: 30.0,
              child: GestureDetector(
                onTap: () {
                  /*Navigator.of(context).push(
                   MaterialPageRoute(
                      builder:(BuildContext context) =>
                       CartItemsScreen()
                  )
              );*/
                },
                child: Stack(
                  children: <Widget>[
                    IconButton(
                        icon: Icon(
                          Icons.shopping_cart,
                          color: cPrimary,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Cart_screen()));
                        }),
                    list.length == 0
                        ? Container()
                        : Positioned(
                            child: Stack(
                            children: <Widget>[
                              Icon(Icons.brightness_1,
                                  size: 20.0, color: Colors.orange.shade500),
                              Positioned(
                                  top: 4.0,
                                  right: 5.5,
                                  child: Center(
                                    child: Text(
                                      list.length.toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 11.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )),
                            ],
                          )),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Card(
              child: UserAccountsDrawerHeader(
                accountName: Text(
                  "Naomi A. Schultz",
                  style: kLabelStyle,
                ),
                accountEmail: Text(
                  "NaomiASchultz@armyspy.com",
                  style: kLabelStyle,
                ),
                onDetailsPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Account_Screen()));
                },
                decoration: BoxDecoration(
                  color: Colors.white,

                  /* image:  DecorationImage(
               //   image:  ExactAssetImage('assets/assets/images/lake.jpeg'),
                  fit: BoxFit.cover,
                ),*/
                ),
                currentAccountPicture:
                    CircleAvatar(backgroundImage: NetworkImage("")),
              ),
            ),
            Card(
              elevation: 4.0,
              child: Column(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.favorite),
                      title: Text(name),
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => Item_Screen(
                        //               toolbarname: name,
                        //             )));
                      }),
                  Divider(),
                  ListTile(
                      leading: Icon(Icons.history),
                      title: Text("Order History "),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Oder_History(
                                      toolbarname: ' Order History',
                                    )));
                      }),
                ],
              ),
            ),
            Card(
              elevation: 4.0,
              child: Column(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.settings),
                      title: Text("Setting"),
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => Setting_Screen(
                        //               toolbarname: 'Setting',
                        //             )));
                      }),
                  Divider(),
                  ListTile(
                      leading: Icon(Icons.help),
                      title: Text("Help"),
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => Help_Screen(
                        //               toolbarname: 'Help',
                        //             )));
                      }),
                ],
              ),
            ),
            Card(
              elevation: 4.0,
              child: ListTile(
                  leading: Icon(Icons.power_settings_new),
                  title: Text(
                    "Logout",
                    style: TextStyle(color: Colors.redAccent, fontSize: 17.0),
                  ),
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => Login_Screen()));
                  }),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4,
              child: Image.asset(
                'assets/images/veg.jpg',
                fit: BoxFit.cover,
              ),
            ),
            GestureDetector(
              onTap: () {
                _getPasar();
              },
              child: Container(
                color: cWhite,
                margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: IgnorePointer(
                  child: TextField(
                      decoration: InputDecoration(
                    labelText: "$namaPasar",
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.place),
                    suffixIcon: Icon(Icons.arrow_drop_down),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  )),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 7.0),
              color: cWhite,
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _verticalD(),
                    GestureDetector(
                      onTap: () {
                        //             )));
                      },
                      child: Text(
                        'Kategori',
                        style: TextStyle(
                            fontSize: 20.0,
                            color: cBlack,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    _verticalD(),
                  ]),
            ),
            _listKategoriPasar.length != 0
                ? loadingKategori
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.white, Colors.white],
                          ),
                        ),
                        child: GridView.builder(
                            shrinkWrap: true,
                            itemCount: _listKategoriPasar.length,
                            primary: false,
                            physics: NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(5.0),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              idKategori = _listKategoriPasar[index]
                                  .idKategoriProduk
                                  .toString();

                              return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SubKategoriPage(
                                                  toolbarname: 'Sub Kategori',
                                                  idPasar: idPasar,
                                                  idKategori: idKategori,
                                                )));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Stack(
                                        children: <Widget>[
                                          Image.asset(
                                            "assets/images/veg.jpg",
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                6,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                6,
                                            fit: BoxFit.cover,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                // Add one stop for each color. Stops should increase from 0 to 1
                                                stops: [0.2, 0.7],
                                                colors: [
                                                  Color.fromARGB(100, 0, 0, 0),
                                                Color.fromARGB(100, 0, 0, 0),
                                                ],
                                                // stops: [0.0, 0.1],
                                              ),
                                            ),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                6,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                6,
                                          ),
                                          Center(
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  6,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  6,
                                              padding: const EdgeInsets.all(1),
                                              constraints: BoxConstraints(
                                                minWidth: 20,
                                                minHeight: 20,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  _listKategoriPasar[index].namaKategori,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ));
                            }),
                      )
                : Center(
                    child: Container(
                        margin: EdgeInsets.only(top: 20),
                        child:
                            Text("Tidak Ada Kategori, silahkan pilih pasar.")),
                  ),
          ]),
        ),
      ),
    );
  }

  Icon keyloch = Icon(
    Icons.arrow_forward,
    color: Colors.black26,
  );

  _verticalD() => Container(
        margin: EdgeInsets.only(left: 5.0, right: 0.0, top: 5.0, bottom: 0.0),
      );
}

//category old
// Column(
// crossAxisAlignment: CrossAxisAlignment.center,
// children: [
// Card(
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(10.0),
// ),
// elevation: 3.0,
// child: Container(
// width: 80,
// height: 80,
// child: Padding(
// padding: const EdgeInsets.all(8.0),
// child: ClipRRect(
// borderRadius: BorderRadius.vertical(
// top: Radius.circular(10.0),
// bottom: Radius.circular(10.0)),
// child: Image.asset(
// "assets/images/veg.jpg",
// fit: BoxFit.cover,
// ),
// ),
// ),
// ),
// ),
// Text(
// _listKategoriPasar[index].namaKategori,
// style: TextStyle(
// fontSize: 12.0,
// color: cBlack,
// fontWeight: FontWeight.bold),
// )
// ],
// )
