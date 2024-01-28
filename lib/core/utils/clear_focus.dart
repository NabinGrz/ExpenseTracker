import 'package:flutter/widgets.dart';

/// Used to unfocus from the currently focused FocusNode

void clearFocus() => FocusManager.instance.primaryFocus?.unfocus();
