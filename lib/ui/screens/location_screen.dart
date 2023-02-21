import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  Widget RegisterDialog() {
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
        ///textfield가 늘어남에 따라 스크롤 가능하게
        child: Container(
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
              Container(

                  ///카테고리
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.01,
                      bottom: MediaQuery.of(context).size.height * 0.03),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(),
                  child: CategoryButton()),
              /*Row(children: [
                Column(
                  children: List.generate(imageUploaders.length, (index) {
                    return imageUploaders[index];
                  }),
                ),*/
                ImageUploader(),
              //]),
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

///category_option 버튼
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
      ///나중에 category 디자인 필요할 때 쓰려고 Container에 담아두고 decoration 부여
      /*decoration: BoxDecoration(
        color: Colors.blueGrey,
      ),*/
      child: DropdownButton<String>(
        ///underline 안보이게 할 때
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

///image_picker 방법2
class ImageUploader extends StatefulWidget {
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

}
