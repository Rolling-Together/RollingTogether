import 'package:flutter/material.dart';

class LocationTile extends StatelessWidget {
  const LocationTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          "대연놀이터 앞에 턱 때문에 다침ㅠ",
          style: TextStyle(fontSize: 18),
        ),
        trailing:
        SizedBox(
          width: 50.0,
          height: 50.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(0.0),
            child: Image.network(
              'https://avatars.githubusercontent.com/u/113813770?s=400&u=c4addb4d0b81eabc9faef9f13adc3dea18ddf83a&v=4',
              fit: BoxFit.cover,
            ),
          ),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('턱이 있음'),
            Text('oo로 oo번길'),
            Text('02/26 oo시 oo분')
          ],
        ),
      ),
    );
  }
}
