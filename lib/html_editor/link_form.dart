// import 'package:flutter/material.dart';
// import 'package:neurok_mobile/constants/custom_icon.dart';
// import 'package:neurok_mobile/i18n/i18n.dart';
// import 'package:neurok_mobile/theme/colors.dart';
// import 'package:neurok_mobile/theme/icons.dart';
// import 'package:neurok_mobile/theme/style.dart';

// typedef void CallbackValue(String value);

// class LinkForm extends StatefulWidget {
//   final CallbackValue callbackText;
//   final bool embed;

//   LinkForm({this.callbackText, this.embed = false});

//   @override
//   _LinkFormState createState() =>
//       _LinkFormState(callbackText: this.callbackText);
// }

// class _LinkFormState extends State<LinkForm> {
//   final CallbackValue callbackText;
//   final _formKey = GlobalKey<FormState>();
//   final RegExp _regExpUrl = RegExp(r'(^https://www.youtube.com/)|(^https://www.m.youtube.com/)|(^https://youtu.be/)|(^https://vimeo.com/)|(^https://es.slideshare.net/)|(^http://es.slideshare.net/)');

//   _LinkFormState({this.callbackText});

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Form(
//       key: _formKey,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 18),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             Padding(
//               padding: EdgeInsets.only(
//                   bottom: MediaQuery.of(context).viewInsets.bottom + 8,
//                   top: 10),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Expanded(
//                       child: TextFormField(
//                     autofocus: true,
//                     maxLines: 1,
//                     keyboardType: TextInputType.url,
//                     decoration: _getInputDecoration('URL', size),
//                     validator: (value) {
//                       Uri uri = Uri.tryParse(value);
//                       if (uri == null || !uri.isAbsolute || !_regExpUrl.hasMatch(uri.toString())) {
//                         return I18n.of(context).text('html_editor_url_error');
//                       }
//                       return null;
//                     },
//                     onSaved: (value) {
//                       callbackText(value);
//                       Navigator.pop(context);
//                     },
//                     onFieldSubmitted: (value) {
//                       callbackText(value);
//                       Navigator.pop(context);
//                     },
//                   )),
//                   FloatingActionButton(
//                       mini: true,
//                       backgroundColor: primaryColor,
//                       child: Icon(
//                           widget.embed
//                               ? getIcon(CustomIcon.embed)
//                               : getIcon(CustomIcon.reference),
//                           color: white),
//                       onPressed: () {
//                         if (_formKey.currentState.validate()) {
//                           _formKey.currentState.save();
//                         }
//                       }),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   InputDecoration _getInputDecoration(String hint, Size size) {
//     return InputDecoration(
//       contentPadding: EdgeInsets.symmetric(
//         vertical: size.height * .02,
//         horizontal: size.width * .06,
//       ),
//       hintText: hint,
//       hintStyle: getCreateContentFormTextStyle(size),
//       fillColor: backgroundColor,
//       filled: false,
//       focusedBorder: focusBorderCreateContentForm,
//       border: normalBorderCreateContentForm,
//       focusedErrorBorder: focusBorderCreateContentForm,
//       enabledBorder: normalBorderCreateContentForm,
//       errorBorder: normalBorderCreateContentForm,
//     );
//   }
// }
