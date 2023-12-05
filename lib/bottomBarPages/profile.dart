import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heroicons/heroicons.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:time_up/api/api_controller.dart';
import 'package:time_up/elements/functions.dart';
import 'package:time_up/pages/post_details.dart';
import '../elements/bio_business.dart';
import '../elements/btn_business.dart';
import '../elements/btn_users.dart';
import '../elements/txt_business.dart';
import '../elements/user_detials.dart';
import '../pages/edit_post_details.dart';
import '../pages/login_page.dart';
import '../pages/make_business.dart';
import '../pages/user_bussines_edit.dart';
import '../pages/user_edit.dart';
import '../res/getController.dart';
import 'package:photo_view/photo_view.dart';
import 'package:readmore/readmore.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final GetController getController = Get.put(GetController());
  final PageController pageController = PageController();
  final TextEditingController _dateController = TextEditingController();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  getUsers() async {ApiController().getUserData();}

  showLoadingDialog(BuildContext context, w) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) => AlertDialog(
        content: SizedBox(
          width: w * 0.1,
          height: w * 0.2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(child: SizedBox()),
              SizedBox(
                width: w * 0.1,
                height: w * 0.1,
                child: const CircularProgressIndicator(
                  color: Colors.blue,
                  backgroundColor: Colors.white,
                  strokeWidth: 2,
                ),
              ),
              SizedBox(
                width: w * 0.07,
              ),
              Text(
                'Loading...',
                style: TextStyle(
                  fontSize: w * 0.04,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
        ),
      ),
    );
  }

  showDialogs(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(''),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.05,
          child: const Center(
            child: Text('Do you want delete you accaount ? '),
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
                        ApiController().deleteMe().then((value) => {
                              if (value == true)
                                {
                                  GetStorage().remove('token'),
                                  getController.clearMeUser(),
                                  getController.clearCategory(),
                                  Navigator.pop(context),
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()),
                                  ),
                                }
                              else
                                {
                                  Toast.showToast(context, 'Xatolik yuz berdi',
                                      Colors.red, Colors.white)
                                }
                            });
                      },
                      child: Row(
                        children: [
                          const Expanded(child: SizedBox()),
                          Text('Delete',
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.035,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              )),
                          const HeroIcon(HeroIcons.check, color: Colors.white)
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

  showClosDialogs(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(''),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.05,
          child: const Center(
            child: Text('Do you want log out ? '),
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
                        getController.clearMeUser();
                        getController.clearCategory();
                        GetStorage().remove('token');
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Row(
                        children: [
                          const Expanded(child: SizedBox()),
                          Text('Log out',
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.035,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              )),
                          const HeroIcon(HeroIcons.check, color: Colors.white)
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

  showBottomSheetList(context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.9,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: h * 0.02),
                width: w * 0.2,
                height: h * 0.005,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(height: h * 0.1),
              Row(
                children: [
                  SizedBox(width: w * 0.05),
                  const Text('kunni tanlang'),
                ],
              ),
              SizedBox(
                width: w * 0.9,
                height: h * 0.07,
                child: TextField(
                  controller: _dateController,
                  onChanged: (value) {
                    if (value != '') {
                      ApiController()
                          .bookingBusinessGetList(
                              getController.meUsers.value.res!.business!.id!,
                              '')
                          .then((value) => getController
                              .changeBookingBusinessGetList(value));
                    }
                  },
                  decoration: InputDecoration(
                    suffixIcon: InkWell(
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: _dateController.text == ''
                                ? DateTime.now()
                                : DateTime.parse(
                                    '${_dateController.text.substring(6, 10)}-${_dateController.text.substring(3, 5)}-${_dateController.text.substring(0, 2)}'),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2025),
                          ).then((value) => {
                                if (value != null)
                                  {
                                    _dateController.text =
                                        '${value.day < 10 ? '0${value.day}' : value.day}/${value.month < 10 ? '0${value.month}' : value.month}/${value.year}',
                                    ApiController()
                                        .bookingBusinessGetList(
                                            getController.meUsers.value.res!
                                                .business!.id!,
                                            _dateController.text)
                                        .then((value) => getController
                                            .changeBookingBusinessGetList(
                                                value))
                                  }
                                else
                                  {_dateController.text = ''}
                              });
                        },
                        child: HeroIcon(
                          HeroIcons.calendar,
                          color: Colors.black,
                          size: w * 0.06,
                        )),
                    hintText: 'MM / DD / YYYY',
                    hintStyle: TextStyle(
                      fontSize: w * 0.04,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: h * 0.02),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
                child: Obx(
                  () => getController.bookingBusinessGetList.value.res == null
                      ? const Center(child: Text('Ma\'lumotlar topilmadi'))
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: getController
                              .bookingBusinessGetList.value.res!.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: w * 0.08,
                                      child: Text(
                                        '${index + 1}',
                                        style: TextStyle(
                                          fontSize: w * 0.04,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: w * 0.7,
                                      child: Text(
                                        'Ushbu mijoz'
                                        ' ${getController.bookingBusinessGetList.value.res![index].date!.replaceAll('/', '-')} '
                                        '${getController.bookingBusinessGetList.value.res![index].time!} keladi',
                                        style: TextStyle(
                                          fontSize: w * 0.04,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(),
                              ],
                            );
                          }),
                ),
              )),
            ],
          ),
        );
      },
    );
  }

  showBottomSheet(context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: h * 0.02),
                width: w * 0.2,
                height: h * 0.005,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(height: h * 0.02),
              Text(
                'Options',
                style: TextStyle(
                  fontSize: w * 0.04,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: h * 0.05),
              InkWell(
                onTap: () {
                  getController.entersUser.value = 1;
                  Navigator.pop(context);
                },
                child: SizedBox(
                  width: w,
                  height: h * 0.05,
                  child: Row(
                    children: [
                      SizedBox(width: w * 0.05),
                      HeroIcon(
                        HeroIcons.pencilSquare,
                        color: Colors.blue,
                        size: w * 0.05,
                      ),
                      SizedBox(width: w * 0.03),
                      const Text('Edit profile'),
                    ],
                  ),
                ),
              ),
              Obx(() => getController.meUsers.value.res?.business != null
                  ? const SizedBox()
                  : const Divider()),
              Obx(() => getController.meUsers.value.res?.business != null
                  ? const SizedBox()
                  : InkWell(
                      onTap: () {
                        getController.entersUser.value = 2;
                        Navigator.pop(context);
                      },
                      child: SizedBox(
                        width: w,
                        height: h * 0.05,
                        child: Row(
                          children: [
                            SizedBox(width: w * 0.05),
                            HeroIcon(
                              HeroIcons.pencilSquare,
                              color: Colors.blue,
                              size: w * 0.05,
                            ),
                            SizedBox(width: w * 0.03),
                            const Text('Make business profile'),
                          ],
                        ),
                      ),
                    )),
              const Divider(),
              InkWell(
                onTap: () {
                  showClosDialogs(context);
                },
                child: SizedBox(
                  width: w,
                  height: h * 0.05,
                  child: Row(
                    children: [
                      SizedBox(width: w * 0.05),
                      HeroIcon(
                        HeroIcons.arrowRightOnRectangle,
                        color: Colors.red,
                        size: w * 0.05,
                      ),
                      SizedBox(width: w * 0.03),
                      const Text('Log out'),
                    ],
                  ),
                ),
              ),
              const Divider(),
              InkWell(
                onTap: () {
                  showDialogs(context);
                },
                child: SizedBox(
                  width: w,
                  height: h * 0.05,
                  child: Row(
                    children: [
                      SizedBox(width: w * 0.05),
                      HeroIcon(
                        HeroIcons.trash,
                        color: Colors.red,
                        size: w * 0.05,
                      ),
                      SizedBox(width: w * 0.03),
                      const Text('Delete accaunt'),
                    ],
                  ),
                ),
              ),
              const Divider(),
            ],
          ),
        );
      },
    );
  }

  showBottomSheetEllips(context, id) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: h * 0.02),
                width: w * 0.2,
                height: h * 0.005,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(height: h * 0.1),
              InkWell(
                onTap: () {
                  showLoadingDialog(context, w);
                  ApiController().getByIdPost(id).then((value) => {
                        Navigator.pop(context),
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditPostDetails(postId: id))),
                      });
                },
                child: SizedBox(
                  width: w,
                  height: h * 0.05,
                  child: Row(
                    children: [
                      SizedBox(width: w * 0.05),
                      HeroIcon(
                        HeroIcons.pencilSquare,
                        color: Colors.blue,
                        size: w * 0.05,
                      ),
                      SizedBox(width: w * 0.03),
                      const Text('Edit post'),
                    ],
                  ),
                ),
              ),
              const Divider(),
              InkWell(
                onTap: () {
                  ApiController()
                      .deletePost(getController.getPostList.value.res![0].id)
                      .then((value) => {
                            if (value == true)
                              {
                                getUsers(),
                                Toast.showToast(
                                    context,
                                    'Post muvaffaqiyatli o\'chirildi',
                                    Colors.green,
                                    Colors.white)
                              }
                            else
                              {
                                Toast.showToast(context, 'Xatolik yuz berdi',
                                    Colors.red, Colors.white)
                              }
                          });
                  Navigator.pop(context);
                  ApiController().getMePostList(
                      getController.meUsers.value.res!.business?.id);
                },
                child: SizedBox(
                  width: w,
                  height: h * 0.05,
                  child: Row(
                    children: [
                      SizedBox(width: w * 0.05),
                      HeroIcon(
                        HeroIcons.trash,
                        color: Colors.red,
                        size: w * 0.05,
                      ),
                      SizedBox(width: w * 0.03),
                      const Text('Delete post'),
                    ],
                  ),
                ),
              ),
              const Divider(),
            ],
          ),
        );
      },
    );
  }

  final ImagePicker _picker = ImagePicker();
  var croppedImage;

  Future<void> _pickImage(ImageSource source, context) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      _cropImage(pickedFile.path, context);
    }
  }

  Future<void> _cropImage(String imagePath, context) async {
    croppedImage = await ImageCropper.platform.cropImage(
      sourcePath: imagePath,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 100,
      compressFormat: ImageCompressFormat.jpg,
    );
    getController.changeImage(croppedImage.path);
    ApiController().editUserPhoto(croppedImage.path).then((value) => {
          if (value == true){
              getUsers(),
              Toast.showToast(context, 'Rasm muvaffaqiyatli o\'zgartirildi', Colors.green, Colors.white)
            }
          else {
              Toast.showToast(context, 'Xatolik yuz berdi', Colors.red, Colors.white)
            }
        });
  }

  void _onRefresh() async {
    if (getController.meUsers.value.res?.business == null) {
      ApiController().getUserData().then((value) => _refreshController.refreshCompleted());
    } else {
      if (pageController.page == 0) {
        ApiController().getMePostList(getController.meUsers.value.res!.business?.id).then((value) => _refreshController.refreshCompleted());
      } else {
        _refreshController.refreshCompleted();
      }
    }
  }

  void _onLoading() async {
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    getController.show.value = false;
    ApiController().getMePostList(getController.meUsers.value.res!.business?.id);
    return WillPopScope(
      onWillPop: () async {
        if (getController.entersUser.value == 0) {
          return true;
        } else if (getController.entersUser.value == 1) {
          getController.entersUser.value = 0;
          return false;
        } else if (getController.entersUser.value == 2) {
          getController.entersUser.value = 1;
          return false;
        } else {
          return false;
        }
      },
      child: Obx(() => getController.meUsers.value.res != null
          ? SizedBox(
              child: Obx(
                () => getController.entersUser.value == 0
                    ? Column(
                        children: [
                          SizedBox(height: h * 0.01),
                          AppBar(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            surfaceTintColor: Colors.transparent,
                            centerTitle: true,
                            title: Text(
                              getController.meUsers.value.res?.userName ?? '',
                              style: TextStyle(
                                fontSize: w * 0.04,
                                color: Colors.black,
                              ),
                            ),
                            actions: [
                              IconButton(
                                onPressed: () {
                                  showBottomSheet(context);
                                },
                                icon: const Icon(
                                  Icons.menu,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(height: h * 0.01),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Expanded(child: SizedBox()),
                                    Stack(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Scaffold(
                                                  backgroundColor: Colors.black,
                                                  body: Stack(
                                                    children: [
                                                      PhotoView(
                                                        imageProvider: NetworkImage(
                                                            '${getController.meUsers.value.res?.photoUrl}'),
                                                      ),
                                                      Positioned(
                                                        top: h * 0.05,
                                                        left: w * 0.01,
                                                        child: Container(
                                                          padding: EdgeInsets.only(
                                                              left: w * 0.01),
                                                          width: w * 0.1,
                                                          height: w * 0.1,
                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                w * 0.1),
                                                          ),
                                                          child: IconButton(
                                                            onPressed: () {
                                                              Navigator.pop(context);
                                                            },
                                                            icon: const Icon(
                                                                Icons.arrow_back_ios,
                                                                color: Colors.black),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          child: CircleAvatar(
                                            radius: w * 0.12,
                                            foregroundColor: Colors.blue,
                                            backgroundImage: NetworkImage(
                                                '${getController.meUsers.value.res?.photoUrl}'),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Container(
                                            width: w * 0.08,
                                            height: w * 0.08,
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                              BorderRadius.circular(w * 0.04),
                                            ),
                                            child: IconButton(
                                              onPressed: () {
                                                _pickImage(
                                                    ImageSource.gallery, context);
                                              },
                                              icon: HeroIcon(
                                                HeroIcons.camera,
                                                color: Colors.white,
                                                size: w * 0.05,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Expanded(child: SizedBox()),
                                  ],
                                ),
                                SizedBox(height: h * 0.01),
                                Center(
                                  child: Obx(() =>
                                  getController.meUsers.value.res?.business ==
                                      null
                                      ? Text(
                                    '${getController.meUsers.value.res?.fistName} ${getController.meUsers.value.res?.lastName}',
                                    style: TextStyle(
                                      fontSize: w * 0.05,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                      : Text(
                                    '${getController.meUsers.value.res?.fistName} ${getController.meUsers.value.res?.lastName}',
                                    style: TextStyle(
                                      fontSize: w * 0.05,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )),
                                ),
                                SizedBox(height: h * 0.01),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Obx(() =>
                                    getController.meUsers.value.res?.business ==
                                        null
                                        ? const SizedBox()
                                        : UserDetIalWidget(
                                      labelText: 'Post',
                                      labelTextCount:
                                      '${getController.meUsers.value.res?.business?.postsCount}',
                                    )),
                                    Obx(() =>
                                    getController.meUsers.value.res?.business ==
                                        null
                                        ? const SizedBox()
                                        : UserDetIalWidget(
                                      labelText: 'Followers',
                                      labelTextCount:
                                      '${getController.meUsers.value.res?.business?.followersCount}',
                                    )),
                                    Obx(() =>
                                    getController.meUsers.value.res?.business ==
                                        null
                                        ? const SizedBox()
                                        : UserDetIalWidget(
                                      labelText: 'Following',
                                      labelTextCount:
                                      '${getController.meUsers.value.res?.followingCount}',
                                    )),
                                  ],
                                ),
                                SizedBox(height: h * 0.02),
                                Container(
                                  width: w,
                                  padding: EdgeInsets.only(
                                      left: w * 0.03,
                                      right: w * 0.03,
                                      bottom: h * 0.01),
                                  child: Obx(() => getController
                                      .meUsers.value.res?.business ==
                                      null
                                      ? Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.blue,
                                        radius: w * 0.03,
                                        child: const Image(
                                          image: AssetImage(
                                              'assets/images/user_call.png'),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      SizedBox(
                                        width: w * 0.02,
                                      ),
                                      Obx(() =>
                                      getController.meUsers.value.res ==
                                          null
                                          ? const SizedBox()
                                          : Text(
                                        getController.meUsers.value
                                            .res!.phoneNumber ??
                                            '',
                                        style: TextStyle(
                                          fontSize: w * 0.04,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )),
                                    ],
                                  )
                                      : Obx(() => getController.show.value == false
                                      ? Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.blue,
                                        radius: w * 0.03,
                                        child: const Image(
                                          image: AssetImage(
                                              'assets/images/user_call.png'),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      SizedBox(
                                        width: w * 0.02,
                                      ),
                                      Obx(() => getController
                                          .meUsers.value.res ==
                                          null
                                          ? const SizedBox()
                                          : Text(
                                        getController.meUsers.value
                                            .res!.phoneNumber ??
                                            '',
                                        style: TextStyle(
                                          fontSize: w * 0.04,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )),
                                      SizedBox(width: w * 0.02),
                                      InkWell(
                                        onTap: () {
                                          getController.show.value = true;
                                        },
                                        child: Text(
                                          'More',
                                          style: TextStyle(
                                            fontSize: w * 0.04,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                      : Column(
                                    children: [
                                      Obx(() => getController.meUsers.value
                                          .res?.business !=
                                          null
                                          ? TextEditButton(
                                        text:
                                        '${getController.meUsers.value.res?.business?.categoryName}',
                                        color: Colors.blue,
                                        icon:
                                        'assets/images/user_call.png',
                                      )
                                          : const SizedBox()),
                                      Obx(() => getController.meUsers.value
                                          .res?.business !=
                                          null
                                          ? TextEditButton(
                                        text:
                                        '${getController.meUsers.value.res?.business?.officeAddress}',
                                        color: Colors.blue,
                                        icon:
                                        'assets/images/user_location.png',
                                      )
                                          : const SizedBox()),
                                      Obx(() => getController.meUsers.value
                                          .res?.business !=
                                          null
                                          ? TextEditButton(
                                        text:
                                        '${getController.meUsers.value.res?.business?.officeName}',
                                        color: Colors.blue,
                                        icon:
                                        'assets/images/user_work.png',
                                      )
                                          : const SizedBox()),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Colors.blue,
                                            radius: w * 0.03,
                                            child: const Image(
                                              image: AssetImage(
                                                  'assets/images/user_time.png'),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          SizedBox(
                                            width: w * 0.02,
                                          ),
                                          SizedBox(
                                            width: w * 0.7,
                                            child: Obx(() => getController
                                                .meUsers
                                                .value
                                                .res ==
                                                null
                                                ? const SizedBox()
                                                : ReadMoreText(
                                              '${getController.meUsers.value.res!.business!.dayOffs}',
                                              trimLines: 1,
                                              colorClickableText:
                                              Colors.pink,
                                              trimMode: TrimMode.Line,
                                              trimCollapsedText:
                                              ' more',
                                              trimExpandedText:
                                              ' less',
                                              moreStyle: TextStyle(
                                                fontSize: w * 0.04,
                                                fontWeight:
                                                FontWeight.w400,
                                                color: Colors.blue,
                                              ),
                                              style: TextStyle(
                                                fontSize: w * 0.04,
                                                fontWeight:
                                                FontWeight.w400,
                                                color: Colors.black,
                                              ),
                                            )),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              getController.show.value =
                                              false;
                                            },
                                            child: Text(
                                              'Less',
                                              style: TextStyle(
                                                fontSize: w * 0.04,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ))),
                                ),
                                Obx(() => getController.meUsers.value.res?.business == null
                                    ? EditButton(
                                  text: 'Make business profile',
                                  onPressed: () {
                                    getController.nextPages.value = 0;
                                    getController.entersUser.value = 2;
                                  },
                                )
                                    : const SizedBox()),
                                Obx(() => getController.meUsers.value.res?.business ==
                                    null
                                    ? EditButton(
                                  text: 'Edit profile',
                                  onPressed: () {
                                    getController.entersUser.value = 1;
                                  },
                                )
                                    : SizedBox(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        //My Post
                                        Obx(() => getController
                                            .nextPagesUserDetails.value ==
                                            0
                                            ? SizedBox(
                                          width: w * 0.333,
                                          height: h * 0.062,
                                          child: BusinessEditButton(
                                            text: 'My Post',
                                            onPressed: () {
                                              pageController.animateToPage(0,
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.ease);
                                            },
                                            color: Colors.blue,
                                            radius: 0,
                                          ),
                                        )
                                            : SizedBox(
                                          width: w * 0.333,
                                          height: h * 0.062,
                                          child: BusinessEditButton(
                                            text: 'My Post',
                                            onPressed: () {
                                              pageController.animateToPage(0,
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.ease);
                                            },
                                            color: Colors.grey,
                                            radius: 0,
                                          ),
                                        )),
                                        Obx(() => getController
                                            .nextPagesUserDetails.value ==
                                            1
                                            ? SizedBox(
                                          width: w * 0.333,
                                          height: h * 0.062,
                                          child: BusinessEditButton(
                                            text: 'Booking',
                                            onPressed: () {
                                              pageController.animateToPage(1,
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.ease);
                                            },
                                            color: Colors.blue,
                                            radius: 0,
                                          ),
                                        )
                                            : SizedBox(
                                          width: w * 0.333,
                                          height: h * 0.062,
                                          child: BusinessEditButton(
                                            text: 'Booking',
                                            onPressed: () {
                                              pageController.animateToPage(1,
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.ease);
                                            },
                                            color: Colors.grey,
                                            radius: 0,
                                          ),
                                        )),
                                        Obx(() => getController
                                            .nextPagesUserDetails.value ==
                                            2
                                            ? SizedBox(
                                          width: w * 0.333,
                                          height: h * 0.062,
                                          child: BusinessEditButton(
                                            text: 'Bio',
                                            onPressed: () {
                                              pageController.animateToPage(2,
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.ease);
                                            },
                                            color: Colors.blue,
                                            radius: 0,
                                          ),
                                        )
                                            : SizedBox(
                                          width: w * 0.333,
                                          height: h * 0.062,
                                          child: BusinessEditButton(
                                            text: 'Bio',
                                            onPressed: () {
                                              pageController.animateToPage(2,
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.ease);
                                            },
                                            color: Colors.grey,
                                            radius: 0,
                                          ),
                                        )),
                                      ],
                                    ))),
                                Obx(() => getController.meUsers.value.res?.business == null
                                    ? const SizedBox()
                                    : SizedBox(
                                  height: getController.show.value
                                      ? h * 0.27
                                      : h * 0.38,
                                  child: PageView(
                                    onPageChanged: (index) {
                                      getController.nextPagesUserDetails.value = index;
                                      ApiController().getMePostList(getController.meUsers.value.res!.business?.id);
                                    },
                                    controller: pageController,
                                    children: [
                                      Obx(() => getController.getPostList.value.res == null
                                            ? SizedBox(
                                          width: w,
                                          height: h * 0.22,
                                          child: const Center(child: Text('Ma\'lumotlar topilmadi'),),
                                        ) : SizedBox(
                                          height: h * 0.22,
                                          child: SizedBox(
                                            width: w,
                                            child: SmartRefresher(
                                              enablePullDown: true,
                                              enablePullUp: true,
                                              header: CustomHeader(
                                                builder: (BuildContext
                                                context, RefreshStatus?mode) {
                                                  Widget body;
                                                  if (mode == RefreshStatus.idle) {
                                                    body = const Text("Ma`lumotlarni yangilash uchun tashlang");
                                                  } else if (mode == RefreshStatus.refreshing) {
                                                    body = const CircularProgressIndicator(
                                                      color: Colors.blue,
                                                      backgroundColor:
                                                      Colors.white,
                                                      strokeWidth: 2,
                                                    );
                                                  } else if (mode == RefreshStatus.failed) {
                                                    body = const Text("Load Failed!Click retry!");
                                                  } else if (mode == RefreshStatus.canRefresh) {
                                                    body = const Text("Ma`lumotlarni yangilash uchun tashlang");
                                                  } else {
                                                    body = const Text("Ma`lumotlar yangilandi");
                                                  }
                                                  return SizedBox(
                                                    height: h * 0.1,
                                                    child: Center(child: body),
                                                  );
                                                },
                                              ),
                                              footer: CustomFooter(
                                                builder: (BuildContext
                                                context, LoadStatus?mode) {
                                                  Widget body;
                                                  if (mode == LoadStatus.idle) {
                                                    body = const SizedBox();
                                                  } else if (mode == LoadStatus.loading) {
                                                    body = const CircularProgressIndicator(
                                                      color: Colors.blue,
                                                      backgroundColor:
                                                      Colors.white,
                                                      strokeWidth: 2,
                                                    );
                                                  } else if (mode == LoadStatus.failed) {
                                                    body = const Text("Load Failed!Click retry!");
                                                  } else if (mode == LoadStatus.canLoading) {
                                                    body = const SizedBox();
                                                  } else {
                                                    body = const Text("Ma`lumotlar yangilandi");
                                                  }
                                                  return SizedBox(
                                                    height: h * 0.1,
                                                    child: Center(child: body),
                                                  );
                                                },
                                              ),
                                              controller:
                                              _refreshController,
                                              onRefresh: _onRefresh,
                                              onLoading: _onLoading,
                                              child:
                                              ListView.builder(
                                                  itemCount:
                                                  getController.getPostList.value.res!.length,
                                                  itemBuilder: (context, index) {
                                                    return InkWell(
                                                      onTap: () {
                                                        Navigator.push(context, MaterialPageRoute(builder: (context) => PostDetailsPage(postId: getController.getPostList.value.res![index].id,)));
                                                      },
                                                      child:
                                                      Column(
                                                        children: [
                                                          Obx(() => getController.getPostList.value.res![index].mediaType == 'video'
                                                                ? Stack(
                                                              children: [
                                                                Container(
                                                                  width: w,
                                                                  height: h * 0.3,
                                                                  padding: EdgeInsets.all(w * 0.01),
                                                                  decoration: BoxDecoration(
                                                                    image: DecorationImage(
                                                                      image: NetworkImage('${getController.getPostList.value.res![index].photo}'),
                                                                      fit: BoxFit.fitWidth,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Positioned(
                                                                    width: w,
                                                                    height: h * 0.3,
                                                                    child: Center(
                                                                      child: Container(
                                                                        padding: EdgeInsets.all(w * 0.025),
                                                                        decoration: BoxDecoration(
                                                                          color: Colors.black.withOpacity(0.5),
                                                                          borderRadius: BorderRadius.circular(w * 0.1),
                                                                        ),
                                                                        child: HeroIcon(
                                                                          HeroIcons.play,
                                                                          color: Colors.white,
                                                                          size: w * 0.05,
                                                                        ),
                                                                      ),
                                                                    )),
                                                              ],
                                                            ) : Container(
                                                              width: w,
                                                              height: h * 0.3,
                                                              padding: EdgeInsets.all(w * 0.01),
                                                              decoration: BoxDecoration(
                                                                image: DecorationImage(
                                                                  image: NetworkImage('${getController.getPostList.value.res![index].photo}'),
                                                                  fit: BoxFit.fitWidth,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: w,
                                                            padding: EdgeInsets.only(left: w * 0.04, top: h * 0.01, bottom: h * 0.01),
                                                            child: Row(
                                                              children: [
                                                                Expanded(
                                                                    child: Column(
                                                                      children: [
                                                                        Obx(() => getController.getPostList.value.res![index].title == '' && getController.getPostList.value.res![index].description == ''
                                                                            ? const SizedBox()
                                                                            : SizedBox(
                                                                          width: w * 0.9,
                                                                          child: Text('${getController.getPostList.value.res![index].title}',
                                                                            style: TextStyle(
                                                                              fontSize: w * 0.04,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                          ),
                                                                        )),
                                                                        Obx(() => getController.getPostList.value.res![index].title == '' && getController.getPostList.value.res![index].description == ''
                                                                            ? const SizedBox()
                                                                            : SizedBox(
                                                                          width: w * 0.9,
                                                                          child: ReadMoreText('${getController.getPostList.value.res![index].description}',
                                                                            trimLines: 2,
                                                                            colorClickableText: Colors.blue,
                                                                            trimMode: TrimMode.Line,
                                                                            trimCollapsedText: 'Show more',
                                                                            trimExpandedText: 'Show less',
                                                                            style: TextStyle(
                                                                              fontSize: w * 0.04,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                            moreStyle: TextStyle(
                                                                              fontSize: w * 0.04,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                            lessStyle: TextStyle(
                                                                              fontSize: w * 0.04,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                          ),
                                                                        )),
                                                                      ],
                                                                    )),
                                                                SizedBox(
                                                                    child: IconButton(
                                                                      onPressed: () {
                                                                        showBottomSheetEllips(context, getController.getPostList.value.res![index].id);
                                                                      },
                                                                      icon: HeroIcon(
                                                                        HeroIcons.ellipsisVertical,
                                                                        color: Colors.black,
                                                                        size: w * 0.05,
                                                                      ),
                                                                    ))
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  }),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Obx(() => getController.bookingBusinessGetList.value.res == null
                                            ? SizedBox(
                                          width: w,
                                          height: h * 0.22,
                                          child: const Center(
                                            child: Text('Ma\'lumotlar topilmadi'),
                                          ),
                                        ) : SizedBox(
                                          width: w * 0.9,
                                          height: h * 0.22,
                                          child: Container(
                                              height: h * 0.22,
                                              width: w * 0.9,
                                              margin: EdgeInsets.only(top: h * 0.02, bottom: h * 0.02, left: w * 0.02, right: w * 0.02),
                                              padding: EdgeInsets.all(w * 0.02),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.grey,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(3),
                                              ),
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                      child: ListView.builder(
                                                          shrinkWrap:
                                                          true,
                                                          itemCount: getController.bookingBusinessGetList1.value.res!.length,
                                                          itemBuilder: (context, index) {
                                                            return Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    SizedBox(
                                                                      width: w * 0.08,
                                                                      child: Text('${index + 1}',
                                                                        style: TextStyle(
                                                                          fontSize: w * 0.04,
                                                                          fontWeight: FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: w * 0.7,
                                                                      child: Text('Ushbu mijoz' ' ${getController.bookingBusinessGetList1.value.res![index].date!.replaceAll('/', '-')} ' '${getController.bookingBusinessGetList1.value.res![index].time!} keladi',
                                                                        style: TextStyle(
                                                                          fontSize: w * 0.04,
                                                                          fontWeight: FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const Divider(),
                                                              ],
                                                            );
                                                          })),
                                                  Row(
                                                    children: [
                                                      const Expanded(child: SizedBox()),
                                                      SizedBox(
                                                        height:
                                                        h * 0.05,
                                                        child: TextButton(
                                                          onPressed: () {
                                                            showBottomSheetList(context);
                                                          },
                                                          child: Text('Barchasini ko\'rish',
                                                            style: TextStyle(
                                                              fontSize: w * 0.04,
                                                              fontWeight: FontWeight.w500,
                                                              color: Colors.blue,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              )),
                                        ),
                                      ),
                                      BioBusiness(text: getController.meUsers.value.res?.business?.bio ?? '',),
                                    ],
                                  ),
                                )),
                              ],
                            ),
                          ),
                        ],
                      )
                    : getController.entersUser.value == 1
                        ? getController.meUsers.value.res?.business == null
                            ? EditUserPage()
                            : EditBusinessUserPage()
                        : getController.entersUser.value == 2
                            ? MakeBusinessPage()
                            : const SizedBox(),
              ),
            ) : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    surfaceTintColor: Colors.transparent,
                    centerTitle: true,
                    title: Text(getController.meUsers.value.res?.userName ?? '',
                      style: TextStyle(
                        fontSize: w * 0.04,
                        color: Colors.black,
                      ),
                    ),
                    actions: [
                      PopupMenuButton(
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: TextButton(
                              onPressed: () {
                                showClosDialogs(context);
                              },
                              child: Text(
                                'Log out',
                                style: TextStyle(
                                  fontSize: w * 0.04,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            child: TextButton(
                              onPressed: () {
                                showDialogs(context);
                              },
                              child: Text(
                                'Delete accaunt',
                                style: TextStyle(
                                  fontSize: w * 0.04,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ),
                          ),
                        ],
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: h * 0.3),
                  const CircularProgressIndicator(),
                  SizedBox(height: w * 0.05),
                  const Text('Loading...'),
                ],
              ),
            )),
    );
  }
}
