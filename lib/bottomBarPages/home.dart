import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heroicons/heroicons.dart';
import 'package:time_up/api/api_controller.dart';
import '../pages/login_page.dart';
import '../pages/professions_list_details.dart';
import '../res/getController.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final GetController _getController = Get.put(GetController());

  showDialogs(BuildContext context,text,disc,ok,int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(
          child: Text(text, style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04),),
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.05,
          child: Center(
            child: Text(disc, style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04),),
          ),
        ),
        actions: [
          Center(
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.32,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 1,
                        backgroundColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ))),
                ),
                const Expanded(child: SizedBox()),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.32,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: () {
                        if(index == 1){
                          FlutterPhoneDirectCaller.callNumber(text);
                          Navigator.pop(context);
                        }else if(index == 2){
                          Navigator.pop(context);
                        }else{
                          Navigator.pop(context);
                        }
                      },
                      child: Row(
                        children: [
                          const Expanded(child: SizedBox()),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                          Text(ok,
                              style: TextStyle(
                                fontSize:
                                MediaQuery.of(context).size.width * 0.035,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              )),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                          const Icon(Icons.check, color: Colors.white),
                          const Expanded(child: SizedBox()),
                        ],
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if( GetStorage().read('token') == null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()),);
    }
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    ApiController().getFollowList().then((value) => _getController.changeFollowList(value));
    return Obx(() => _getController.followList.value.res == null
        ? SizedBox(width: w, height: h * 0.9, child: const Center(child: CircularProgressIndicator()),)
        : Obx(() => _getController.followList.value.res!.isNotEmpty
          ? SizedBox(
      height:  h * 0.85,
      child: ListView.builder(

          itemCount: _getController.followList.value.res?.length ?? 0,
          itemBuilder: (context, index) {
            return Column(
              children: [
                SizedBox(height: h * 0.02,),
                if (_getController.followList.value.res?[index].photoUrl != null)
                  InkWell(
                    onTap: (){
                      ApiController().profileById(_getController.followList.value.res?[index].id ?? 0).then((value) => {_getController.changeProfileById(value),});
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfessionsListDetails()));
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: w * 0.9,
                          child: Row(
                            children: [
                              SizedBox(width: w * 0.02,),
                              SizedBox(
                                width: w * 0.11,
                                height: w * 0.11,
                                child: CircleAvatar(backgroundImage: NetworkImage('${_getController.followList.value.res?[index].photoUrl}'),),
                              ),
                              SizedBox(width: w * 0.02,),
                              SizedBox(
                                width: w * 0.6,
                                child: Text('${_getController.followList.value.res?[index].lastName} ${_getController.followList.value.res?[index].fistName}',
                                  style: TextStyle(
                                    fontSize: w * 0.05,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: h * 0.02,),
                if (_getController.followList.value.res?[index].photoUrl != null)
                  SizedBox(width: w , height: h * 0.33, child: Image.network('${_getController.followList.value.res?[index].photoUrl}', fit: BoxFit.cover,),),
                SizedBox(height: h * 0.02,),
                SizedBox(width: w * 0.95,
                  child:Row(
                    children: [
                      SizedBox(
                        height: w * 0.07,
                        width: w * 0.07,
                        child: IconButton(
                            hoverColor: Colors.blue,
                            iconSize: w * 0.07,
                            padding: EdgeInsets.zero,
                            onPressed: (){
                              showDialogs(
                                  context, _getController.followList.value.res?[index].phoneNumber ?? '','You will be charged for this call','Call',1);
                            },
                            icon: HeroIcon(HeroIcons.phone, color: Colors.blue, size: w * 0.07,)
                        ),
                      ),
                      SizedBox(width: w * 0.01,),
                      SizedBox(
                        height: w * 0.07,
                        width: w * 0.07,
                        child: IconButton(
                            hoverColor: Colors.blue,
                            iconSize: w * 0.07,
                            padding: EdgeInsets.zero,
                            onPressed: (){showDialogs(context, 'Manzil',_getController.followList.value.res?[index].officeAddress ?? '','ok',2);},
                            icon: HeroIcon(HeroIcons.mapPin, color: Colors.blue, size: w * 0.07,)
                        ),
                      ),
                      SizedBox(width: w * 0.01),
                      SizedBox(
                        height: w * 0.07,
                        width: w * 0.07,
                        child: IconButton(
                            hoverColor: Colors.blue,
                            iconSize: w * 0.07,
                            padding: EdgeInsets.zero,
                            onPressed: (){showDialogs(context,_getController.followList.value.res?[index].categoryName ?? '',_getController.followList.value.res?[index].bio ?? '','ok',3);},
                            icon: HeroIcon(HeroIcons.briefcase, color: Colors.blue, size: w * 0.07,)
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: h * 0.01),
                SizedBox(
                  width: w * 0.9,
                  child: Text('${_getController.followList.value.res?[index].userName}',
                    style: TextStyle(
                      fontSize: w * 0.055,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                SizedBox(
                  width: w * 0.9,
                  child: Text(
                    '${_getController.followList.value.res?[index].categoryName}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue,
                    ),
                  ),
                ),
                SizedBox(
                  width: w * 0.9,
                  child: Text(
                    '${_getController.followList.value.res?[index].bio}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: h * 0.02,
                ),
              ],
            );
          }),
    )
          : SizedBox(width: w, height: h * 0.9, child: const Center(child: Text('No data'),),)
        )
    );
  }
}
