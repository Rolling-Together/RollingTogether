import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FacilityScreen extends StatelessWidget {
  const FacilityScreen({Key? key}) : super(key: key);

  Widget RegisterDialog(){
    return AlertDialog(
      title: Container(
        alignment: Alignment.center,
        child: Text('등록되었습니다'),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                ///대분류
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.1,
                    left: MediaQuery.of(context).size.width * 0.05),
                alignment: Alignment.centerLeft,
                child: Text('편의시설', style: TextStyle(fontSize: 16)),
              ),
              Container(
                ///카테고리
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.01,
                      bottom: MediaQuery.of(context).size.height * 0.03),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(),
                  child: CategoryButton()),
              Container(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05),
                alignment: Alignment.centerLeft,
                child: Text("주소 검색 창 위치"),
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
                child: Text('주소'),
              ),
              Container(
                ///주소 불러오는 값 임의로 지정해놨음
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                    top: MediaQuery.of(context).size.height * 0.01),
                alignment: Alignment.centerLeft,
                child: Text('부산광역시 남구 용소로 45, 부경대학교 대연캠퍼스'),
              ),
              Column(
                //padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                children: [
                  FacilityInfo(text: '휠체어 접근 가능성', icon: Icons.accessible),
                  FacilityInfo(text: '1층에 위치함', icon: Icons.looks_one),
                  FacilityInfo(text: '장애인 화장실', icon: Icons.wc),
                  FacilityInfo(text: '엘리베이터', icon: Icons.elevator),
                ],
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
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.03),
                child: OutlinedButton(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (_) => RegisterDialog(),
                  ),
                  child: Text(
                    '등록',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///category_option버튼
const List<String> list = <String>['음식점', '카페', '공공시설', '문화시설'];

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

///image_picker방법2 >>나중에 합칠 때, util에 image_picker추가해야함
class ImageUploader extends StatefulWidget {
  const ImageUploader({Key? key}) : super(key: key);
  @override
  State<ImageUploader> createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  File? _image;
  final picker = ImagePicker();

  ///비동기 처리 >이미지 가져오기
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != Null) {
      ///if없어도 될 듯.어차피 !.로 null이 아님을 정해줘서
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
      width: 30,
      height: 30,
      /*decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),*/
      child: _image == null
          ? InkWell(
        onTap: () =>
            showDialog(context: context, builder: (_) => _optionDialog()),
        child: Icon(Icons.camera_alt),
      )
          : Image.file(_image!),
    );
  }
}

///장소정보 >>여기서 오류난당~~
const List<String> option_list = <String>['선택', '예', '아니오'];

class FacilityInfo extends StatefulWidget {
  final String text;
  final IconData icon;
  const FacilityInfo({Key? key, required this.text, required this.icon})
      : super(key: key);

  @override
  State<FacilityInfo> createState() => _FacilityInfoState();
}

class _FacilityInfoState extends State<FacilityInfo> {
  String dropdownValues = option_list.first;

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
            child: Icon(this.widget.icon),
          ),
          Container(
            width: 120,
            margin:
            EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.2),
            child: Text(this.widget.text),
          ),
          Container(
            ///dropdownButton정렬하려고.. >해결해야함
//alignment: Alignment.centerRight,
            child: DropdownButton<String>(
              isDense: true,
              //isExpanded: true,
              value: dropdownValues,
              icon: const Icon(Icons.arrow_drop_down),
              elevation: 16,
              onChanged: (String? value) {
                setState(() {
                  dropdownValues = value!;
                });
              },
              items: option_list.map<DropdownMenuItem<String>>(
                    (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                },
              ).toList(),
            ),
          ),
          Container(
            margin:
            EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
            child: ImageUploader(),
          ),
        ],
      ),
    );
  }
}
