import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';

Future<dynamic> tableOfContentsDialog(
    BuildContext context,
    List<String> pageTitles,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Table of Contents"),
          // listview to show page titles with page number
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: pageTitles.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    pageTitles[index],
                    style: AppTextstyles.googleInter700black28.copyWith(
                      fontSize: 16.sp,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop(index);
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }