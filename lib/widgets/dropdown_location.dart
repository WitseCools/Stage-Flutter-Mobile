import 'package:flutter/material.dart';
import 'package:frontend/providers/Locations.dart';
import 'package:frontend/providers/TimeSheet.dart';
import '../Services/Services.dart';
import 'package:provider/provider.dart';
import '../widgets/custom_dropdown.dart';

class DropDownLocation extends StatefulWidget {
  DropDownLocation({Key key}) : super(key: key);

  @override
  _DropDownTaskState createState() => _DropDownTaskState();
}

class _DropDownTaskState extends State<DropDownLocation> {
  List<Locations> _locations;

  Locations _locationModel = Locations();
  List<DropdownMenuItem<Locations>> _locationModelList;
  List<DropdownMenuItem<Locations>> _buildTaskModelDropdown(
      List locationModelList) {
    List<DropdownMenuItem<Locations>> items = List();
    for (Locations locationModel in locationModelList) {
      items.add(DropdownMenuItem(
        value: locationModel,
        child: Text(locationModel.locationName),
      ));
    }
    return items;
  }

  _onChangeTaskDropdown(Locations locationModel) {
    setState(() {
      TimeSheet timeSheet = Provider.of<TimeSheet>(context, listen: false);
      _locationModel = locationModel;
      timeSheet.selectedLocation = _locationModel;
    });
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Services service = Provider.of<Services>(context, listen: false);
      service.getLocationsByEmployer().then((locations) {
        setState(() {
          _locations = locations;

          _locationModelList = _buildTaskModelDropdown(_locations);

          _locationModel = _locations.first;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "Locations",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 9),
          child: _locations != null
              ? CustomDropdown(
                  dropdownMenuItemList: _locationModelList,
                  onChanged: _onChangeTaskDropdown,
                  value: _locationModel,
                  isEnabled: true)
              : Text(
                  "No locations added",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
        ),
      ],
    );
  }
}
