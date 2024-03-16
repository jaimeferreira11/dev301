import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:test_mobile_itae/app/core/values/spaces.dart';
import 'package:test_mobile_itae/app/core/values/text_styles.dart';
import 'package:test_mobile_itae/app/ui/global_widgets/custom_appbar.dart';
import 'package:test_mobile_itae/app/ui/global_widgets/custom_progress.dart';

import '../../core/utils/responsive.dart';
import '../../theme/app_colors.dart';
import 'form_controller.dart';

class FormPage extends StatelessWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    final contacts = [
      'john@email.com',
      'susan@email.com',
      'caroline@email.com'
    ];

    Widget buildEmailListItem(String contact) {
      return ReactiveCheckboxListTile(
        key: ValueKey(contact),
        formControlName: contacts.indexOf(contact).toString(),
        title: Text(contact),
      );
    }

    return GetBuilder<FormController>(
        builder: (_) => SafeArea(
              child: Scaffold(
                appBar: CustomAppBar(
                    titulo: _.taskToSave == null
                        ? 'Agregar tarea'
                        : 'Editar tarea'),
                body: SafeArea(
                    child: Stack(
                  children: [
                    if (_.form != null)
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: ReactiveForm(
                          formGroup: _.form!,
                          child: Center(
                            child: Container(
                              width: responsive.wp(95),
                              margin: EdgeInsets.only(
                                  top: MySpaces.marginHorizontal2(context)),
                              padding: EdgeInsets.symmetric(
                                  vertical: responsive.hp(2),
                                  horizontal: responsive.wp(5)),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 1.5,
                                    offset: Offset(0.5, 1.0),
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: MySpaces.marginHorizontal(context),
                                  ),
                                  Center(
                                    child: Text(
                                      'Completa los datos del formulario.',
                                      style: MyTextStyles.title(context),
                                    ),
                                  ),
                                  SizedBox(
                                    height: MySpaces.marginHorizontal3(context),
                                  ),
                                  _InputWidget(
                                    controlName: 'title',
                                    hintText: 'Título',
                                    icon: Icons.description,
                                    validationMessageRequired:
                                        'Este campo es obligatorio',
                                    suffixIcon: false,
                                    controller: _,
                                  ),
                                  SizedBox(
                                    height: MySpaces.marginHorizontal2(context),
                                  ),
                                  _InputWidget(
                                    controlName: 'description',
                                    hintText: 'Descripción',
                                    icon: Icons.description,
                                    validationMessageRequired:
                                        'Este campo es obligatorio',
                                    suffixIcon: false,
                                    controller: _,
                                  ),
                                  SizedBox(
                                    height: MySpaces.marginHorizontal2(context),
                                  ),
                                  DropdownButtonFormField<String>(
                                    value: _.initialPriority,
                                    items: _.priorities
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (String? value) {
                                      _.form?.controls['priority']
                                          ?.patchValue(value);
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.play_arrow,
                                        color: AppColors.primaryColor,
                                        size: responsive.dp(2),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Por favor, seleccione una opción';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  _priorityLegend(context, 'Alta',
                                      'Prioridad 1 ,Prioridad 2, Prioridad 3'),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  _priorityLegend(context, 'Media',
                                      'Prioridad 4 ,Prioridad 5, Prioridad 6, Prioridad 7'),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  _priorityLegend(context, 'Baja',
                                      'Prioridad 8 ,Prioridad 9, Prioridad 10'),
                                  SizedBox(
                                    height: MySpaces.marginHorizontal3(context),
                                  ),
                                  Center(
                                    child: SizedBox(
                                      width: responsive.wp(80),
                                      child: ReactiveFormConsumer(
                                        builder: (context, form, child) {
                                          return OutlinedButton(
                                            onPressed: () => _.submit(),
                                            style: ButtonStyle(
                                              shape: MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10), // <-- Radius
                                              )),
                                              side: MaterialStateProperty.all(
                                                  const BorderSide(
                                                      color: AppColors
                                                          .accentColor)),
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.white),
                                              overlayColor:
                                                  MaterialStateProperty.all(
                                                      AppColors.accentColor
                                                          .withOpacity(0.3)),
                                            ),
                                            child: AnimatedContainer(
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              child: Obx(
                                                () => _.isProcess.value
                                                    ? const CircularProgressIndicator()
                                                    : Text(
                                                        "Guardar",
                                                        style: MyTextStyles
                                                                .button(context)
                                                            .copyWith(
                                                                color: AppColors
                                                                    .accentColor),
                                                      ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    CustomProgress(isLoading: _.isLoading)
                  ],
                )),
              ),
            ));
  }

  RichText _priorityLegend(
      BuildContext context, String type, String description) {
    return RichText(
      text: TextSpan(
          text: '   $type: ',
          style: MyTextStyles.small(context)
              .copyWith(color: Colors.black87, fontWeight: FontWeight.w500),
          children: [
            TextSpan(
              text: description,
              style:
                  MyTextStyles.small(context).copyWith(color: Colors.black87),
            ),
          ]),
    );
  }
}

class _InputWidget extends StatelessWidget {
  const _InputWidget({
    required this.controlName,
    required this.validationMessageRequired,
    required this.icon,
    required this.hintText,
    required this.suffixIcon,
    required this.controller,
  });

  final String controlName;
  final String validationMessageRequired;
  final String hintText;
  final IconData icon;
  final bool suffixIcon;
  final FormController controller;

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return ReactiveTextField(
      formControlName: controlName,
      validationMessages: {
        ValidationMessage.required: (error) => validationMessageRequired
      },
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        prefixIcon: Icon(
          icon,
          color: AppColors.primaryColor,
          size: responsive.dp(2),
        ),
        hintText: "Escribe aquí",
        labelStyle: const TextStyle(color: Colors.blueGrey),
        hintStyle:
            const TextStyle(color: Colors.black26, fontStyle: FontStyle.italic),
        labelText: hintText,
      ),
    );
  }
}
