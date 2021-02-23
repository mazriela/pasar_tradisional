import 'package:flutter/material.dart';
import 'package:pasar_tradisional_app/helper/constant.dart';
import 'package:pasar_tradisional_app/model/subKategoriProduk/ModelSubKategoriProduk.dart';
import 'package:pasar_tradisional_app/view/cart/Cart_Screen.dart';
import 'package:http/http.dart' as http;
import 'package:pasar_tradisional_app/view/product/ProductPage.dart';

import 'item_details.dart';

class SubKategoriPage extends StatefulWidget {
  final String toolbarname, idPasar, idKategori;

  SubKategoriPage({Key key, this.toolbarname,this.idPasar,this.idKategori}) : super(key: key);

  @override
  State<StatefulWidget> createState() => sub_kategori_page(toolbarname);
}

class Item {
  final String itemname;
  final String imagename;
  final String itmprice;

  Item({this.itemname, this.imagename, this.itmprice});
}

class sub_kategori_page extends State<SubKategoriPage> {

  List list = ['12', '11'];
  bool checkboxValueA = true;
  bool checkboxValueB = false;
  bool checkboxValueC = false;

  List _listSubKategori = List();
  List<Item> itemList = <Item>[
    Item(
        imagename: 'assets/images/apple.jpg',
        itemname: 'Apel',
        itmprice: 'Rp.10.000'),

  ];

  ModelSubKategoriProduk modelGetSubKategori;
  // String toolbarname = 'Fruiys & Vegetables';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String toolbarname;

  sub_kategori_page(this.toolbarname);

  var loadingSubKategori = true;



