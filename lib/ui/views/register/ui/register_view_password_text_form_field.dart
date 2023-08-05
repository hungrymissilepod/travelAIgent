import 'package:fancy_password_field/fancy_password_field.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:travel_aigent/ui/views/register/register_viewmodel.dart';
import 'package:travel_aigent/ui/views/register/ui/register_view_text_form_field_error_text.dart';

class RegisterViewPasswordFancyTextFormField extends ViewModelWidget<RegisterViewModel> {
  const RegisterViewPasswordFancyTextFormField({super.key});

  @override
  Widget build(BuildContext context, RegisterViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: <Widget>[
          FancyPasswordField(
            controller: viewModel.passwordController,
            passwordController: viewModel.fancyPasswordController,
            strengthIndicatorBuilder: (double strength) {
              return FancyPasswordStrengthIndicator(
                strength: strength,
              );
            },
            showPasswordIcon: null,
            obscureText: viewModel.obscurePasswordText,
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.lock_rounded,
              ),
              suffixIcon: GestureDetector(
                onTap: () => viewModel.toggleObscurePasswordText(),
                child: Icon(
                  viewModel.obscurePasswordText ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Colours.accent,
                ),
              ),
              errorStyle: const TextStyle(
                fontSize: 14,
              ),
              hintText: 'Password',
            ),
            onChanged: (String? value) => viewModel.rebuildUi(),
          ),

          /// [FancyPasswordStrengthIndicator] only appears if strength is greater than 0.0
          /// So we show this as a placeholder only when [passwordController] is empty
          Visibility(
            visible: viewModel.passwordController.text.isEmpty,
            child: const FancyPasswordStrengthIndicator(
              strength: 0.0,
            ),
          ),
        ],
      ),
    );
  }
}

class FancyPasswordStrengthIndicator extends StatelessWidget {
  const FancyPasswordStrengthIndicator({
    super.key,
    required this.strength,
  });

  final double strength;

  String _getPasswordStrengthLabel() {
    if (strength == 0.0) {
      return 'Very Weak';
    } else if (strength < 0.25) {
      return 'Weak';
    } else if (strength < 0.5) {
      return 'Fair';
    } else if (strength < 0.75) {
      return 'Good';
    }
    return 'Strong';
  }

  Color _getPasswordStrengthColor() {
    if (strength == 0.0) {
      return Colors.grey;
    } else if (strength < 0.25) {
      return Colors.red;
    } else if (strength < 0.5) {
      return Colors.orange;
    } else if (strength < 0.75) {
      return Colors.lightGreen;
    }
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                'Password strength',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                _getPasswordStrengthLabel(),
                style: TextStyle(
                  color: _getPasswordStrengthColor(),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          LinearPercentIndicator(
            padding: EdgeInsets.zero,
            percent: strength,
            lineHeight: 8,
            progressColor: _getPasswordStrengthColor(),
            backgroundColor: Colors.grey.shade200,
            barRadius: const Radius.circular(20),
            animateFromLastPercent: true,
            animation: true,
            animationDuration: 100,
          ),
        ],
      ),
    );
  }
}
