import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rolling_together/commons/enum/facility_types.dart';
import 'package:rolling_together/data/remote/auth/controller/firebase_auth_controller.dart';
import 'package:rolling_together/data/remote/dangerous_zone/controllers/add_dangerous_zone_controller.dart';
import 'package:rolling_together/data/remote/dangerous_zone/models/dangerouszone.dart';
import 'package:rolling_together/data/remote/map/controller/my_map_controller.dart';
import 'package:rolling_together/data/remote/reverse_geocoding/controllers/reverse_geocoding_controller.dart';

class LocationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final AddDangerousZoneController addDangerousZoneController = Get.put(
      AddDangerousZoneController(),
      tag: AddDangerousZoneController.tag);

  final ReverseGeocodingController reverseGeocodingController =
      Get.put(ReverseGeocodingController());

  final TextEditingController descriptionController = TextEditingController();

  final MyMapController myMapController = Get.find<MyMapController>();

  @override
  void dispose() {
    addDangerousZoneController.dispose();
    reverseGeocodingController.dispose();
    super.dispose();
  }

  Widget RegisterDialog() {
    return AlertDialog(
      title: Container(
        alignment: Alignment.center,
        child: Text('등록되었습니다'),
      ),
      actions: [
        TextButton(
          child: Text('확인'),
          onPressed: () {
            Get.back();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = AuthController.to.myUserDto.value;

    if (user != null && addDangerousZoneController.latlng.isEmpty) {
      final LatLng latlng = LatLng(myMapController.currentCoords.first,
          myMapController.currentCoords.last);

      addDangerousZoneController
          .initData([latlng.latitude, latlng.longitude], user.id!, user.name);

      reverseGeocodingController.coordToAddress(
          latlng.latitude, latlng.longitude);
    }

    return Scaffold(body: Obx(() {
      if (addDangerousZoneController.addNewDangerousZoneResult.isTrue) {
        myMapController.onChangedSelectedCategory(
            [SharedDataCategory.dangerousZone], true);
        return RegisterDialog();
      } else {
        return SingleChildScrollView(
          ///textfield가 늘어남에 따라 스크롤 가능하게
          child: Column(
            children: [
              Container(
                ///대분류
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.1,
                    left: MediaQuery.of(context).size.width * 0.05),
                alignment: Alignment.centerLeft,
                child: Text('위험 장소', style: TextStyle(fontSize: 16)),
              ),
              /* Container(

                  ///카테고리
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.01,
                      bottom: MediaQuery.of(context).size.height * 0.03),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(),
                  child: CategoryButton()),*/
              /*Row(children: [
              Column(
                children: List.generate(imageUploaders.length, (index) {
                  return imageUploaders[index];
                }),
              ),*/
              ImageUploader(),
              //]),
              Container(
                height: 150,
                margin:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                child: Stack(
                  children: [
                    GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(addDangerousZoneController.latlng[0],
                            addDangerousZoneController.latlng[1]),
                        zoom: 18,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Center(
                        child: Image.asset('assets/images/center_circle.png',
                            color: Colors.blueGrey, width: 26, height: 26),
                      ),
                    ),
                  ],
                ),
              ),
              Container(

                  ///주소
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05),
                  alignment: Alignment.centerLeft,
                  child: Text('주소')),
              Container(
                ///주소 불러오는 값 임의로 지정해놨음
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                    top: MediaQuery.of(context).size.height * 0.01),
                alignment: Alignment.centerLeft,
                child: Obx(() {
                  if (reverseGeocodingController.addressResult.value == null) {
                    return const Text('주소 로드 실패');
                  } else {
                    final document =
                        reverseGeocodingController.addressResult.value!;
                    String addressName = document.address.addressName;
                    return Text(addressName);
                  }
                }),
              ),
              Container(
                margin:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: TextField(
                  decoration: InputDecoration(focusedBorder: InputBorder.none),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: descriptionController,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.03),
                child: OutlinedButton(
                  onPressed: () {
                    addDangerousZoneController.addDangerousZone(
                        DangerousZoneDto(
                            categoryId: '0',
                            description: descriptionController.text,
                            latlng: addDangerousZoneController.latlng,
                            informerId:
                                addDangerousZoneController.myUIdInFirebase,
                            tipOffPhotos: [],
                            likes: [],
                            likeCounts: 0,
                            addressName: reverseGeocodingController
                                .addressResult.value!.address.addressName,
                            informerName:
                                addDangerousZoneController.myUserName),
                        addDangerousZoneController.imageList);
                  },
                  child: Text(
                    '등록',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    }));
  }
}

///category_option버튼
const List<String> list = <String>['턱이 있음', '경사로가 높음', '사고 위험 있음'];

class CategoryButton extends StatefulWidget {
  const CategoryButton({Key? key}) : super(key: key);

  @override
  State<CategoryButton> createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Container(
      ///나중에 category디자인 필요할 때 쓰려고 Container에 담아두고 decoration부여
/*decoration: BoxDecoration(
        color: Colors.blueGrey,
      ),*/
      child: DropdownButton<String>(
        ///underline안보이게 할 때
//underline: SizedBox.shrink(),
        isExpanded: true,
        value: dropdownValue,
        icon: const Icon(Icons.arrow_drop_down),
        elevation: 16,
        onChanged: (String? value) {
          setState(() {
            dropdownValue = value!;
          });
        },
        items: list.map<DropdownMenuItem<String>>(
          (String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          },
        ).toList(),
      ),
    );
  }
}

///image_picker방법2
/*class ImageUploader extends StatefulWidget {
  const ImageUploader({Key? key}) : super(key: key);

  @override
  State<ImageUploader> createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  File? _image;
  final picker = ImagePicker();

  ///비동기 처리 > 이미지 가져오기
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != Null) {
      ///if없어도 될 듯. 어차피 !.로 null이 아님을 정해줘서
      setState(() {
        _image = File(pickedFile!.path);
      });
    }
  }

  Widget _optionDialog() {
    return AlertDialog(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
              child: Icon(Icons.add_a_photo),
              onPressed: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.camera);
              }),
          FloatingActionButton(
              child: Icon(Icons.wallpaper),
              onPressed: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.gallery);
              }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
      child: _image == null
          ? InkWell(
              onTap: () =>
                  showDialog(context: context, builder: (_) => _optionDialog()),
              child: Icon(Icons.camera_alt),
            )
          : Image.file(_image!),
    );
  }

/*Widget showImage() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
      child: _image == null
          ? InkWell(
              onTap: () => _pickImage(ImageSource.camera),
              child: Icon(Icons.camera_alt),
            )
          : Image.file(_image!),
    );
  }*/

}*/

class ImageUploader extends StatefulWidget {
  const ImageUploader({Key? key}) : super(key: key);

  @override
  _ImageUploaderState createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  final AddDangerousZoneController dangerousZoneController =
      Get.find(tag: AddDangerousZoneController.tag);

  final picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        dangerousZoneController.imageList.add(File(pickedFile.path));
      } else {
        print('No image selected.');
      }
    });
  }

  Widget _optionDialog() {
    return AlertDialog(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
              child: Icon(Icons.add_a_photo),
              onPressed: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.camera);
              }),
          FloatingActionButton(
              child: Icon(Icons.wallpaper),
              onPressed: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.gallery);
              }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
          child: InkWell(
            child: Icon(Icons.camera_alt),
            onTap: () =>
                showDialog(context: context, builder: (_) => _optionDialog()),
          ),
          //child: Icon(Icons.camera_alt),
        ),
        /*ElevatedButton(
          onPressed: _pickImage(),
          child: Text('Add Image'),
        ),*/
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 3,
          children:
              List.generate(dangerousZoneController.imageList.length, (index) {
            return Image.file(
              dangerousZoneController.imageList[index],
              fit: BoxFit.cover,
            );
          }),
        ),
      ],
    );
  }
}
