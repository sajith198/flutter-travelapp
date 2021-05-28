import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:travelapp/widgets/AssetThumbnail.dart';
import 'package:travelapp/widgets/DatePickerCard.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  List<AssetEntity> assets;

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: startDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != startDate)
      setState(() {
        startDate = picked;
      });
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: endDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != endDate)
      setState(() {
        endDate = picked;
      });
  }

  Future<void> _showImageGallery() async {
    var result = await PhotoManager.requestPermissionExtend();
    if (result.isAuth) {
      List<AssetPathEntity> list = await PhotoManager.getAssetPathList(
          filterOption: FilterOptionGroup(
              createTimeCond: DateTimeCond(max: endDate, min: startDate)));

      AssetPathEntity data = list[0];
      List<AssetEntity> imageList = await data.assetList;
      setState(() {
        assets = imageList;
      });
    } else {
      PhotoManager.openSetting();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Travel App'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DatePickerCard(startDate, endDate, _selectStartDate,
                  _selectEndDate, _showImageGallery),
              SizedBox(
                height: 10,
              ),
              Text(
                'Photos & Videos',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Theme.of(context).primaryColor),
              ),
              if (assets != null)
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    height: 400,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemCount: assets.length,
                      itemBuilder: (_, index) {
                        return AssetThumbnail(asset: assets[index]);
                      },
                    ),
                  ),
                )
            ],
          ),
        ));
  }
}
