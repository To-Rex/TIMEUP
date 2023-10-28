import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_up/api/api_controller.dart';
import 'package:time_up/elements/functions.dart';
import 'package:time_up/pages/professions_list_details.dart';
import '../res/getController.dart';

class ProfessionsListUsers extends StatelessWidget {
  final Function(String) onTap;

  ProfessionsListUsers({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    _getController.clearByCategory();
    ApiController().getByCategory(_getController.categoryByID.value).then((value) => _getController.changeByCategory(value));
    return Column(
      children: [
        SizedBox(
          child: GestureDetector(
            onTap: () {
              _getController.enters.value = 1;
            },
            child: Row(
              children: [
                SizedBox(width: w * 0.04),
                const Icon(Icons.arrow_back_ios),
                const Expanded(child: SizedBox()),
                Obx(() => _getController.titleListElements.value == ''
                    ? const Center(child: Text('No data'))
                    : Text(
                  _getController.titleListElements.value,
                  style: TextStyle(
                    fontSize: w * 0.05,
                    fontWeight: FontWeight.w500,
                  ),
                )),
                const Expanded(child: SizedBox()),
                SizedBox(width: w * 0.04),
              ],
            ),
          ),
        ),
        SizedBox(height: h * 0.02),
        SizedBox(
            height: h * 0.74,
            width: w * 0.9,
            child: ListView(
              children: [
                Obx(() => _getController.getByCategory.value.res == null || _getController.getByCategory.value.res!.isEmpty
                    ? const Center(child: Text('No data'))
                    : SizedBox(
                  height: h * 0.74,
                  width: w * 0.9,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          _getController.profileByID.value = _getController.getByCategory.value.res![index].businessId!;
                          _getController.clearProfileById();
                          ApiController().profileById(_getController.profileByID.value).then((value) => {_getController.changeProfileById(value),});
                          _getController.bookingBusinessGetListByID.value = _getController.getByCategory.value.res![index].businessId!;
                          _getController.nextPagesUserDetails.value = 0;
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ProfessionsListDetails()));
                        },
                        child: Column(
                          children: [
                            Row(
                              children: [
                                if (_getController.getByCategory.value.res?[index].photoUrl == null)
                                  SizedBox(
                                    width: w * 0.2,
                                    height: w * 0.2,
                                    child: const CircleAvatar(
                                      backgroundImage: AssetImage(
                                          'assets/images/doctor.png'),
                                    ),
                                  )
                                else
                                  SizedBox(
                                    width: w * 0.2,
                                    height: w * 0.2,
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage("http://${_getController.getByCategory.value.res![index].photoUrl}"),
                                    ),
                                  ),
                                SizedBox(width: w * 0.05),
                                //name and profession
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(_getController.getByCategory.value.res?[index].lastName ?? '',
                                      style: TextStyle(
                                        fontSize: w * 0.04,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(_getController.getByCategory.value.res?[index].fistName ?? '',
                                      style: TextStyle(
                                        fontSize: w * 0.04,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                const Expanded(child: SizedBox()),
                                Obx(() => _getController.getByCategory.value.res?[index].followed == true
                                    ? SizedBox(
                                  height: h * 0.045,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      ApiController().unFollow(_getController.getByCategory.value.res?[index].businessId ?? 0).then((value) =>{
                                        if(value == true) {
                                          Toast.showToast(context, 'UnFollow', Colors.green, Colors.white),
                                        }else{
                                          Toast.showToast(context, 'Error', Colors.red, Colors.white),
                                        }
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      backgroundColor: Colors.grey,
                                    ),
                                    child: Text('Following',
                                      style: TextStyle(
                                        fontSize: w * 0.04,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                                    : SizedBox(
                                  height: h * 0.045,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      ApiController().follow(_getController.getByCategory.value.res?[index].businessId ?? 0).then((value) =>{
                                        if(value.status == true) {
                                          Toast.showToast(context, 'Followed', Colors.green, Colors.white),
                                        }else{
                                          Toast.showToast(context, 'Error', Colors.red, Colors.white),
                                        }
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      backgroundColor: Colors.blue,
                                    ),
                                    child: Text('Follow',
                                      style: TextStyle(
                                        fontSize: w * 0.04,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )),
                              ],
                            ),
                            SizedBox(height: h * 0.02),
                          ],
                        ),
                      );
                    },
                    itemCount: _getController.getByCategory.value.res?.length ?? 0,
                  ),
                )),
              ],
            )),
      ],
    );
  }
}
