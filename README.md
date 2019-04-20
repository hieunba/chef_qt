# qt Cookbook
This Chef cookbook installs Qt and Qt Creator opensource editions

## Supported OSs
- Windows 10
- Windows Server 2012 R2

# Usage

To install qt, include default recipe to the run_list. To install qt Creator, include qtcreator recipe to the run_list.

By default, this cookbook installs qt version 5.9.2 and qt Creator version 4.8.2

# Attributes

Download source for qt or qt Creator can be customized by modifying attribute `['qt']['source']` or `['qtcreator']['source']` accordingly.

However, to ensure idempotency, please update `['qt']['version']` or `['qtcreator']['version']` if the customized download url from another version.

# Recipes

## default

Install qt opensource edition

## qtcreator

Install qt Creator opensource edition

# Author

Author:: Nghiem Ba Hieu (hnghiemba@pm.me)
