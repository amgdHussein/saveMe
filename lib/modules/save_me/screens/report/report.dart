import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_material_pickers/helpers/show_number_picker.dart';
import 'package:flutter_material_pickers/helpers/show_scroll_picker.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:save_me/config/themes/colors.dart';
import 'package:save_me/constants/app_constants.dart';
import 'package:save_me/modules/save_me/models/address/city.dart';
import 'package:save_me/modules/save_me/models/address/governorate.dart';
import 'package:save_me/modules/save_me/screens/report/bloc/report_bloc.dart';
import 'package:save_me/utils/helpers/image_pickers.dart';
import 'package:save_me/utils/mixins/validation_mixins.dart';
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
  final TextEditingController _pickerController = TextEditingController();
  final TextEditingController _governorateController = TextEditingController();
  String _governorateId = '1';
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
    _pickerController.addListener(_onPickerChange);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 60,
          width: MediaQuery.of(context).size.width,
          child: BlocConsumer<ReportBloc, ReportState>(
            listener: (context, state) {
              if (state is ReportStateLoading)
                return Center(
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(),
                  ),
                );
              if (state is ReportStateSuccess) {
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(builder: (context) => AppLayout()),
                // );
                Phoenix.rebirth(context);
              }
              if (state.isFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  FailureSnackBar(error: state.error),
                );
                _reportBloc.add(ReportError(error: null));
              }
            },
            builder: (context, state) {
              List<Widget> forms = [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ['finding'],
                    ['missing'],
                  ].map((items) {
                    return Column(
                      children: [
                        CircleAvatar(radius: 50),
                        SizedBox(height: 30),
                        GestureDetector(
                          onTap: () {
                            _typeController.text = items[0];
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              color: state.type == items[0]
                                  ? Theme.of(context).primaryColor
                                  : null,
                            ),
                            child: Text(
                              items[0].toUpperCase(),
                              style: TextStyle(
                                color: state.type == items[0]
                                    ? Theme.of(context).canvasColor
                                    : Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        keyboardType: TextInputType.name,
                        autocorrect: false,
                        decoration: InputDecoration(
                          labelText: "${capitalize(state.type)} Name",
                          suffixIcon: Icon(
                            Icons.person,
                            color: _nameController.text.isNotEmpty
                                ? Theme.of(context).primaryColor
                                : null,
                          ),
                        ),
                        validator: state.type == "missing"
                            ? Validators.isValidName
                            : null,
                      ),
                      customField(
                        title: "Gender",
                        input: state.gender,
                        suffixWidget: Row(
                          children: [
                            ['male', FontAwesomeIcons.mars],
                            ['female', FontAwesomeIcons.venus]
                          ].map((items) {
                            return IconButton(
                              icon: Icon(
                                items[1],
                                color: state.gender == items[0]
                                    ? Theme.of(context).primaryColor
                                    : null,
                              ),
                              onPressed: () {
                                _genderController.text = items[0];
                              },
                            );
                          }).toList(),
                        ),
                      ),
                      customField(
                        title: "Age",
                        input: state.age.toString(),
                        suffixWidget: IconButton(
                          icon: Icon(
                            Icons.panorama_horizontal_select,
                            color: state.age != null
                                ? Theme.of(context).primaryColor
                                : null,
                          ),
                          onPressed: () {
                            showMaterialNumberPicker(
                              context: context,
                              title: 'Pick The ${capitalize(state.type)} Age',
                              minNumber: 3,
                              maxNumber: 60,
                              step: 1,
                              confirmText: 'select'.toUpperCase(),
                              selectedNumber: state.age,
                              onChanged: (int value) {
                                _ageController.text = value.toString();
                              },
                            );
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey[700],
                              width: 1,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${capitalize(state.type)} Photo",
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 16,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      ['camera', Icons.camera_alt],
                                      ['gallery', Icons.image]
                                    ].map((items) {
                                      return Conditional.single(
                                        context: context,
                                        conditionBuilder: (context) =>
                                            state is ReportStateLoading &&
                                            state.picker == items[0],
                                        widgetBuilder: (context) => Container(
                                          height: 20,
                                          width: 20,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 14),
                                          child: CircularProgressIndicator(),
                                        ),
                                        fallbackBuilder: (context) =>
                                            IconButton(
                                          icon: Icon(
                                            items[1],
                                            color: state.picker == items[0]
                                                ? Theme.of(context).primaryColor
                                                : null,
                                          ),
                                          onPressed: () async {
                                            _pickerController.text = items[0];
                                            _imageController.text =
                                                items[0] == 'camera'
                                                    ? await imgFromCamera()
                                                    : await imgFromGallery();
                                          },
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                              if (state.image != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    right: 10,
                                    bottom: 10,
                                  ),
                                  child: Image.file(
                                    File(state.image),
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      FutureBuilder<List<Governorate>>(
                        future: _reportBloc.governorates(context),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return SizedBox.shrink();
                            default:
                              if (snapshot.hasError)
                                return Text('Error: ${snapshot.error}');
                              else {
                                return customField(
                                  title: "Governorate",
                                  input: state.governorate == null
                                      ? snapshot.data[0].governorateNameEnglish
                                      : state.governorate,
                                  suffixWidget: IconButton(
                                    icon: Icon(
                                      Icons.pin_drop,
                                      color: state.governorate != null
                                          ? Theme.of(context).primaryColor
                                          : null,
                                    ),
                                    onPressed: () {
                                      showMaterialScrollPicker<Governorate>(
                                        context: context,
                                        title: 'Pick Your Governorate',
                                        items: snapshot.data,
                                        selectedItem: snapshot.data[0],
                                        onChanged: (governorate) {
                                          _governorateId = governorate.id;
                                          _governorateController.text =
                                              governorate
                                                  .governorateNameEnglish;
                                        },
                                      );
                                    },
                                  ),
                                );
                              }
                          }
                        },
                      ),
                      FutureBuilder<List<City>>(
                        future: _reportBloc.governorateCities(
                            context, _governorateId),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return SizedBox.shrink();
                            default:
                              if (snapshot.hasError)
                                return Text('Error: ${snapshot.error}');
                              else {
                                return customField(
                                  title: "City",
                                  input: state.city == null
                                      ? snapshot.data[0].cityNameEnglish
                                      : state.city,
                                  suffixWidget: IconButton(
                                    icon: Icon(
                                      Icons.location_city_rounded,
                                      color: state.city != null
                                          ? Theme.of(context).primaryColor
                                          : null,
                                    ),
                                    onPressed: () {
                                      showMaterialScrollPicker<City>(
                                        context: context,
                                        title: 'Pick Your City',
                                        items: snapshot.data,
                                        selectedItem: snapshot.data[0],
                                        onChanged: (city) {
                                          _cityController.text =
                                              city.cityNameEnglish;
                                        },
                                      );
                                    },
                                  ),
                                );
                              }
                          }
                        },
                      ),
                      if (_typeController.text == "missing")
                        SizedBox(
                          height: 52,
                          child: DateTimeField(
                            format: DEFAULT_DATE_FORMAT,
                            controller: _dateController,
                            decoration: InputDecoration(
                              labelText: "When it happend?",
                              suffixIcon: Icon(
                                Icons.calendar_today,
                                color: _dateController.text.isNotEmpty
                                    ? Theme.of(context).primaryColor
                                    : null,
                              ),
                            ),
                            onShowPicker: (context, currentValue) {
                              return showDatePicker(
                                context: context,
                                firstDate: DateTime(1990),
                                initialDate: currentValue ?? DateTime.now(),
                                lastDate: DateTime.now(),
                              );
                            },
                          ),
                        ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        autocorrect: false,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: "Description",
                          suffixIcon: Icon(
                            Icons.description,
                            color: _descriptionController.text.isNotEmpty
                                ? Theme.of(context).primaryColor
                                : null,
                          ),
                        ),
                        onFieldSubmitted: (description) {
                          _descriptionController.text = description;
                        },
                      ),
                    ],
                  ),
                ),
              ];
              return Stack(
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
                    top: 80,
                    left: 50,
                    right: 50,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  Positioned(
                    top: 230,
                    left: 20,
                    right: 20,
                    child: Text(
                      FORM_HEADERS[state.page],
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          .copyWith(color: Colors.white),
                    ),
                  ),
                  Positioned(
                    top: 270,
                    left: 20,
                    right: 20,
                    child: Text(
                      FORM_SUBTITILES[state.page],
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 320,
                    left: 20,
                    right: 20,
                    bottom: 80,
                    child: PageView.builder(
                      controller: _boarderController,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: Center(
                            child: Form(
                              key: _formKeys[index],
                              // autovalidateMode: AutovalidateMode.always,
                              child: SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                child: forms[index],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: FORM_HEADERS.length,
                      onPageChanged: (int page) {
                        _pageController.text = page.toString();
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 30,
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
                            activeDotColor: Theme.of(context).primaryColor,
                            dotHeight: 10,
                            dotWidth: 10,
                          ),
                        ),
                        Row(
                          children: [
                            if (state.page > 0)
                              pageMoveButton(
                                onPressed: () => moveBackward(),
                                icon: Icons.arrow_back,
                              ),
                            SizedBox(width: 10),
                            pageMoveButton(
                              onPressed: () async {
                                if (state.page == 1 &&
                                    _formKeys[state.page]
                                        .currentState
                                        .validate() &&
                                    state.image.isNotEmpty)
                                  moveForward();
                                else if (state.page ==
                                    FORM_HEADERS.length - 1) {
                                  _onFormSubmitted();
                                } // submite
                                else if (_formKeys[state.page]
                                    .currentState
                                    .validate()) moveForward();
                              },
                              icon: state.page == FORM_HEADERS.length - 1
                                  ? Icons.done
                                  : Icons.arrow_forward,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
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
    _pickerController.dispose();
    super.dispose();
  }

  void _onNameChange() => _reportBloc.add(
        ReportNameChange(name: _nameController.text),
      );

  void _onDescriptionChange() => _reportBloc.add(
        ReportDescriptionChange(
          description: _descriptionController.text,
        ),
      );

  void _onPageChange() => _reportBloc.add(
        ReportPageChange(page: int.parse(_pageController.text)),
      );

  void _onTypeChange() => _reportBloc.add(
        ReportTypeChange(type: _typeController.text),
      );

  void _onGenderChange() => _reportBloc.add(
        ReportGenderChange(gender: _genderController.text),
      );

  void _onAgeChange() => _reportBloc.add(
        ReportAgeChange(age: int.parse(_ageController.text)),
      );

  void _onDateChange() => _reportBloc.add(
        ReportDateChange(date: DEFAULT_DATE_FORMAT.parse(_dateController.text)),
      );

  void _onImageChange() => _reportBloc.add(
        ReportImageChange(image: _imageController.text),
      );

  void _onGovernorateChange() => _reportBloc.add(
        ReportGovernorateChange(governorate: _governorateController.text),
      );

  void _onCityChange() => _reportBloc.add(
        ReportCityChange(city: _cityController.text),
      );

  void _onPickerChange() => _reportBloc.add(
        ReportPickerChange(picker: _pickerController.text),
      );

  void _onFormSubmitted() => _reportBloc.add(
        ReportSubmitted(
          name: _nameController.text,
          type: _typeController.text,
          description: _descriptionController.text,
          gender: _genderController.text,
          age: int.parse(_ageController.text),
          date: _dateController.text.isEmpty
              ? null
              : DEFAULT_DATE_FORMAT.parse(_dateController.text),
          governorate: _governorateController.text,
          city: _cityController.text,
          image: _imageController.text,
        ),
      );

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  Widget pageMoveButton({
    @required Function onPressed,
    @required IconData icon,
  }) =>
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
            color: Theme.of(context).canvasColor,
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );

  void moveForward() {
    _boarderController.nextPage(
      duration: Duration(milliseconds: 750),
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  void moveBackward() {
    _boarderController.previousPage(
      duration: Duration(milliseconds: 750),
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  Widget customField({
    @required String title,
    @required String input,
    @required Widget suffixWidget,
  }) =>
      Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey[700],
              width: 1,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: Text(
                      capitalize(input),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              suffixWidget
            ],
          ),
        ),
      );
}
