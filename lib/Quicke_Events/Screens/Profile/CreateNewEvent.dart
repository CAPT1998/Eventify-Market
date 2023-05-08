import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/Quicke_Events/Models/GetCategoryModel.dart';
import 'package:quickie_event/Quicke_Events/Providers/EventsProvider.dart';
import 'package:quickie_event/Quicke_Events/Widgets/TextFormWidget.dart';
import 'package:quickie_event/Quicke_Events/Widgets/TextWidget.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'widgets/SearchTextWidget.dart';

class CreateNewEvents extends StatefulWidget {
  CreateNewEvents({super.key, required this.model});
  GetCategoryModel model;
  @override
  State<CreateNewEvents> createState() => _CreateNewEventsState();
}

class _CreateNewEventsState extends State<CreateNewEvents> {
  TextEditingController eventTitle = TextEditingController();
  TextEditingController eventStartDate = TextEditingController();
  TextEditingController eventEndDate = TextEditingController();
  TextEditingController eventEventStartTime = TextEditingController();
  TextEditingController eventEventEndTime = TextEditingController();
  TextEditingController eventLocation = TextEditingController();
  TextEditingController eventAbout = TextEditingController();
  RoundedLoadingButtonController buttonController =
      RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Consumer<EventProvider>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: TextWidget(
            title: "Create Private Event",
            size: 14,
            fontWeight: FontWeight.w600,
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: greyColor,
              )),
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.more_horiz_outlined,
                  color: greyColor,
                ))
          ],
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      height: height * 0.2,
                      width: width * 0.8,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey)),
                      child: InkWell(
                        onTap: () async {
                          final result = await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowMultiple: false,
                              allowedExtensions: [
                                'png',
                                'jpg',
                              ],
                              allowCompression: true,
                              withData: true);

                          if (result != null && result.files.isNotEmpty) {
                            final fileBytes = result.files.first.bytes;
                            final fileName = result.files.first.name;
                            var path = "public/images/events/";
                            value.eventFile = File(result.files[0].path!);
                            value.muppdateeventBytes(
                                fileName, fileBytes, value.eventFile!);
                          }
                        },
                        child: value.eventFileBytes != null
                            ? Image.memory(value.eventFileBytes)
                            : Icon(
                                Icons.add,
                                size: 50,
                              ),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  textfieldProduct(
                      context: context,
                      name: "Event Title",
                      controller: eventTitle),
                  SizedBox(
                    height: 10,
                  ),
                  textfieldProduct(
                      context: context,
                      name: "Event Start Date",
                      controller: eventStartDate,
                      suffixIcon: IconButton(
                          onPressed: () async {
                            DateTime selectedDate = DateTime.now();
                            final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: selectedDate,
                                firstDate: DateTime(1901, 1),
                                lastDate: DateTime(2100));
                            if (picked != null && picked != selectedDate)
                              setState(() {
                                selectedDate = picked;
                                eventStartDate.value = TextEditingValue(
                                    text: picked.toString().split(' ')[0]);
                              });
                          },
                          icon: Icon(Icons.calendar_month))),
                  SizedBox(
                    height: 10,
                  ),
                  textfieldProduct(
                    context: context,
                    name: "Event End Date",
                    controller: eventEndDate,
                    suffixIcon: IconButton(
                      onPressed: () async {
                        DateTime selectedDate = DateTime.now();
                        final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime(1901, 1),
                            lastDate: DateTime(2100));
                        if (picked != null && picked != selectedDate)
                          setState(() {
                            selectedDate = picked;
                            eventEndDate.value = TextEditingValue(
                                text: picked.toString().split(' ')[0]);
                          });
                      },
                      icon: Icon(Icons.calendar_month),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  textfieldProduct(
                      context: context,
                      name: "Event Start Time",
                      controller: eventEventStartTime,
                      suffixIcon: IconButton(
                          onPressed: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              initialTime: TimeOfDay.now(),
                              context: context, //context of current state
                            );

                            if (pickedTime != null) {
                              print(
                                  pickedTime.format(context)); //output 10:51 PM
                              setState(() {
                                eventEventStartTime.value = TextEditingValue(
                                    text: pickedTime.format(context));
                              });
                            } else {
                              print("Time is not selected");
                            }
                          },
                          icon: Icon(Icons.timer_sharp))),
                  SizedBox(
                    height: 10,
                  ),
                  textfieldProduct(
                      context: context,
                      name: "Event End Time",
                      controller: eventEventEndTime,
                      suffixIcon: IconButton(
                          onPressed: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              initialTime: TimeOfDay.now(),
                              context: context, //context of current state
                            );

                            if (pickedTime != null) {
                              print(
                                  pickedTime.format(context)); //output 10:51 PM
                              setState(() {
                                eventEventEndTime.value = TextEditingValue(
                                    text: pickedTime.format(context));
                              });
                            } else {
                              print("Time is not selected");
                            }
                          },
                          icon: Icon(Icons.timer_sharp))),
                 
                  SizedBox(
                    height: 10,
                  ),
                  SearchBarWidget(),
                  SizedBox(
                    height: 10,
                  ),
                  textfieldProduct(
                      context: context,
                      name: "About",
                      maxline: 4,
                      controller: eventAbout),
                  SizedBox(
                    height: 50,
                  ),
                  RoundedLoadingButton(
                      color: appColor,
                      borderRadius: 10,
                      controller: buttonController,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (value.eventFileBytes != null) {
                            await value.mCreatePrivateEvent(
                                eventTitle: eventTitle.text,
                                eventStartDate: eventStartDate.text,
                                eventEndDate: eventEndDate.text,
                                eventEventStartTime: eventEventStartTime.text,
                                eventEventEndTime: eventEventEndTime.text,
                                eventLocation: value.eventLocation.text,
                                eventAbout: eventAbout.text);
                            if (value.checkMessageEventCreate == "success") {
                              buttonController.success();
                              SuccessFlushbar(
                                  context, "Event", "Event Create SuccessFull");
                              Timer(Duration(seconds: 2), () {
                                buttonController.reset();
                                Navigator.pop(context);
                                Navigator.pop(context);
                              });
                            } else {
                              buttonController.error();
                              ErrorFlushbar(context, "Event",
                                  "Event Create unsuccessfull please try again later");
                              Timer(Duration(seconds: 2), () {
                                buttonController.reset();
                              });
                            }
                          } else {
                            buttonController.error();
                            ErrorFlushbar(context, "Image",
                                "Please Select the image first...");
                            Timer(Duration(seconds: 2), () {
                              buttonController.reset();
                            });
                          }
                          // value.mCreatePrivateEvent();
                        } else {
                          buttonController.reset();
                        }
                      },
                      child: TextWidget(
                        title: "Create Private Event",
                        size: 18,
                        color: Colors.white,
                      )),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
