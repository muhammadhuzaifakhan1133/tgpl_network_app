import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/widgets/custom_app_bar.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/module_applications/module_applications_controller.dart';
import 'package:tgpl_network/features/module_applications/widgets/module_application_container.dart';

class ModuleApplicationsView extends StatelessWidget {
  final String module;
  final String subModule;
  const ModuleApplicationsView({
    super.key,
    required this.module,
    required this.subModule,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Builder(
              builder: (context) {
                return _moduleApplicationCustomBar();
              },
            ),
            const SizedBox(height: 15),
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  final state = ref.watch(
                    moduleApplicationsAsyncControllerProvider(subModule),
                  );
            
                  return state.when(
                    data: (data) => ListView.builder(
                      itemCount: data.length,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      itemBuilder: (context, index) {
                        return ModuleApplicationContainer(
                          application: data[index],
                          submodule: subModule,
                        );
                      },
                    ),
                    error: (e, s) => Text("Error: $e"),
                    loading: () => Center(child: CircularProgressIndicator()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  CustomAppBar _moduleApplicationCustomBar() {
    return CustomAppBar(
      title: "Applications (45)",
      subtitle: "",
      showBackButton: true,
      subtitleWidget: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: module,
              style: AppTextstyles.googleInter400Grey14.copyWith(
                decoration: TextDecoration.underline,
                fontSize: 13,
              ),
            ),
            TextSpan(
              text: ' / ',
              style: AppTextstyles.googleInter400Grey14.copyWith(fontSize: 13),
            ),
            TextSpan(
              text: subModule,
              style: AppTextstyles.googleInter400Grey14.copyWith(
                decoration: TextDecoration.underline,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
      showSearchIcon: true,
      showFilterIcon: false,
    );
  }
}
