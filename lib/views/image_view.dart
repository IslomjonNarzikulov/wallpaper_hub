import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class ImageView extends StatefulWidget {
  const ImageView({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  var filePath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                widget.imageUrl,
                fit: BoxFit.cover,
              )),
             Container(
               height: MediaQuery.of(context).size.height,
               width: MediaQuery.of(context).size.width,
               alignment: Alignment.bottomCenter,
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.end,
                 children: [
                   GestureDetector(
                     onTap: (){
                     _save();
                   },
                     child: Stack(
                       children: [
                         Container(
                           height: 50,
                           decoration: BoxDecoration(
                             color: Color(0xff1C1B1B).withOpacity(0.8),
                             borderRadius: BorderRadius.circular(30),
                           ),
                           width: MediaQuery.of(context).size.width/2,
                         ),
                         Container(
                           height: 50,
                           width: MediaQuery.of(context).size.width/2,
                           decoration:  BoxDecoration(
                             border: Border.all(color: Colors.white54,width: 2),
                             borderRadius: BorderRadius.circular(30),
                             gradient:const LinearGradient(
                               colors: [
                                 Color(0x36FFFFFF),
                                 Color(0x0FFFFFF),
                               ],
                             ),
                           ),
                           child:const  Column(
                             children: [
                               Text('Set Wallpaper',style: TextStyle(fontSize: 14,color: Colors.white),),
                               Text('Image will be saved',style: TextStyle(fontSize: 14,color: Colors.white))
                             ],
                           ),
                         ),
                       ],
                     ),
                   ),

                   const SizedBox(height: 24,),
                   GestureDetector(
                     onTap: (){
                       Navigator.pop(context);
                     },
                     child:const Text('Cancel',style: TextStyle(color: Colors.white),
                     ),
                   ),
                   const SizedBox(height: 50,)
                 ],
               ),
             )
           ],
      ),
    );
  }
  _save () async{
// if(Platform.isAndroid) {
//   await _askPermission();
// }
  var response = await Dio().get(widget.imageUrl,
      options: Options(responseType: ResponseType.bytes));
  final result =
  await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
  print(result);
  Navigator.pop(context);
}
  }

 // _askPermission () async{
 //  if(Platform.isIOS) {
 //    Map<Permission, PermissionStatus> permissions =
 //        await PermissionHandler().requestPermission([Permission.photos]);
 //
 //  }else{
 //    PermissionStatus permission = await PermissionHandler().checkPermissionStatus(Permission.storage);
 //  }
 //}

