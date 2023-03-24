import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rolling_together/commons/enum/facility_checklist.dart';
import 'package:rolling_together/commons/utils/facility_type_util.dart';
import 'package:rolling_together/data/remote/auth/controller/firebase_auth_controller.dart';
import 'package:rolling_together/data/remote/facility/controllers/facility_controller.dart';
import 'package:rolling_together/data/remote/facility/models/checklist.dart';
import 'package:rolling_together/data/remote/facility/models/review.dart';
import 'package:rolling_together/data/remote/search_places/controllers/search_places_controller.dart';

import '../../../../data/remote/facility/models/facility.dart';

final TextEditingController reviewTextEditingController =
    TextEditingController();

class FacilityModificationScreen extends StatefulWidget {
  FacilityModificationScreen({Key? key}) : super(key: key);

  late FacilityDto editFacilityDto;

  @override
  State<StatefulWidget> createState() => UpdateFacilityScreenState();
}

class UpdateFacilityScreenState extends State<FacilityModificationScreen> {
  final FacilityController facilityController = Get.put(FacilityController());
  final SearchPlacesController searchPlacesController =
      Get.put(SearchPlacesController());

  @override
  void dispose() {
    facilityController.dispose();
    searchPlacesController.dispose();
    super.dispose();
  }

  Widget registerDialog() {
    return AlertDialog(
      title: Container(
        alignment: Alignment.center,
        child: const Text('수정 되었습니다'),
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
    widget.editFacilityDto = arguments['facilityDto'];

    for (final entry in widget.editFacilityDto.checkList.entries) {
      entry.value.imgUrls.clear();
      facilityController.newCheckListMap[entry.key] = entry.value;
    }

    return Obx(() => facilityController.updateFacilityResult.isTrue
        ? registerDialog()
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
                    child: Column(
                      children: [
                        Text(
                          facilityController.selectedPlace.value!.placeName,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          facilityController.selectedPlace.value!.addressName,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    //padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                    children: facilityController.newCheckListMap.values
                        .map((e) => FacilityInfo(
                              checkListDto: e,
                            ))
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
                                    widget.editFacilityDto.categoryGroupCode,
                                    widget.editFacilityDto.categoryName)
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
                                userName:
                                    AuthController.to.myUserDto.value!.name,
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
      ///if없어도 될 듯.어차피 !.로 null이 아님을 정해줘서
      setState(() {
        facilityController.newCheckListMap[widget.type]!.files
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
                Get.back();
                _pickImage(ImageSource.camera);
              }),
          FloatingActionButton(
              child: const Icon(Icons.wallpaper),
              onPressed: () {
                Get.back();
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

const options = <String>['선택', '예', '아니오'];

class FacilityInfo extends StatefulWidget {
  final FacilityCheckListDto checkListDto;

  const FacilityInfo({Key? key, required this.checkListDto}) : super(key: key);

  @override
  State<FacilityInfo> createState() => _FacilityInfoState();
}

class _FacilityInfoState extends State<FacilityInfo> {
  int dropdownValues = 2;
  final FacilityController facilityController = Get.find<FacilityController>();

  @override
  Widget build(BuildContext context) {
    dropdownValues = widget.checkListDto.status ? 1 : 2;

    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.05),
            child: Icon(widget.checkListDto.type.icon),
          ),
          Container(
            width: 120,
            margin:
                EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.2),
            child: Text(widget.checkListDto.type.description),
          ),
          DropdownButton<int>(
            isDense: true,
            //isExpanded: true,
            value: dropdownValues,
            icon: const Icon(Icons.arrow_drop_down),
            elevation: 16,
            onChanged: (int? idx) {
              setState(() {
                dropdownValues = idx!;
                facilityController.newCheckListMap[widget.checkListDto.type]
                    ?.status = idx == 1 ? true : false;
              });
            },
            items:
                List.generate(3, (index) => index).map<DropdownMenuItem<int>>(
              (idx) {
                return DropdownMenuItem<int>(
                  value: idx,
                  child: Text(options[idx]),
                );
              },
            ).toList(),
          ),
          Container(
            margin:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
            child: ImageUploader(
              type: widget.checkListDto.type,
            ),
          ),
        ],
      ),
    );
  }
}
