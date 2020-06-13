# Sakai Translations Pipeline

This project keeps the scripts for automatic Sakai translation into several locales using Transifex.
If you are interested in translate Sakai go to Transifex (https://www.transifex.com/apereo/) and request your locale or start to collaborate in any locale.

## How to apply your translations

You need to translate and review all strings for the locale you are interested in. If you have remaining or unreviewed translations the patch generated will be partially in english.

Now go to community Jenkins server and download the patch for yor locale from here: https://jenkins.nightly.sakaiproject.org/job/sakai-translations/job/master/

If your locale is not included in the list please send an issue here (https://github.com/sakaiproject/sakai-translations/issues) to ask for your locale to be included.

Now you have to fork sakai repo and clone your fork to create your translation patch:

```
git clone https://github.com/<myforkedaccount>/sakai
git checkout -b SAK-TranslationJiraTicket
git apply --whitespace=nowarn translation_<your_locale>.patch
git add .
git commit -m "SAK-TranslationJiraTicket Uploading translations for <your locale>."
git push origin SAK-TranslationJiraTicket
```

Then go to GitHub and create a new Pull Request and wait for review.

# Advanced

This information is for administrators to install this in a new Jenkins server or to do the work that Jenkins does manually.

# Installation
- Install a Jenkins 2.x server with pipeline plugins (default installation).
- You also need python available to run transifex scripts and git 1.7.8 or above.
- Add _Pipeline Utility_ Steps plugin.
- Add _HTML Publisher_ plugin.
- Create a Multibranch Pipeline job in Jenkins.
- Set this repo url as source url (or your own fork).
- Change the translation.properties to add your LOCALE (it must be supported locale in transifex sakai project)

# Run
After running master branch, you'll have one file for each LOCALE with the patch to apply in Sakai in order to update translations. The job only export reviewed translations from transifex.

# Upload translations
You can upload translations to some module and locale directly from your computer. For example, if you have one property file translated and you don't want to start from scracth in transifex.

You will need docker. 

```
git clone https://github.com/sakaiproject/sakai
git clone https://github.com/sakaiproject/sakai-translations
cp -r sakai-translations/l10n sakai/.
```

Now you will have a l10n folder inside sakai.

```
cd sakai-translations
docker build -t transifex-cli .
```

Now you have a docker image ready to do the job.
The transifex client will ask you for an API token. (https://docs.transifex.com/client/introduction)

```
docker run --rm -v ${PWD}:/base -w /base/l10n transifex-cli python tmx.py init
docker run --rm -v ${PWD}:/base -w /base/l10n transifex-cli python tmx.py --help
```

*WARNING:* Transifex client has change and probably you have to skip setup process in the new version. Just open tmx.py and change the call to init of tx client adding '--skipsetup'.

```
subprocess.call(['tx', 'init', '--skipsetup'])
```

# Example

Import translations (locale xxx) from an existing property file to a not translated module in transifex.

```
docker run --rm -v ${PWD}:/base -w /base/l10n transifex-cli python tmx.py update -p -l xxx rubrics
```

Now you will have a .po file inside l10n/xxx/rubrics.po. You can upload with another command or using transifex web interface.

```
docker run --rm -v ${PWD}:/base -w /base/l10n transifex-cli python tmx.py upload -l xxx rubrics
```

You can do both actions using a single command:

```
docker run --rm -v ${PWD}:/base -w /base/l10n transifex-cli python tmx.py upload -u -l xxx rubrics
```

You probably need a transifex token for run some commands so try to mound your local transifex file.

```
docker run --rm -v ${PWD}:/base -v ~/.transifexrc:/root/.transifexrc -w /base/l10n transifex-cli python tmx.py ...
```