  void _getSubKategori(idPasar,idKategoriProduk) async {
    loadingSubKategori = true;
    final response = await http.post(baseURL + endtPointGetSubKategoriPasar,
        body: {
      "id_pasar": idPasar,
      "id_kategori_produk": idKategoriProduk,
        });

    modelGetSubKategori = modelGetSubKategoriFromJson(response.body);
    if (response.statusCode == 200) {
      var status = modelGetSubKategori.status;
      var message = modelGetSubKategori.message;
      if (status) {
        loadingSubKategori = false;
        var data = modelGetSubKategori.data;
        setState(() {
          print("KATEGORI PASAR = ${response.body}");
          _listSubKategori = data;
        });
      } else {
        loadingSubKategori = false;
        setState(() {
          print(response.body);
        });
        print("MESSSAGE =  $message");
        print("Status =  $status");
      }
    } else {
      loadingSubKategori = false;
      print("Server tidak merespon, silahkan check koneksi internet anda");
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("id pasar = ${widget.idPasar}, idKatProd = ${widget.idKategori}");
    _getSubKategori(widget.idPasar, widget.idKategori);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 200) / 2;
    final double itemWidth = size.width / 2;

    // TODO: implement build
    IconData _backIcon() {
      switch (Theme.of(context).platform) {
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
          return Icons.arrow_back;
        case TargetPlatform.iOS:
          return Icons.arrow_back_ios;
      }
      assert(false);
      return null;
    }




    final Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: cPrimary),
        backgroundColor: cWhite,
        leading: IconButton(
          icon: Icon(_backIcon()),
          alignment: Alignment.centerLeft,
          tooltip: 'Back',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          toolbarname,
          style: TextStyle(color: cPrimary),
        ),
        actions: <Widget>[
          IconButton(
            tooltip: 'Search',
            icon: const Icon(Icons.search),
            onPressed: () async {
              final int selected = await showSearch<int>(
                context: context,
                // delegate: _delegate,
              );
            },
          ),
          IconButton(
              tooltip: 'Sort',
              icon: const Icon(Icons.filter_list),
              onPressed: () {
                // _showBottomSheet();
              }),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
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
                          color: Colors.black,
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
      body: loadingSubKategori ? Center(child: CircularProgressIndicator(),) : Column(
        children: <Widget>[
          Container(
            child: Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: (itemWidth / itemHeight),
                controller: ScrollController(keepScrollOffset: false),
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(4.0),
                children:  List.generate(
                    _listSubKategori.length,
                        (index) {
                      return GestureDetector(
                        onTap: (){
                          print("idPasar${modelGetSubKategori.data[index].idPasar}");
                          print("id kat${modelGetSubKategori.data[index].idKategoriProduk}");
                          print("id sub kat prod = ${modelGetSubKategori.data[index].idKategoriProdukSub}");
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => ProductPage(
                                toolbarname: "Product",
                                idPasar: modelGetSubKategori.data[index].idPasar.toString(),
                                idKategori: modelGetSubKategori.data[index].idKategoriProduk.toString(),
                                idSubKategori: modelGetSubKategori.data[index].idKategoriProdukSub.toString(),
                              )));
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                          child: Container(
                            height: MediaQuery.of(context).size.width,
                            width: MediaQuery.of(context).size.width,
                            child: Card(
                              shape:
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                              elevation: 3.0,
                              child: Column(
                                children: <Widget>[
                                  Stack(
                                    children: <Widget>[
                                      Container(
                                        height: 150,
                                        width: MediaQuery.of(context).size.width,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                          child: Image.asset(
                                            "assets/images/veg.jpg",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 6.0,
                                        right: 6.0,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(4.0)),
                                          child: Padding(
                                            padding: EdgeInsets.all(2.0),
                                            child: Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.star,
                                                  color: cYellow1,
                                                  size: 10.0,
                                                ),
                                                Text(
                                                  "",
                                                  style: TextStyle(
                                                    fontSize: 10.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 6.0,
                                        left: 6.0,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(3.0)),
                                          child: Padding(
                                            padding: EdgeInsets.all(4.0),
                                            child: Text(
                                              " OPEN ",
                                              style: TextStyle(
                                                fontSize: 10.0,
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 7.0),
                                  Padding(
                                    padding: EdgeInsets.only(left: 15.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Text(
                                        "${modelGetSubKategori.data[index].namaKategoriSub}",
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w800,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 7.0),
                                  Padding(
                                    padding: EdgeInsets.only(left: 15.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Text(
                                        "${modelGetSubKategori.data[index].kategoriSeoSub}",
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );

                }).toList(),
              ),
            ),
          )
        ],
      ),

      /* return  GestureDetector(

                  onTap: (){},
                  child: Container(
                    height: 360.0,
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Column(
                       // crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                           Container(

                         child: SizedBox(
                        height: 184.0,
                           child:Image.asset(
                                    itemList[index].imagename,
                                    fit: BoxFit.contain,
                                  ),
                          ),
                          ),
                           Container(

                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Text(itemList[index].itemname,style: TextStyle(color: Colors.black87,fontSize: 17.0,fontWeight: FontWeight.bold),),
                                Text(itemList[index].itemname,style: TextStyle(color: Colors.black38,fontSize: 17.0),)
                              ],
                            ),
                          )


                          // description and share/explore buttons

                        ],

                      ),

                    ),
                  ),
                );*/
    );
  }

  _verticalDivider() => Container(
        padding: EdgeInsets.all(2.0),
      );

  _verticalD() => Container(
        margin: EdgeInsets.only(left: 10.0, right: 0.0, top: 0.0, bottom: 0.0),
      );

  bool a = true;
  String mText = "Press to hide";
  double _lowerValue = 1.0;
  double _upperValue = 100.0;

  void _visibilitymethod() {
    setState(() {
      if (a) {
        a = false;
        mText = "Press to show";
      } else {
        a = true;
        mText = "Press to hide";
      }
    });
  }


  int radioValue = 0;
  bool switchValue = false;

  void handleRadioValueChanged(int value) {
    setState(() {
      radioValue = value;
    });
  }
}

class SubKategoriItem extends StatelessWidget {
  SubKategoriItem({Key key, @required this.subKategoriData,this.index, this.shape})
      : assert(subKategoriData != null),
        super(key: key);

  // static const double height = 566.0;
  final ModelSubKategoriProduk subKategoriData;
  final int index;
  final ShapeBorder shape;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle titleStyle =
        theme.textTheme.headline.copyWith(color: Colors.white);
    final TextStyle descriptionStyle = theme.textTheme.subhead;

    return SafeArea(
        // top: false,
        // bottom: false,
        child: Container(
            padding: const EdgeInsets.all(4.0),
            child: GestureDetector(
              onTap: () {
                print("idPasar${subKategoriData.data[index].idPasar}");
                print("id kat${subKategoriData.data[index].idKategoriProduk}");
                print("id sub kat prod = ${subKategoriData.data[index].idKategoriProdukSub}");
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProductPage(
                      toolbarname: "Product",
                      idPasar: subKategoriData.data[index].idPasar.toString(),
                      idKategori: subKategoriData.data[index].idKategoriProduk.toString(),
                      idSubKategori: subKategoriData.data[index].idKategoriProdukSub.toString(),
                    )));
              },
              child: Card(
                child: Column(
                  children: <Widget>[
                    // photo and title
                    SizedBox(
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Image.asset(
                              "assets/images/apple.jpg",
                              // package: destination.assetPackage,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            // padding: EdgeInsets.all(5.0),
                            child: IconButton(
                                icon: const Icon(Icons.favorite_border),
                                onPressed: () {}),
                          ),
                        ],
                      ),
                    ),
                    // description and share/explore buttons
                    Expanded(
                      child: Container(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                        child: DefaultTextStyle(
                          style: descriptionStyle,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              // three line description
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    subKategoriData.data[index].namaKategoriSub,
                                    style: descriptionStyle.copyWith(
                                        color: Colors.black87),
                                  ),
                                ),
                              ),

                              // Text(destination.description[1]),
                              // Text(destination.description[2]),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Expanded(
                    //   child: Container(
                    //     padding:
                    //     const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                    //     child: DefaultTextStyle(
                    //       style: descriptionStyle,
                    //       child: Row(
                    //         mainAxisSize: MainAxisSize.max,
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: <Widget>[
                    //           // three line description
                    //           Text(
                    //             subKategoriData.data[index].kategoriSeoSub,
                    //             style: descriptionStyle.copyWith(
                    //                 color: Colors.black87),
                    //           ),
                    //
                    //           // Text(destination.description[1]),
                    //           // Text(destination.description[2]),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // share, explore buttons
                    // Container(
                    //   alignment: Alignment.center,
                    //   child: OutlineButton(
                    //       borderSide: BorderSide(color: Colors.amber.shade500),
                    //       child: const Text('Add'),
                    //       textColor: Colors.amber.shade500,
                    //       onPressed: () {
                    //         print("id sub kat prod = ${subKategoriData.data[index].idKategoriProdukSub}");
                    //         // Navigator.push(
                    //         //     context,
                    //         //     MaterialPageRoute(
                    //         //         builder: (context) => Item_Details()));
                    //       },
                    //       shape: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(30.0),
                    //       )),
                    // ),
                  ],
                ),
              ),
            )));
  }


}


