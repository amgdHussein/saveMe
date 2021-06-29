import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:save_me/config/themes/colors.dart';
import 'package:save_me/constants/app_constants.dart';
import 'package:save_me/modules/save_me/screens/report/bloc/report_bloc.dart';
import 'package:save_me/widgets/snack_bars/failure.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final PageController _boarderController = PageController(
    viewportFraction: 1,
    keepPage: true,
  );

  final List<GlobalKey<FormState>> _formKeys = [
    for (int i = 0; i < FORM_HEADERS.length; i++) GlobalKey<FormState>()
  ];

  final TextEditingController _pageController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _governorateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  ReportBloc _reportBloc;

  @override
  void initState() {
    super.initState();
    _reportBloc = BlocProvider.of<ReportBloc>(context);
    _nameController.addListener(_onNameChange);
    _pageController.addListener(_onPageChange);
    _descriptionController.addListener(_onDescriptionChange);
    _typeController.addListener(_onTypeChange);
    _ageController.addListener(_onAgeChange);
    _imageController.addListener(_onImageChange);
    _genderController.addListener(_onGenderChange);
    _dateController.addListener(_onDateChange);
    _governorateController.addListener(_onGovernorateChange);
    _cityController.addListener(_onCityChange);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReportBloc, ReportState>(
      listener: (context, state) {
        if (state is ReportStateLoading)
          return Center(
            child: SizedBox(
              height: 300,
              width: 300,
              child: CircularProgressIndicator(),
            ),
          );

        if (state is ReportStateFailure) FailureSnackBar(error: state.error);
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 400,
                child: Container(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Positioned(
                top: 60,
                right: 20,
                left: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmoothPageIndicator(
                      controller: _boarderController,
                      count: FORM_HEADERS.length,
                      effect: ExpandingDotsEffect(
                        dotColor: GRAY_CHATEAU,
                        activeDotColor: Theme.of(context).canvasColor,
                        dotHeight: 10,
                        dotWidth: 10,
                      ),
                    ),
                    Row(
                      children: [
                        if (state.page > 0)
                          pageMoveButton(
                            onPressed: () {
                              _boarderController.previousPage(
                                duration: Duration(milliseconds: 750),
                                curve: Curves.fastLinearToSlowEaseIn,
                              );
                            },
                            icon: Icons.arrow_back,
                          ),
                        SizedBox(width: 10),
                        pageMoveButton(
                          onPressed: () {
                            if (!_formKeys[state.page].currentState.validate())
                              _boarderController.nextPage(
                                duration: Duration(milliseconds: 750),
                                curve: Curves.fastLinearToSlowEaseIn,
                              );
                            else
                              ScaffoldMessenger.of(context).showSnackBar(
                                FailureSnackBar(error: 'No category selected!'),
                              );
                          },
                          icon: Icons.arrow_forward,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 100,
                left: 20,
                right: 20,
                bottom: 50,
                child: PageView.builder(
                  controller: _boarderController,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          FORM_HEADERS[index],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: Theme.of(context).canvasColor,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          // height: MediaQuery.of(context).size.height - 250,
                          child: Card(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Form(
                                key: _formKeys[index],
                                // ignore: deprecated_member_use
                                autovalidate: true,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <dynamic>[
                                    [
                                      'finding',
                                      Colors.green,
                                      FontAwesomeIcons.solidSmile,
                                    ],
                                    [
                                      'missing',
                                      Colors.redAccent,
                                      FontAwesomeIcons.solidFrown,
                                    ],
                                  ]
                                      .map(
                                        (items) => GestureDetector(
                                          onTap: () {
                                            _typeController.text = items[0];
                                          },
                                          child: Container(
                                            height: 100,
                                            width: 100,
                                            margin: const EdgeInsets.all(15.0),
                                            padding: const EdgeInsets.all(5.0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              color: state.type == items[0]
                                                  ? items[1]
                                                  : null,
                                              border: Border.all(
                                                color: items[1],
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Icon(
                                                  FontAwesomeIcons.solidFrown,
                                                  size: 50,
                                                  color: state.type == items[0]
                                                      ? Colors.white
                                                      : items[1]
                                                          .withOpacity(0.3),
                                                ),
                                                Text(
                                                  items[0].toUpperCase(),
                                                  style: TextStyle(
                                                    color:
                                                        state.type == items[0]
                                                            ? Colors.white
                                                            : items[1],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  itemCount: FORM_HEADERS.length,
                  onPageChanged: (int page) {
                    _pageController.text = page.toString();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _reportBloc = BlocProvider.of<ReportBloc>(context);
    _nameController.dispose();
    _descriptionController.dispose();
    _typeController.dispose();
    _ageController.dispose();
    _genderController.dispose();
    _dateController.dispose();
    _imageController.dispose();
    _governorateController.dispose();
    _cityController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onNameChange() =>
      _reportBloc.add(ReportNameChange(name: _nameController.text));

  void _onDescriptionChange() => _reportBloc.add(
        ReportDescriptionChange(
          description: _descriptionController.text,
        ),
      );

  void _onPageChange() => _reportBloc.add(
        ReportPageChange(page: int.parse(_pageController.text)),
      );

  void _onTypeChange() =>
      _reportBloc.add(ReportTypeChange(type: _typeController.text));

  void _onGenderChange() =>
      _reportBloc.add(ReportGenderChange(gender: _genderController.text));

  void _onAgeChange() =>
      _reportBloc.add(ReportAgeChange(age: int.parse(_ageController.text)));

  void _onDateChange() => _reportBloc
      .add(ReportDateChange(date: DateTime.parse(_dateController.text)));

  void _onImageChange() =>
      _reportBloc.add(ReportImageChange(image: _imageController.text));

  void _onGovernorateChange() => _reportBloc
      .add(ReportGovernorateChange(governorate: _governorateController.text));

  void _onCityChange() =>
      _reportBloc.add(ReportCityChange(city: _cityController.text));

  void _onFormSubmitted() => _reportBloc.add(
        ReportSubmitted(
          name: _nameController.text,
          type: _typeController.text,
          description: _descriptionController.text,
          gender: _genderController.text,
          age: int.parse(_ageController.text),
          date: DateTime.parse(_dateController.text),
          governorate: _governorateController.text,
          city: _cityController.text,
          image: _imageController.text,
        ),
      );

  Widget pageMoveButton(
          {@required Function onPressed, @required IconData icon}) =>
      SizedBox(
        height: 30,
        width: 30,
        child: FloatingActionButton(
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: Theme.of(context).primaryColor,
          ),
          backgroundColor: Theme.of(context).canvasColor,
        ),
      );
}

// TextFormField(
//   controller: _nameController,
//   keyboardType: TextInputType.name,
//   autocorrect: false,
//   decoration: InputDecoration(
//     border: OutlineInputBorder(
//       borderRadius:
//           BorderRadius.all(Radius.circular(10.0)),
//     ),
//     hintText: "Amgad Hussein Ahmed",
//   ),
//   validator: Validators.isValidUserName,
// ),

// SizedBox(
//   height: 52,
//   child: DateTimeField(
//     format: DateFormat("MMM d, yyyy"),
//     enabled: _typeController.text == "Missing",
//     controller: _dateController,
//     decoration: InputDecoration(
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.all(
//             Radius.circular(10.0)),
//       ),
//       hintText: "May 2, 2020",
//     ),
//     onShowPicker: (context, currentValue) {
//       return showDatePicker(
//         context: context,
//         firstDate: DateTime(1900),
//         initialDate:
//             currentValue ?? DateTime.now(),
//         lastDate: DateTime(2100),
//       );
//     },
//   ),
// ),
