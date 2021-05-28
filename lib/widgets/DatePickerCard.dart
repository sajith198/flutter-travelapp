import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerCard extends StatelessWidget {
  final Function _selectStartDate;
  final Function _selectEndDate;
  final Function _showImageGallery;
  final DateTime startDate;
  final DateTime endDate;

  DatePickerCard(this.startDate, this.endDate, this._selectStartDate,
      this._selectEndDate, this._showImageGallery);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () => _selectStartDate(context),
                      child: Text('Select Start Date')),
                  TextButton(
                      onPressed: () => _selectEndDate(context),
                      child: Text('Select End Date')),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(DateFormat.yMd().format(startDate)),
                    Text(DateFormat.yMd().format(endDate)),
                  ],
                ),
              ),
              ElevatedButton.icon(
                onPressed: _showImageGallery,
                label: Text('Show Images'),
                icon: Icon(Icons.photo),
              )
            ],
          ),
        ),
      ),
    );
  }
}
