import 'package:flutter/material.dart';
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/Quicke_Events/Screens/EventDetails/TicketDetailOrderScreen.dart';
import 'package:quickie_event/Quicke_Events/Widgets/TextFormWidget.dart';
import 'package:quickie_event/Quicke_Events/Widgets/TextWidget.dart';

class ContactInformationDetailScreen extends StatefulWidget {
  const ContactInformationDetailScreen({super.key});

  @override
  State<ContactInformationDetailScreen> createState() =>
      _ContactInformationDetailScreenState();
}

class _ContactInformationDetailScreenState
    extends State<ContactInformationDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isKeepMeUpdate=false;
  bool isSendMeEmail=false;
  bool isIAcceptTheTerms=false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        title: TextWidget(
          title: "Contact Information",
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
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                TextWidget(
                  title: "Full name*",
                  size: 14,
                  fontWeight: FontWeight.w600,
                  color: greyColor,

                ),
                SizedBox(
                  height: 20,
                ),
                textfieldProduct(context: context, name: "Name"),
                SizedBox(
                  height: 20,
                ),
                TextWidget(
                  title: "Email address*",
                  size: 14,
                  fontWeight: FontWeight.w600,
                  color: greyColor,
                ),
                SizedBox(
                  height: 20,
                ),
                textfieldProduct(context: context, name: "Email"),
                SizedBox(
                  height: 20,
                ),
                TextWidget(
                  title: "Phone Number*",
                  size: 14,
                  fontWeight: FontWeight.w600,
                  color: greyColor,
                ),
                SizedBox(
                  height: 20,
                ),
                textfieldProduct(context: context, name: "Phone"),
                SizedBox(
                  height: 20,
                ),
                CheckboxListTile(
                  title: Text(
                    "Keep me updated on more events and news from this event organizer.",
                    style: TextStyle(fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: greyColor,),),
                  value: isKeepMeUpdate,
                  onChanged: (newValue) {
                    setState(() {
                      isKeepMeUpdate = newValue!;

                    });
                  },
                  controlAffinity: ListTileControlAffinity
                      .leading, //  <-- leading Checkbox
                ),
             /*   ListTile(
                  leading: Checkbox(value: false, onChanged: (valuCheck) {}),
                  title: TextWidget(
                    title:
                    "Keep me updated on more events and news from this event organizer.",
                    size: 12,
                    maxline: 2,
                    fontWeight: FontWeight.w400,
                    color: greyColor,
                  ),
                ),*/
                // SizedBox(
                //   height: 5,
                // ),
                CheckboxListTile(
                  title: Text(
                    "Send me emails about the best events happening nearby or online",
                    style: TextStyle(fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: greyColor,),),
                  value: isSendMeEmail,
                  onChanged: (newValue) {
                    setState(() {
                        isSendMeEmail = newValue!;

                    });
                  },
                  controlAffinity: ListTileControlAffinity
                      .leading, //  <-- leading Checkbox
                ),
                CheckboxListTile(
                  title: Text(
                    "I accept the Eventer Terms of Service, Community Guidelines, and Privacy Policy.",
                    style: TextStyle(fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: greyColor,),),
                  value: isIAcceptTheTerms,
                  onChanged: (newValue) {
                    setState(() {
                      isIAcceptTheTerms = newValue!;

                    });
                  },
                  controlAffinity: ListTileControlAffinity
                      .leading, //  <-- leading Checkbox
                ),

              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: MaterialButton(
          color: appColor,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          minWidth: width,
          height: 50,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // If the form is valid, display a snackbar. In the real world,
              // you'd often call a server or save the information in a database.
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TicketDetailOrderScreen()));
            }
          },
          child: TextWidget(
            title: "Continue",
            size: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
