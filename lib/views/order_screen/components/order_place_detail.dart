import 'package:emart_app/consts/consts.dart';

Widget orderPlaceDetails({title1, title2, d1, d2}){
  return  Padding(
                  padding: const EdgeInsets.symmetric(horizontal:15.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "$title1".text.fontFamily(bold).make(),
                          "$d1".text.fontFamily(semibold).color(redColor).make(),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          "$title2".text.fontFamily(bold).color(darkFontGrey).make(),
                          "$d2".text.color(Colors.blue).make(),
                        ],
                      ),
                    ],
                  ),
                );
}