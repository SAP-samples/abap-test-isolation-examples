# ABAP Test Isolation Examples
[![REUSE status](https://api.reuse.software/badge/github.com/SAP-samples/abap-test-isolation-examples)](https://api.reuse.software/info/github.com/SAP-samples/abap-test-isolation-examples)

This repository contains examples for all currently available test isolation tools in the ABAP Platform. 

## The Idea
The idea of this repository is to show how to use any test environment, helper class and some common design patterns that help with isolating your code under test from its depended-on components.

## How To Use This Repository
If you want to isolate your code under test from the components it uses, you need to take a look at what your depended-on component is. Each isolation technique for a specific kind of depended-on component is used separate test class of the global class ZATI_CL_CODE_UNDER_TEST. 
The table below shows which test class uses which tool to isolate against which kind of depended-on component.

Test Class | Depended-On Component | Tool | First Release
----- | ----- | ------ | ------
ltc_call_other_object | Classes | Self-made test doubles | With ABAP OO
ltc_call_other_object_fw | Classes | [ABAP Object Oriented Test Double Framework](https://help.sap.com/docs/ABAP_PLATFORM/c238d694b825421f940829321ffa326a/804c251e9c19426cadd1395978d3f17b.html?locale=en-US) | SAP BASIS 740 SP9
ltc_call_function_module | Function Modules | [Function Module Test Double Framework](https://help.sap.com/docs/SAP_S4HANA_CLOUD/25cf71e63940453397a32dc2b7676947/75964f284aa9435da40c4d82e111f276.html?locale=en-US) | SAP NetWeaver 756
ltc_select_database_table | Database Tables and CDS Entities | [ABAP SQL Test Double Framework](https://help.sap.com/docs/ABAP_PLATFORM/c238d694b825421f940829321ffa326a/1432ca1fc7b547d493f691cdd09245ae.html?locale=en-US) | SAP NetWeaver 752
ltc_select_cds_entity | Database Artefacts which are used in CDS | [ABAP CDS Test Double Framework](https://help.sap.com/docs/ABAP_PLATFORM_NEW/c238d694b825421f940829321ffa326a/cbedc08ff4de48ffa8d04d3067ef08e7.html?locale=en-US) | SAP NetWeaver 751
ltc_call_authority_check | Authority Checks | [Classic ABAP Authority Check Test Helper API](https://help.sap.com/docs/ABAP_PLATFORM_NEW/c238d694b825421f940829321ffa326a/6500d4d8f89a4743a6c0513d659a475b.html?locale=en-US) | SAP NetWeaver 755
ltcl_call_rap_bo_tx_bf_dbl | RAP Business Objects | [Transactional Buffer Double Support](https://help.sap.com/docs/SAP_S4HANA_CLOUD/25cf71e63940453397a32dc2b7676947/0337944d45994a3ba7482421cdfe36c8.html) | SAP NetWeaver 757
ltcl_call_rap_bo_mock_eml_api | RAP Business Objects | [Mock EML API Support](https://help.sap.com/docs/SAP_S4HANA_CLOUD/25cf71e63940453397a32dc2b7676947/4fa0e8a6ea0d4c45bec1afdc1ac6bd49.html?locale=en-US) | SAP NetWeaver 757
Standard class /DMO/ZZ_BP_X_REVIEW_R_AGENCYTP | RAP Business Object Events | [Event Test Double Framework](https://help.sap.com/docs/abap-cloud/abap-rap/developing-test-classes-for-agency-reference-scenario) | SAP NetWeaver 757

Also, you can check show cases here [Used Frameworks and Tools](https://help.sap.com/docs/abap-cloud/abap-rap/used-frameworks-and-tools)

## Requirements
You need a system with an ABAP runtime and [abapGit](https://github.com/abapGit/abapGit).

## Download and Installation
You can pull the code with [abapGit](https://github.com/abapGit/abapGit) to any system with an ABAP runtime.

## How to obtain support
[Create an issue](https://github.com/SAP-samples/abap-test-isolation-examples/issues) in this repository if you find a bug or have questions about the content.
 
For additional support, [ask a question in SAP Community](https://answers.sap.com/questions/ask.html).

## Code of Conduct
If you want to contribute to this repository, please check our [Code of Conduct](https://github.com/SAP-samples/abap-test-isolation-examples/blob/main/CODE_OF_CONDUCT.md).

## Contributing
Please feel free to check our [Contribution-Guide](https://github.com/SAP-samples/abap-test-isolation-examples/blob/main/CONTRIBUTING.md).

## License
Copyright (c) 2023 SAP SE or an SAP affiliate company. All rights reserved. This project is licensed under the Apache Software License, version 2.0 except as noted otherwise in the [LICENSE](LICENSE) file.
