import 'package:todo_offline_app/utils/custom_imports.dart';

class CustomTextfield extends StatefulWidget {
  String? hintText;
  String? labelText;
  TextEditingController? controller;
  bool isPasswordField;
  bool isReadOnly;
  bool isCenterText;
  bool? isBorder;
  IconData? prefixIcon;
  // IconData? suffixIcon;

  Widget? suffixIcon;
  String? Function(String?)? validator;
  String? Function(String?)? onSaved;
  String? initialVal;
  TextInputType? keyboardType;
  Function()? onTap;
  Color? bgColor;
  Color? borderColor;
  bool isPrefixIcon;
  bool? isSuffixIcon;
  Widget? prefix;
  int? maxLines;
  EdgeInsetsGeometry? padding;
  AutovalidateMode? autoValidateMode;
  void Function(String)? onChanged;

  CustomTextfield({
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.autoValidateMode,
    this.isReadOnly = false,
    this.controller,
    this.bgColor,
    this.prefix,
    this.onTap,
    this.borderColor,
    this.padding,
    this.isBorder,
    this.isSuffixIcon,
    this.initialVal,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.suffixIcon,
    this.onSaved,
    this.maxLines,
    this.isPasswordField = false,
    this.isCenterText = false,
    this.isPrefixIcon = true,
    this.onChanged,
  });
  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  late bool textVisible;
  @override
  void initState() {
    textVisible = widget.isPasswordField;
    super.initState();
  }

  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return textFormField();
  }

  TextFormField textFormField() {
    return TextFormField(
      validator: widget.validator,
      controller: widget.controller,
      decoration: InputDecoration(
          border: InputBorder.none,
          labelText: widget.labelText,
          hintText: widget.hintText,
          suffixIcon: widget.suffixIcon),
    );
  }
}
