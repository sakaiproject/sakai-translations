# Sakai Translations Pipeline
Keep sakai translations up to date.
This project allows you to use a Jenkins server to download translations and create a patch ready to apply in order to keep sakai translations updated.

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
