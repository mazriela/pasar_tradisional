import 'package:flutter/material.dart';
import 'package:pasar_tradisional_app/helper/constant.dart';
import 'package:pasar_tradisional_app/model/product/ModelGetProduk.dart';
import 'package:pasar_tradisional_app/model/subKategoriProduk/ModelSubKategoriProduk.dart';
import 'package:pasar_tradisional_app/view/cart/Cart_Screen.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'item_details.dart';

class ProductPage extends StatefulWidget {
  final String toolbarname, idPasar, idKategori, idSubKategori;

  ProductPage(
      {Key key,
      this.toolbarname,
      this.idPasar,
      this.idKategori,
      this.idSubKategori})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => productPage(toolbarname);
}

class productPage extends State<ProductPage> {
  List list = ['12', '11'];
  bool checkboxValueA = true;
  bool checkboxValueB = false;
  bool checkboxValueC = false;

  final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');

  ModelGetProduk modelGetProduct;
  List _listProduct = List();

  // String toolbarname = 'Fruiys & Vegetables';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String toolbarname;

  productPage(this.toolbarname);

  var loadingSubKategori = true;
  var hargaProduct;

  final productThumbnail = new Container(
    margin: EdgeInsets.symmetric(vertical: 16.0),
    alignment: FractionalOffset.topLeft,
    child: new Image(
      image: new AssetImage("assets/images/apple.jpg"),
      height: 92.0,
      width: 92.0,
    ),
  );

