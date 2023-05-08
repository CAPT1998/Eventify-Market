import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/Quicke_Events/Providers/CategoryProvider.dart';
import 'package:quickie_event/Quicke_Events/Screens/Profile/CreateNewEvent.dart';
import 'package:quickie_event/Quicke_Events/Widgets/TextWidget.dart';

class SelectCategoryByCreateEvent extends StatefulWidget {
  const SelectCategoryByCreateEvent({super.key});

  @override
  State<SelectCategoryByCreateEvent> createState() =>
      _SelectCategoryByCreateEventState();
}

class _SelectCategoryByCreateEventState
    extends State<SelectCategoryByCreateEvent> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CategoryPRovider>(context, listen: false).mGetCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryPRovider>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: TextWidget(
            title: "Select Category",
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
          // actions: [
          //   IconButton(
          //       onPressed: () {},
          //       icon: Icon(
          //         Icons.more_horiz_outlined,
          //         color: greyColor,
          //       ))
          // ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                value.checkValueCategory == true
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: value.getcategoryMode.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CreateNewEvents(
                                            model: value.getcategoryMode[index],
                                          )));
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                              ),
                              child: ListTile(
                                title: TextWidget(
                                    title:
                                        "${value.getcategoryMode[index].eventCatName}",
                                    size: 18),
                                trailing: Icon(Icons.arrow_forward_ios),
                              ),
                            ),
                          );
                        })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
