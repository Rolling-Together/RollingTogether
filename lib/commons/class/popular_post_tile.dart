import 'package:flutter/material.dart';
import 'package:rolling_together/data/remote/dangerous_zone/models/dangerouszone.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../../config.dart';
import '../../ui/screens/14_dangerous_zone_post_screen.dart';
import 'firebase_storage.dart';

class PopularPostTile extends StatefulWidget {
  final DangerousZoneDto dangerousZoneDto;

  const PopularPostTile({Key? key, required this.dangerousZoneDto})
      : super(key: key);

  _PopularPostTileState createState() => _PopularPostTileState();
}

class _PopularPostTileState extends State<PopularPostTile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(DangerousZonePostScreen(), arguments: {'dangerousZoneDto':
        widget.dangerousZoneDto});
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.28,
        height: MediaQuery.of(context).size.width * 0.35,
        child: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.5,
                child: FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      return Image.network(
                        snapshot.data.toString(),
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      );
                    } else {
                      return const Icon(Icons.remove, size: 50);
                    }
                  },
                  future: widget.dangerousZoneDto.tipOffPhotos.isNotEmpty
                      ? getFirebaseStorageDownloadUrl(
                          'dangerouszones/${widget.dangerousZoneDto.tipOffPhotos[0]}')
                      : null,
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '위험',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.dangerousZoneDto.description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Text(
                    widget.dangerousZoneDto.addressName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    DateFormat('MM/dd HH:mm').format(
                      widget.dangerousZoneDto.dateTime.toDate(),
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