  final productCard = new Container(
    height: 124.0,
    margin: EdgeInsets.only(left: 46),
    decoration: new BoxDecoration(
        color: new Color(0xFF333366),
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(5.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: cBlack,
            blurRadius: 8.0,
            offset: new Offset(0.0, 1.0),
          )
        ]),
  );

  void _getProduct(idPasar, idKategoriProduk, idKategoriProdukSub) async {
    loadingSubKategori = true;
    final response = await http.post(baseURL + endtPointGetProduct, body: {
      "id_pasar": idPasar,
      "id_kategori_produk": idKategoriProduk,
      "id_kategori_produk_sub": idKategoriProdukSub,
    });

    modelGetProduct = modelGetProductFromJson(response.body);
    if (response.statusCode == 200) {
      var status = modelGetProduct.status;
      var message = modelGetProduct.message;
      if (status) {
        loadingSubKategori = false;
        var data = modelGetProduct.data;
        setState(() {
          print("PRODUK = ${response.body}");
          _listProduct = data;
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

  void displayBottomSheet(
      BuildContext context, ModelGetProduk modelGetProduk, int index) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return SingleChildScrollView(
              child: Card(
            color: Colors.white,
            elevation: 5.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                    color: Colors.transparent,
                    child: new Container(
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(10.0),
                              topRight: const Radius.circular(10.0))),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                child: Icon(Icons.cancel),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(bottom: 30),
                                  child: Text(
                                    "Tentukan Pesanan",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ))
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                    margin:
                                        EdgeInsets.only(left: 5, bottom: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            "${modelGetProduk.data[index].namaProduk}",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            softWrap: true,
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            "${modelGetProduk.data[index].detail[index].stok}",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    )),
                                Container(
                                    margin:
                                        EdgeInsets.only(right: 10, bottom: 10),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          "Harga",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        Text(
                                          "${formatCurrency.format(hargaProduct)}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            height: 1,
                            color: cGrey1,
                            margin: EdgeInsets.only(
                                top: 20, bottom: 20, left: 5, right: 5),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(
                                      left: 25, right: 5, bottom: 10),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                          margin: EdgeInsets.only(bottom: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                child: Text(
                                                  "VARIANT",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  softWrap: true,
                                                ),
                                              ),
                                              Expanded(
                                                child: ListView.separated(
                                                    shrinkWrap: true,
                                                    itemCount: modelGetProduk
                                                        .data[index]
                                                        .detail
                                                        .length,
                                                    scrollDirection: Axis.horizontal,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return GestureDetector(
                                                          child: Container(
                                                              width: 70,
                                                              child: ButtonTheme(
                                                                  child:
                                                                      RaisedButton(
                                                                child: Text(
                                                                  "${modelGetProduk.data[index].detail[index].satuan}",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white70,
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                              ))));
                                                    }),
                                              ),

                                            ],
                                          )),
                                    ],
                                  )),
                            ],
                          ),
                          Container(
                            height: 1,
                            color: cGrey1,
                            margin: EdgeInsets.only(
                                top: 20, bottom: 20, left: 5, right: 5),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                    margin:
                                        EdgeInsets.only(left: 5, bottom: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          child: const Text(
                                            "JUMLAH",
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            softWrap: true,
                                          ),
                                        ),
                                      ],
                                    )),
                                Container(
                                  margin: EdgeInsets.only(right: 30),
                                  child: new Center(
                                    child: new Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                            margin: EdgeInsets.only(right: 5),
                                            width: 40,
                                            height: 30,
                                            child: ButtonTheme(
                                                child: RaisedButton(
                                              child: Center(
                                                child: Text(
                                                  "-",
                                                  style: TextStyle(
                                                      color: Colors.white70,
                                                      fontSize: 20),
                                                ),
                                              ),
                                            ))),
                                        new Text('0',
                                            style: new TextStyle(fontSize: 16)),
                                        Container(
                                            margin: EdgeInsets.only(left: 5),
                                            width: 40,
                                            height: 30,
                                            child: ButtonTheme(
                                                child: RaisedButton(
                                              child: Text(
                                                "+",
                                                style: TextStyle(
                                                    color: Colors.white70,
                                                    fontSize: 20),
                                              ),
                                            ))),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                  child: RaisedButton(
                                color: cPrimary,
                                child: Text(
                                  "Masukkan Keranjang",
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 20),
                                ),
                              )),
                              Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: RaisedButton(
                                    child: Text(
                                      "Beli Sekarang",
                                      style: TextStyle(
                                          color: Colors.white70, fontSize: 20),
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ));
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("id pasar = ${widget.idPasar}, idKatProd = ${widget.idKategori}");
    _getProduct(widget.idPasar, widget.idKategori, widget.idSubKategori);
  }

  @override
  Widget build(BuildContext context) {
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

    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

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
      body: loadingSubKategori
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: <Widget>[
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: _listProduct.length,
                    itemBuilder: (BuildContext context, int index) {
                      var hargaKonsumen1, hargaKonsumen2;

                      var detail = modelGetProduct.data[index].detail;
                      var detailLength = detail.length;
                      print("LENGTH $detailLength");
                      hargaKonsumen1 =
                          modelGetProduct.data[index].detail[0].hargaKonsumen;
                      hargaProduct =
                          modelGetProduct.data[index].detail[0].hargaKonsumen;
                      if (detailLength > 1) {
                        hargaKonsumen1 =
                            modelGetProduct.data[index].detail[0].hargaKonsumen;
                        hargaKonsumen2 = modelGetProduct
                            .data[index].detail[detailLength - 1].hargaKonsumen;
                      } else {
                        hargaKonsumen1 = modelGetProduct
                            .data[index].detail[index].hargaKonsumen;
                      }

                      return new Container(
                          height: 160,
                          margin: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 24.0,
                          ),
                          child: new Stack(
                            children: <Widget>[
                              new Container(
                                child: Container(
                                  margin: new EdgeInsets.fromLTRB(
                                      16.0, 16.0, 76.0, 16.0),
                                  constraints: new BoxConstraints.expand(),
                                  child: new Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Container(height: 4.0),
                                      new Text(
                                          "${formatCurrency.format(hargaKonsumen1)} ${formatCurrency.format(hargaKonsumen2) != null ? "~ ${formatCurrency.format(hargaKonsumen2)}" : ""} ",
                                          style: headerTextStyle),
                                      new Container(height: 10.0),
                                      new Text(
                                          "${_listProduct[index].namaProduk}",
                                          style: subHeaderTextStyle),
                                      new Text(
                                          "${_listProduct[index].namaReseller}",
                                          style: subHeaderTextStyle),
                                      new Container(
                                          margin: new EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          height: 2.0,
                                          width: 20.0,
                                          color: new Color(0xff00c6ff)),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                      // ListView.builder(
                                      //     shrinkWrap: true,
                                      //     itemCount: detail.length,
                                      //     itemBuilder: (BuildContext context, int index) {
                                      //       return Text("${detail[index].hargaKonsumen}",
                                      //           style: subHeaderTextStyle);
                                      //
                                      //
                                      //     }
                                      // )
                                    ],
                                  ),
                                ),
                                margin: new EdgeInsets.only(right: 46.0),
                                decoration: new BoxDecoration(
                                  color: cPrimary,
                                  shape: BoxShape.rectangle,
                                  borderRadius: new BorderRadius.circular(8.0),
                                  boxShadow: <BoxShadow>[
                                    new BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 10.0,
                                      offset: new Offset(0.0, 10.0),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      displayBottomSheet(
                                          context, modelGetProduct, index);
                                    },
                                    child: new Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 16),
                                        width: 92.0,
                                        height: 92.0,
                                        decoration: new BoxDecoration(
                                            color: cWhite,
                                            shape: BoxShape.circle,
                                            image: new DecorationImage(
                                                fit: BoxFit.contain,
                                                image: new AssetImage(
                                                    "assets/images/add.png")))),
                                  ),
                                ],
                              ),
                            ],
                          ));
                    }),

                // Container(
                //   // height: 500.0,
                //   child: Expanded(
                //     child: GridView.count(
                //       crossAxisCount: 2,
                //       // childAspectRatio: (itemWidth / itemHeight),
                //       controller: ScrollController(keepScrollOffset: false),
                //       shrinkWrap: true,
                //       scrollDirection: Axis.vertical,
                //       padding: const EdgeInsets.all(4.0),
                //       children:  List.generate(
                //           _listProduct.length,
                //               (index) {
                //             return ProdukItem(productData: modelGetProduct ,index: index ,);
                //
                //           }).toList(),
                //     ),
                //   ),
                // )
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

