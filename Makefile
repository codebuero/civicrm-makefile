DRUPAL_FOLDER=volumes/civicrm

DRUPAL_VERSION=7.54
CIVICRM_VERSION=4.6.30

DRUPAL_SOURCE=https://github.com/drupal/drupal/archive/$(DRUPAL_VERSION).zip
DRUPAL_TRANSLATION_SOURCE=http://ftp.drupal.org/files/translations/7.x/drupal/drupal-$(DRUPAL_VERSION).de.po

CIVICRM_SOURCE=https://download.civicrm.org/civicrm-$(CIVICRM_VERSION)-drupal.tar.gz
CIVICRM_TRANSLATION_SOURCE=https://download.civicrm.org/civicrm-$(CIVICRM_VERSION)-l10n.tar.gz

build: folder download drupal drupal_translation civicrm civicrm_translation

folder:
	mkdir -p $(DRUPAL_FOLDER)

drupal_translation:
	mv drupal-$(DRUPAL_VERSION).de.po $(DRUPAL_FOLDER)/profiles/standard/translations/

drupal:
	unzip $(DRUPAL_VERSION).zip -d .
	mv ./drupal-$(DRUPAL_VERSION)/* $(DRUPAL_FOLDER)
	rm -rf drupal-$(DRUPAL_VERSION) $(DRUPAL_VERSION).zip

civicrm_translation:
	tar xzfv civicrm-$(CIVICRM_VERSION)-l10n.tar.gz
	mv civicrm/l10n $(DRUPAL_FOLDER)/sites/all/modules/civicrm
	rm -rf civicrm

civicrm:
	tar xzfv civicrm-$(CIVICRM_VERSION)-drupal.tar.gz
	mv civicrm $(DRUPAL_FOLDER)/sites/all/modules
	rm -rf civicrm civicrm-$(CIVICRM_VERSION)-drupal.tar.gz

download:
	wget $(DRUPAL_SOURCE)
	wget $(DRUPAL_TRANSLATION_SOURCE)
	wget $(CIVICRM_SOURCE)
	wget $(CIVICRM_TRANSLATION_SOURCE)
