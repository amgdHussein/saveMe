import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../utils/mixins/validation_mixins.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen>
    with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  RangeValues _rangeValues = RangeValues(10, 15);
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 60,
              child: Stack(
                children: [
                  Positioned(
                    top: 50,
                    left: 50,
                    right: 50,
                    height: 50,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      child: TabBar(
                        controller: _tabController,
                        labelColor: Theme.of(context).canvasColor,
                        unselectedLabelColor: Theme.of(context).primaryColor,
                        labelStyle: TextStyle(
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.bold,
                        ),
                        indicatorPadding: EdgeInsets.all(10),
                        indicator: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        tabs: [
                          Tab(text: "Missing"),
                          Tab(text: "Finding"),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 120,
                    left: 20,
                    right: 20,
                    bottom: 20,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        ReportFrom(context),
                        // ReportFrom(context),
                        Container(
                          color: Colors.green,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget ReportFrom(context) {
    return Card(
      color: Theme.of(context).canvasColor,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 80.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.redAccent,
                            size: 10,
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: _nameController,
                        keyboardType: TextInputType.name,
                        autocorrect: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          hintText: "Amgad Hussein Ahmed",
                        ),
                        validator: Validators.isValidUserName,
                        onChanged: (name) {
                          _nameController.text = name;
                          _nameController.selection =
                              TextSelection.fromPosition(
                            TextPosition(
                              offset: _nameController.text.length,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 80.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Gender",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.redAccent,
                            size: 10,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 52,
                        child: DropdownSearch<String>(
                          mode: Mode.MENU,
                          maxHeight: 120,
                          showSelectedItem: true,
                          dropdownSearchDecoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.arrow_drop_down_rounded,
                              size: 30,
                              color: Theme.of(context).primaryColor,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            isDense: true,
                            // hintText: "Amgad Hussein Ahmed",
                          ),
                          dropDownButton: SizedBox.shrink(),
                          items: ["Male", "Female"],
                          hint: "gender in menu mode",
                          onChanged: print,
                          selectedItem: "Male",
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 80.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Range Age",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.redAccent,
                            size: 10,
                          ),
                        ],
                      ),
                      RangeSlider(
                        values: _rangeValues,
                        min: 4,
                        max: 60,
                        divisions: 15,
                        labels: RangeLabels(
                          _rangeValues.start.round().toString(),
                          _rangeValues.end.round().toString(),
                        ),
                        onChanged: (RangeValues range) {
                          setState(() {
                            _rangeValues = range;
                          });
                        },
                        // onChangeEnd: (RangeValues range) {},
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 80.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "City",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.redAccent,
                            size: 10,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 52,
                        child: DropdownSearch<String>(
                          mode: Mode.DIALOG,
                          maxHeight: 400,
                          showSelectedItem: true,
                          dropdownSearchDecoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.arrow_drop_down_rounded,
                              size: 30,
                              color: Theme.of(context).primaryColor,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            isDense: true,
                            // hintText: "Amgad Hussein Ahmed",
                          ),
                          dropDownButton: SizedBox.shrink(),
                          showSearchBox: true,
                          searchBoxDecoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.search_sharp,
                              size: 30,
                              color: Theme.of(context).primaryColor,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            isDense: true,
                          ),
                          // items: eg,
                          // onFind: (String filter) => null,
                          hint: "Egypt city list.",
                          onChanged: print,
                          selectedItem: "Port Said",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(20.0),
//                   ),
//                 ),
//                 child: Icon(
//                   Icons.photo,
//                   size: 100,
//                 ),
//               ),