// class ProdukItem extends StatelessWidget {
//   ProdukItem({Key key, @required this.productData, this.index, this.shape})
//       : assert(productData != null),
//         super(key: key);
//
//   // static const double height = 566.0;
//   final ModelGetProduk productData;
//   final int index;
//   final ShapeBorder shape;
//
//   @override
//   Widget build(BuildContext context) {
//     final ThemeData theme = Theme.of(context);
//     final TextStyle titleStyle =
//         theme.textTheme.headline.copyWith(color: Colors.white);
//     final TextStyle descriptionStyle = theme.textTheme.subhead;
//
//     return SafeArea(
//         // top: false,
//         // bottom: false,
//         child: Container(
//             padding: const EdgeInsets.all(4.0),
//             child: GestureDetector(
//               onTap: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => Item_Details()));
//               },
//               child: Card(
//                 child: Column(
//                   children: <Widget>[
//                     // photo and title
//                     SizedBox(
//                       child: Stack(
//                         children: <Widget>[
//                           Positioned.fill(
//                             child: Image.asset(
//                               "assets/images/apple.jpg",
//                               // package: destination.assetPackage,
//                               fit: BoxFit.scaleDown,
//                             ),
//                           ),
//                           Container(
//                             alignment: Alignment.topLeft,
//                             // padding: EdgeInsets.all(5.0),
//                             child: IconButton(
//                                 icon: const Icon(Icons.favorite_border),
//                                 onPressed: () {}),
//                           ),
//                         ],
//                       ),
//                     ),
//                     // description and share/explore buttons
//                     Expanded(
//                       child: Container(
//                         padding:
//                             const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
//                         child: DefaultTextStyle(
//                           style: descriptionStyle,
//                           child: Row(
//                             mainAxisSize: MainAxisSize.max,
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: <Widget>[
//                               // three line description
//                               Expanded(
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(bottom: 8.0),
//                                   child: Text(
//                                     productData.data[index].namaProduk,
//                                     style: descriptionStyle.copyWith(
//                                         color: Colors.black87),
//                                   ),
//                                 ),
//                               ),
//
//                               // Text(destination.description[1]),
//                               // Text(destination.description[2]),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     // Expanded(
//                     //   child: Container(
//                     //     padding:
//                     //     const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
//                     //     child: DefaultTextStyle(
//                     //       style: descriptionStyle,
//                     //       child: Row(
//                     //         mainAxisSize: MainAxisSize.max,
//                     //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     //         children: <Widget>[
//                     //           // three line description
//                     //           Text(
//                     //             subKategoriData.data[index].kategoriSeoSub,
//                     //             style: descriptionStyle.copyWith(
//                     //                 color: Colors.black87),
//                     //           ),
//                     //
//                     //           // Text(destination.description[1]),
//                     //           // Text(destination.description[2]),
//                     //         ],
//                     //       ),
//                     //     ),
//                     //   ),
//                     // ),
//                     // share, explore buttons
//                     // Container(
//                     //   alignment: Alignment.center,
//                     //   child: OutlineButton(
//                     //       borderSide: BorderSide(color: Colors.amber.shade500),
//                     //       child: const Text('Add'),
//                     //       textColor: Colors.amber.shade500,
//                     //       onPressed: () {
//                     //         Navigator.push(
//                     //             context,
//                     //             MaterialPageRoute(
//                     //                 builder: (context) => Item_Details()));
//                     //       },
//                     //       shape: OutlineInputBorder(
//                     //         borderRadius: BorderRadius.circular(30.0),
//                     //       )),
//                     // ),
//                   ],
//                 ),
//               ),
//             )));
//   }
// }
