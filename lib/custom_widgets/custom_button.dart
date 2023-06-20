import 'package:todo_offline_app/utils/custom_imports.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final Function()? onTap;
  const CustomButton({super.key, this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.07,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.primaryColor),
        child: Center(
          child: CustomText(
            text: text,
            fontSize: 20,
            fontColor: AppColors.lavendarColor,
          ),
        ),
      ),
    );
  }
}
