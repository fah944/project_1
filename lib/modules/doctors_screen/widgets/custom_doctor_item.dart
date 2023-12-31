import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/models/doctor_model.dart';
import '../../../../core/widgets/custome_image.dart';
import '../../doctor_details_screen/doctor_details_screen.dart';

class CustomDoctorItem extends StatelessWidget {
  final DoctorModel doctorModel;
  const CustomDoctorItem({
    super.key,
    required this.doctorModel,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(20.r),
          onTap: () {
            Navigator.pushNamed(context, DoctorDetailsView.route,
                arguments: doctorModel);
          },
          child: SizedBox(
            width: 200.w,
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              surfaceTintColor: Colors.white,
              elevation: 7,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 6.h),
                    doctorModel.imagePath == 'default'
                        ? CustomeImage(
                            image: 'assets/images/register_doctor_image3.jpg',
                            width: 190.w,
                            height: 160.h,
                            borderRadius: BorderRadius.circular(15),
                          )
                        : CustomeNetworkImage(
                            imageUrl: doctorModel.imagePath,
                            width: 190.w,
                            height: 160.h,
                            borderRadius: BorderRadius.circular(15),
                            fit: BoxFit.cover,
                          ),
                    SizedBox(
                      width: 170.w,
                      child: const Divider(
                        thickness: .7,
                        color: Colors.grey,
                      ),
                    ),
                    // SizedBox(height: 5.w),
                    Text(
                      'Dr. ${doctorModel.user.firstName} ${doctorModel.user.lastName}',
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.w,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // SizedBox(height: 5.w),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 90.w,
                          child: Text(
                            '${doctorModel.specialty} Doctor',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12.w,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Text(
                          '(${doctorModel.review}.0 ⭐️)',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10.w,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.w),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: List.generate(
                    //     doctorModel.review,
                    //     (index) => const Text('⭐️'),
                    //   ),

                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 150.w,
          left: 135.w,
          child: CustomeImage(
            image: 'assets/images/stethoscope_icon.png',
            color: Colors.transparent,
            width: 45.w,
            height: 45.w,
            borderRadius: BorderRadius.circular(40.w),
          ),
        ),
        // Positioned(
        //   left: 20.h,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: List.generate(
        //       doctorModel.review,
        //       (index) => const Text('⭐️'),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
