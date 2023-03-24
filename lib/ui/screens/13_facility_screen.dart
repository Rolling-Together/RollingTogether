import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rolling_together/commons/enum/facility_checklist.dart';
import 'package:rolling_together/commons/enum/facility_types.dart';
import 'package:rolling_together/commons/utils/facility_type_util.dart';
import 'package:rolling_together/data/remote/auth/controller/firebase_auth_controller.dart';
import 'package:rolling_together/data/remote/facility/controllers/facility_controller.dart';
import 'package:rolling_together/data/remote/facility/models/review.dart';
import 'package:rolling_together/data/remote/search_places/controllers/search_places_controller.dart';
import 'package:rolling_together/data/remote/search_places/models/places_response.dart';
import 'package:rolling_together/ui/screens/search_places/search_places_screen.dart';

import '../../data/remote/dangerous_zone/controllers/add_dangerous_zone_controller.dart';
import '../../data/remote/facility/models/facility.dart';

final TextEditingController reviewTextEditingController =
    TextEditingController();

class FacilityScreen extends StatefulWidget {
  const FacilityScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => UpdateFacilityScreenState();
}

class UpdateFacilityScreenState extends State<FacilityScreen> {
  final FacilityController facilityController = Get.put(FacilityController());
  final SearchPlacesController searchPlacesController =
      Get.put(SearchPlacesController());

  final AddDangerousZoneController addDangerousZoneController = Get.put(
      AddDangerousZoneController(),
      tag: AddDangerousZoneController.tag);

  @override
  void dispose() {
    facilityController.dispose();
    searchPlacesController.dispose();
    super.dispose();
  }

  Widget RegisterDialog() {
    return AlertDialog(
      title: Container(
        alignment: Alignment.center,
        child: const Text('등록되었습니다'),
      ),
      actions: [
        TextButton(
          child: const Text('확인'),
          onPressed: () {
            Get.back();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;

    if (arguments['latlng'] != null) {
      facilityController.latLng = arguments['latlng'];
    }

    return Obx(() => facilityController.updateFacilityResult.isTrue
        ? RegisterDialog()
        : Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    ///대분류
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.1,
                        left: MediaQuery.of(context).size.width * 0.05),
                    alignment: Alignment.centerLeft,
                    child: const Text('편의시설', style: TextStyle(fontSize: 16)),
                  ),
                  Column(
                    children: [
                      Container(

                          ///카테고리
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.01,
                              bottom:
                                  MediaQuery.of(context).size.height * 0.03),
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: const BoxDecoration(),
                          child: Obx(() => CategoryButton(
                              facilityType: FacilityTypeUtil.toEnum(
                                  facilityController.selectedPlace.value
                                          ?.categoryGroupCode ??
                                      "",
                                  facilityController
                                          .selectedPlace.value?.categoryName ??
                                      "")))),
                      Container(
                        padding: EdgeInsets.only(

                            left: MediaQuery.of(context).size.width * 0.05),
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () async {
                            final Place? result = await Get.to(
                                const SearchPlacesPage(),
                                arguments: {
                                  'latlng': facilityController.latLng
                                });
                            if (result == null) {
                            } else {
                              facilityController.selectedPlace.value = result;
                            }
                          },
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            height: 48.0,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                            child: Row(
                              children: const [
                                Icon(Icons.search),
                                SizedBox(width: 8.0),
                                Text('장소 검색하기',
                                    style: TextStyle(fontSize: 15.0)),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    padding:
                        EdgeInsets.all(MediaQuery.of(context).size.width * 0.2),
                    child: Text('지도 API'),
                  ),
                  Container(
                    ///주소
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05),
                    alignment: Alignment.centerLeft,
                    child: const Text('주소'),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05,
                        top: MediaQuery.of(context).size.height * 0.01),
                    alignment: Alignment.centerLeft,
                    child: Obx(() {
                      if (facilityController.selectedPlace.value != null) {
                        return Column(
                          children: [
                            Text(
                              facilityController.selectedPlace.value!.placeName,
                              style: const TextStyle(
                                color: Colors.black,

                              ),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              facilityController
                                  .selectedPlace.value!.addressName,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        );
                      } else {
                        return const Text('선택된 장소 없음');
                      }
                    }),
                  ),
                  Column(
                    //padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                    children: FacilityCheckListType.toList()
                        .map((e) => FacilityInfo(type: e))
                        .toList(),
                  ),
                  Container(
                    margin: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.05),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    child: TextField(
                      controller:
                          facilityController.reviewTextEditingController,
                      decoration: const InputDecoration(
                          focusedBorder: InputBorder.none),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.03),
                    child: OutlinedButton(
                      onPressed: () {
                        final facilityDto = FacilityDto(
                            placeId: facilityController.selectedPlace.value!.id,
                            name: facilityController
                                .selectedPlace.value!.placeName,
                            latlng: [
                              double.parse(
                                  facilityController.selectedPlace.value!.y),
                              double.parse(
                                  facilityController.selectedPlace.value!.x)
                            ],
                            categoryId: FacilityTypeUtil.toEnum(
                                    facilityController.selectedPlace.value
                                            ?.categoryGroupCode ??
                                        "",
                                    facilityController.selectedPlace.value
                                            ?.categoryName ??
                                        "")
                                .id,
                            categoryName: facilityController
                                .selectedPlace.value!.categoryName,
                            categoryGroupCode: facilityController
                                .selectedPlace.value!.categoryGroupCode,
                            categoryGroupName: facilityController
                                .selectedPlace.value!.categoryGroupName,
                            addressName: facilityController
                                .selectedPlace.value!.addressName,
                            roadAddressName: facilityController
                                .selectedPlace.value!.roadAddressName,
                            placeUrl: facilityController
                                .selectedPlace.value!.placeUrl,
                            informerId: AuthController.to.myUserDto.value!.id!,
                            informerName:
                                AuthController.to.myUserDto.value!.name,
                            checkListMap: {});

                        facilityController.updateFacility(
                            facilityDto, facilityController.newCheckListMap);

                        final placeId = facilityDto.placeId;

                        facilityController.addReview(
                            FacilityReviewDto(
                                userId: AuthController.to.myUserDto.value!.id!,
                                userName: AuthController.to.myUserDto.value!.name,
                                content: facilityController
                                    .reviewTextEditingController.text),
                            placeId);
                      },
                      child: const Text(
                        '등록',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ));
  }
}

///category_option버튼
const List<String> list = <String>['음식점', '카페', '공공시설', '문화시설'];

class CategoryButton extends StatefulWidget {
  final SharedDataCategory facilityType;

  const CategoryButton({Key? key, required this.facilityType})
      : super(key: key);

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
        child: Text(widget.facilityType.name)
        /*
      DropdownButton<String>(
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
      */

        );
  }
}

///image_picker방법2 >>나중에 합칠 때, util에 image_picker추가해야함
class ImageUploader extends StatefulWidget {
  final FacilityCheckListType type;

  const ImageUploader({Key? key, required this.type}) : super(key: key);

  @override
  State<ImageUploader> createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  final picker = ImagePicker();
  File? _image;

  final FacilityController facilityController = Get.find<FacilityController>();

  ///비동기 처리 >이미지 가져오기
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        facilityController.newCheckListMap[widget.type]?.files
            .add(File(pickedFile.path));
      });
    }
  }

  Widget _optionDialog() {
    return AlertDialog(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
              child: const Icon(Icons.add_a_photo),
              onPressed: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.camera);
              }),
          FloatingActionButton(
              child: const Icon(Icons.wallpaper),
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
      width: 30,
      height: 30,
      /*decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),*/
      child: _image == null
          ? InkWell(
              onTap: () =>
                  showDialog(context: context, builder: (_) => _optionDialog()),
              child: const Icon(Icons.camera_alt),
            )
          : Image.file(_image!),
    );
  }
}

///장소정보 >>여기서 오류난당~~
const option_list = <String>['선택', '예', '아니오'];

class FacilityInfo extends StatefulWidget {
  final FacilityCheckListType type;

  const FacilityInfo({Key? key, required this.type}) : super(key: key);

  @override
  State<FacilityInfo> createState() => _FacilityInfoState();
}

class _FacilityInfoState extends State<FacilityInfo> {
  int dropdownValues = 0;

  final FacilityController facilityController = Get.find<FacilityController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.05),
            child: Icon(widget.type.icon),
          ),
          Container(
            width: 120,
            margin:
                EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.2),
            child: Text(widget.type.description),
          ),
          Container(
            ///dropdownButton정렬하려고.. >해결해야함
            //alignment: Alignment.centerRight,
            child: DropdownButton<int>(
              isDense: true,
              //isExpanded: true,
              value: dropdownValues,
              icon: const Icon(Icons.arrow_drop_down),
              elevation: 16,
              onChanged: (int? idx) {
                setState(() {
                  dropdownValues = idx!;
                  facilityController.newCheckListMap[widget.type]?.status =
                      idx == 1 ? true : false;
                });
              },
              items:
                  List.generate(3, (index) => index).map<DropdownMenuItem<int>>(
                (idx) {
                  return DropdownMenuItem<int>(
                    value: idx,
                    child: Text(option_list[idx]),
                  );
                },
              ).toList(),
            ),
          ),
          Container(
            margin:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
            child: ImageUploader(
              type: widget.type,
            ),
          ),
        ],
      ),
    );
  }
}
